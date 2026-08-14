#define _GNU_SOURCE
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <wayland-client.h>

#include "security-context-v1-client-protocol.h"

static struct wp_security_context_manager_v1 *manager;

static void handle_global(void *data, struct wl_registry *registry, uint32_t name,
                          const char *interface, uint32_t version) {
	if (strcmp(interface, wp_security_context_manager_v1_interface.name) == 0)
		manager = wl_registry_bind(registry, name,
		                          &wp_security_context_manager_v1_interface, 1);
}

static void handle_global_remove(void *data, struct wl_registry *registry, uint32_t name) {
}

static const struct wl_registry_listener registry_listener = {
	.global = handle_global,
	.global_remove = handle_global_remove,
};

int main(int argc, char *argv[]) {
	if (argc != 3) {
		fprintf(stderr, "usage: %s <socket-path> <app-id>\n", argv[0]);
		return 2;
	}

	prctl(PR_SET_PDEATHSIG, SIGTERM);
	if (getppid() == 1)
		return 1;

	const char *path = argv[1];
	const char *app_id = argv[2];

	struct sockaddr_un addr = { .sun_family = AF_UNIX };
	int n = snprintf(addr.sun_path, sizeof(addr.sun_path), "%s.pending", path);
	if (n < 0 || (size_t)n >= sizeof(addr.sun_path)) {
		fprintf(stderr, "socket path too long: %s\n", path);
		return 1;
	}

	struct wl_display *display = wl_display_connect(NULL);
	if (!display) {
		fprintf(stderr, "failed to connect to wayland display\n");
		return 1;
	}

	struct wl_registry *registry = wl_display_get_registry(display);
	wl_registry_add_listener(registry, &registry_listener, NULL);
	wl_display_roundtrip(display);

	if (!manager) {
		fprintf(stderr, "compositor does not support wp_security_context_manager_v1\n");
		return 1;
	}

	int listen_fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
	if (listen_fd < 0) {
		perror("socket");
		return 1;
	}

	unlink(addr.sun_path);
	if (bind(listen_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("bind");
		return 1;
	}
	if (listen(listen_fd, 128) < 0) {
		perror("listen");
		return 1;
	}

	/* close_fd[1] stays open for the lifetime of this process: the compositor
	   serves the listener until it hangs up. */
	int close_fd[2];
	if (pipe(close_fd) < 0) {
		perror("pipe");
		return 1;
	}

	struct wp_security_context_v1 *context =
		wp_security_context_manager_v1_create_listener(manager, listen_fd, close_fd[0]);
	wp_security_context_v1_set_sandbox_engine(context, "org.bubblewrap");
	wp_security_context_v1_set_app_id(context, app_id);
	wp_security_context_v1_commit(context);

	if (wl_display_roundtrip(display) < 0) {
		fprintf(stderr, "failed to commit security context\n");
		return 1;
	}

	/* Publishing the path last makes its existence mean "restrictions applied". */
	if (rename(addr.sun_path, path) < 0) {
		perror("rename");
		return 1;
	}

	close(listen_fd);
	close(close_fd[0]);
	wl_display_disconnect(display);

	pause();
	return 0;
}
