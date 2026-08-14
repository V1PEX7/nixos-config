#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
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

	const char *path = argv[1];
	const char *app_id = argv[2];

	struct sockaddr_un addr = { .sun_family = AF_UNIX };
	if (strlen(path) >= sizeof(addr.sun_path)) {
		fprintf(stderr, "socket path too long: %s\n", path);
		return 1;
	}
	strcpy(addr.sun_path, path);

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

	unlink(path);
	if (bind(listen_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("bind");
		return 1;
	}
	if (listen(listen_fd, 128) < 0) {
		perror("listen");
		return 1;
	}

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

	close(listen_fd);
	close(close_fd[0]);
	wl_display_disconnect(display);

	/* The compositor accepts connections until close_fd hangs up. */
	pause();
	return 0;
}
