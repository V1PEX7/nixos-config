{ pkgs, ... }:
let
  t = import ../theme.nix;
in
{
  wayland.windowManager.mango = {
    enable = true;

    settings = {
      "exec-once" = "bash ~/.config/mango/autostart.sh";

      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,20"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "QT_QPA_PLATFORM,wayland"
        "GDK_BACKEND,wayland"
        "XDG_THEME_DESKTOP_SCHEME,prefer-dark"
        "XDG_CURRENT_DESKTOP,wlroots"
        "NIXOS_OZONE_WL,1"
      ];

      monitorrule = [
        "name:DP-1,width:2560,height:1440,refresh:180,x:0,y:0,vrr:1"
        "name:DP-2,width:1920,height:1080,refresh:240,x:-1920,y:360"
      ];

      xkb_rules_layout = "us,ru";
      xkb_rules_options = "grp:alt_shift_toggle";
      numlockon = 1;
      repeat_rate = 25;
      repeat_delay = 600;

      cursor_theme = "Bibata-Modern-Classic";
      cursor_size = 20;
      sloppyfocus = 1;
      warpcursor = 1;

      mouse_accel_profile = 0;
      mouse_accel_speed = 0.0;
      trackpad_accel_profile = 0;
      trackpad_accel_speed = 0.0;

      gappih = 2;
      gappiv = 2;
      gappoh = 5;
      gappov = 5;
      borderpx = 2;
      focuscolor = t.mango.focus;
      bordercolor = t.mango.border;
      urgentcolor = t.mango.urgent;
      scratchpadcolor = t.mango.scratchpad;
      globalcolor = t.mango.global;
      overlaycolor = t.mango.overlay;
      maximizescreencolor = t.mango.maximize;
      border_radius = 5;
      no_radius_when_single = 0;
      no_border_when_single = 0;
      focused_opacity = 1.0;
      unfocused_opacity = 1.0;
      rootcolor = t.mango.root;

      shadows = 1;
      shadow_only_floating = 0;
      layer_shadows = 1;
      shadows_size = 10;
      shadows_blur = 15;
      shadows_position_x = 0;
      shadows_position_y = 5;
      shadowscolor = t.mango.shadow;

      blur = 1;
      blur_layer = 1;
      blur_optimized = 1;
      blur_params_num_passes = 3;
      blur_params_radius = 5;
      blur_params_noise = 0.08;
      blur_params_brightness = 1;
      blur_params_contrast = 0.89;
      blur_params_saturation = 1.2;

      animations = 1;
      layer_animations = 1;
      animation_type_open = "slide";
      animation_type_close = "slide";
      layer_animation_type_open = "fade";
      layer_animation_type_close = "fade";
      animation_fade_in = 1;
      animation_fade_out = 1;
      fadein_begin_opacity = 0.6;
      fadeout_begin_opacity = 0.9;
      animation_duration_open = 250;
      animation_duration_close = 200;
      animation_duration_move = 300;
      animation_duration_tag = 0;
      animation_duration_focus = 100;
      animation_curve_open = "0.46,1.0,0.29,1";
      animation_curve_move = "0.46,1.0,0.29,1";
      animation_curve_close = "0.08,0.92,0,1";
      animation_curve_tag = "0.46,1.0,0.29,1";
      animation_curve_focus = "0.46,1.0,0.29,1";
      tag_animation_direction = 1;

      scroller_default_proportion = 0.5;
      scroller_default_proportion_single = 1.0;
      scroller_proportion_preset = "0.33,0.5,0.67,0.8,1.0";
      scroller_structs = 20;
      scroller_focus_center = 0;
      scroller_prefer_center = 1;
      scroller_ignore_proportion_single = 1;
      edge_scroller_pointer_focus = 1;

      new_is_master = 0;
      default_mfact = 0.55;
      default_nmaster = 1;
      smartgaps = 0;
      center_master_overspread = 1;
      center_when_single_stack = 1;

      circle_layout = "scroller,tile,center_tile,monocle,grid";

      tagrule = [
        "id:1,no_hide:1,layout_name:tile,mfact:0.5"
        "id:2,no_hide:1,layout_name:tile,mfact:0.5"
        "id:3,no_hide:1,layout_name:tile,mfact:0.5"
        "id:4,no_hide:1,layout_name:tile,mfact:0.5"
        "id:5,no_hide:1,layout_name:scroller"
        "id:6,no_hide:1,layout_name:monocle"
        "id:7,no_hide:1,layout_name:tile"
        "id:8,no_hide:1,layout_name:grid"
        "id:9,no_hide:1,layout_name:monocle"
      ];

      enable_hotarea = 0;
      hotarea_size = 10;
      hotarea_corner = 2;
      ov_tab_mode = 0;
      overviewgappi = 5;
      overviewgappo = 30;

      scratchpad_width_ratio = 0.8;
      scratchpad_height_ratio = 0.85;
      single_scratchpad = 1;

      xwayland_persistence = 1;
      allow_tearing = 1;
      allow_shortcuts_inhibit = 1;
      focus_on_activate = 0;
      focus_cross_monitor = 0;
      exchange_cross_monitor = 0;
      focus_cross_tag = 0;
      view_current_to_back = 0;
      enable_floating_snap = 1;
      snap_distance = 30;
      cursor_hide_timeout = 5;
      drag_corner = 4;
      drag_warp_cursor = 1;
      drag_tile_to_tile = 1;
      idleinhibit_ignore_visible = 0;
      axis_bind_apply_timeout = 100;

      windowrule = [
        "isfloating:1,appid:^xdg-desktop-portal-gtk$"
        "isfloating:1,appid:^xdg-desktop-portal-gnome$"
        "isfloating:1,title:^Share Screen$"
        "isfloating:1,title:^Screen Share$"
        "isfloating:1,appid:com.gabm.satty"
        "isfloating:1,isoverlay:1,appid:^chromium-browser$,title:^Picture-in-Picture$"
        "isfloating:1,isoverlay:1,appid:^librewolf$,title:^Picture-in-Picture$"
        "isterm:1,appid:^kitty$"
        "isterm:1,appid:^foot$"
        "isterm:1,appid:^alacritty$"
        "isfloating:1,width:1000,height:700,appid:^thunar$"
        "scroller_proportion:0.67,appid:^chromium-browser$"
        "scroller_proportion:0.67,appid:^librewolf$"
        "isfloating:1,appid:^steam$"
        "isfloating:0,appid:^steam$,title:^Steam$"
        "tags:6,force_tearing:1,appid:^steam_app_"
      ];

      layerrule = [
        "noanim:1,noblur:1,layer_name:selection"
        "noblur:1,noshadow:1,layer_name:^waybar$"
      ];

      bind = [
        "SUPER,t,spawn,foot"
        "SUPER,e,spawn,thunar"
        "SUPER,w,spawn,chromium"
        "SUPER,s,spawn,librewolf"
        "SUPER,space,spawn,fuzzel"
        "SUPER,v,spawn_shell,cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"

        "NONE,Print,spawn_shell,grim -g \"$(slurp)\" -t ppm - | satty -f -"
        "SUPER+SHIFT,s,spawn_shell,freeze-screenshot"
        "CTRL,Print,spawn_shell,grim - | satty -f -"
        "SUPER+SHIFT,t,spawn_shell,grim -g \"$(slurp)\" -t png - | convert - -resize 300% -sharpen 0x1 png:- | tesseract -l eng+rus stdin stdout | wl-copy && notify-send \"OCR\" \"Текст скопирован\""

        "SUPER+SHIFT,w,spawn,wallpicker"

        "SUPER,q,killclient,"
        "SUPER,d,togglemaximizescreen,0"
        "SUPER,f,togglefullscreen"
        "SUPER+SHIFT,f,togglefakefullscreen"
        "SUPER,c,togglefloating"
        "SUPER+CTRL,c,centerwin"
        "SUPER,g,toggleglobal"
        "SUPER+SHIFT,o,toggleoverlay"
        "SUPER,n,minimized,"
        "SUPER+SHIFT,n,restore_minimized,"
        "SUPER,grave,focuslast"

        "SUPER,Tab,toggleoverview"
        "ALT,Tab,focusstack,next"

        "SUPER,h,focusdir,left"
        "SUPER,j,focusdir,down"
        "SUPER,k,focusdir,up"
        "SUPER,l,focusdir,right"
        "SUPER,Left,focusdir,left"
        "SUPER,Down,focusdir,down"
        "SUPER,Up,focusdir,up"
        "SUPER,Right,focusdir,right"
        "SUPER+ALT,j,focusstack,next"
        "SUPER+ALT,k,focusstack,prev"

        "SUPER+CTRL,h,exchange_client,left"
        "SUPER+CTRL,j,exchange_client,down"
        "SUPER+CTRL,k,exchange_client,up"
        "SUPER+CTRL,l,exchange_client,right"
        "SUPER+CTRL,Left,exchange_client,left"
        "SUPER+CTRL,Down,exchange_client,down"
        "SUPER+CTRL,Up,exchange_client,up"
        "SUPER+CTRL,Right,exchange_client,right"
        "SUPER+CTRL+ALT,j,exchange_stack_client,next"
        "SUPER+CTRL+ALT,k,exchange_stack_client,prev"

        "SUPER+SHIFT,h,focusmon,left"
        "SUPER+SHIFT,l,focusmon,right"
        "SUPER+SHIFT,Left,focusmon,left"
        "SUPER+SHIFT,Right,focusmon,right"
        "SUPER+SHIFT+CTRL,h,tagmon,left,0"
        "SUPER+SHIFT+CTRL,l,tagmon,right,0"
        "SUPER+SHIFT+CTRL,Left,tagmon,left,0"
        "SUPER+SHIFT+CTRL,Right,tagmon,right,0"

        "SUPER,1,view,1"
        "SUPER,2,view,2"
        "SUPER,3,view,3"
        "SUPER,4,view,4"
        "SUPER,5,view,5"
        "SUPER,6,view,6"
        "SUPER,7,view,7"
        "SUPER,8,view,8"
        "SUPER,9,view,9"
        "SUPER,0,view,0"

        "SUPER+ALT,1,tag,1"
        "SUPER+ALT,2,tag,2"
        "SUPER+ALT,3,tag,3"
        "SUPER+ALT,4,tag,4"
        "SUPER+ALT,5,tag,5"
        "SUPER+ALT,6,tag,6"
        "SUPER+ALT,7,tag,7"
        "SUPER+ALT,8,tag,8"
        "SUPER+ALT,9,tag,9"

        "SUPER+SHIFT,1,tagsilent,1"
        "SUPER+SHIFT,2,tagsilent,2"
        "SUPER+SHIFT,3,tagsilent,3"
        "SUPER+SHIFT,4,tagsilent,4"
        "SUPER+SHIFT,5,tagsilent,5"
        "SUPER+SHIFT,6,tagsilent,6"
        "SUPER+SHIFT,7,tagsilent,7"
        "SUPER+SHIFT,8,tagsilent,8"
        "SUPER+SHIFT,9,tagsilent,9"

        "SUPER+CTRL,1,toggleview,1"
        "SUPER+CTRL,2,toggleview,2"
        "SUPER+CTRL,3,toggleview,3"
        "SUPER+CTRL,4,toggleview,4"
        "SUPER+CTRL,5,toggleview,5"
        "SUPER+CTRL,6,toggleview,6"
        "SUPER+CTRL,7,toggleview,7"
        "SUPER+CTRL,8,toggleview,8"
        "SUPER+CTRL,9,toggleview,9"

        "SUPER,Page_Up,viewtoleft_have_client"
        "SUPER,Page_Down,viewtoright_have_client"
        "SUPER,u,viewtoleft_have_client"
        "SUPER,i,viewtoright_have_client"
        "SUPER+CTRL,Page_Up,tagtoleft"
        "SUPER+CTRL,Page_Down,tagtoright"
        "SUPER+CTRL,u,tagtoleft"
        "SUPER+CTRL,i,tagtoright"
        "SUPER,BackSpace,view,-1"

        "SUPER,a,toggle_scratchpad"
        "SUPER,Return,toggle_scratchpad,foot,none,0.7,0.75,foot"

        "SUPER+SHIFT,r,switch_proportion_preset"
        "SUPER,minus,set_proportion,-0.05"
        "SUPER,equal,set_proportion,+0.05"
        "SUPER,BracketLeft,scroller_stack,left"
        "SUPER,BracketRight,scroller_stack,right"

        "SUPER,z,zoom"
        "SUPER+SHIFT,Left,setmfact,-10"
        "SUPER+SHIFT,Right,setmfact,+10"
        "SUPER+SHIFT,Up,incnmaster,+1"
        "SUPER+SHIFT,Down,incnmaster,-1"

        "SUPER+SHIFT,space,switch_layout"
        "SUPER+CTRL+ALT,s,setlayout,scroller"
        "SUPER+CTRL+ALT,t,setlayout,tile"
        "SUPER+CTRL+ALT,r,setlayout,right_tile"
        "SUPER+CTRL+ALT,c,setlayout,center_tile"
        "SUPER+CTRL+ALT,m,setlayout,monocle"
        "SUPER+CTRL+ALT,g,setlayout,grid"
        "SUPER+CTRL+ALT,d,setlayout,deck"
        "SUPER+CTRL+ALT,v,setlayout,vertical_scroller"

        "SUPER+SHIFT,equal,incgaps,+2"
        "SUPER+SHIFT,minus,incgaps,-2"
        "SUPER+SHIFT,g,togglegaps"
        "SUPER+SHIFT,b,toggle_render_border"

        "SUPER+SHIFT,Return,setkeymode,resize"
        "SUPER+CTRL,Return,setkeymode,move"

        "CTRL+ALT,Delete,quit"
        "SUPER+SHIFT,p,spawn_shell,wlr-randr --output DP-1 --off && wlr-randr --output DP-2 --off"
      ];

      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
        "SUPER+CTRL,btn_right,killclient"
      ];

      axisbind = [
        "SUPER,UP,viewtoleft_have_client"
        "SUPER,DOWN,viewtoright_have_client"
        "SUPER+SHIFT,UP,focusstack,prev"
        "SUPER+SHIFT,DOWN,focusstack,next"
      ];

      gesturebind = [
        "none,left,3,focusdir,left"
        "none,right,3,focusdir,right"
        "none,up,3,focusdir,up"
        "none,down,3,focusdir,down"
        "none,left,4,viewtoleft_have_client"
        "none,right,4,viewtoright_have_client"
        "none,up,4,toggleoverview"
        "none,down,4,toggleoverview"
      ];

      switchbind = [
      ];

      source = [
      ];
    };

    extraConfig = ''
      keymode=common
      bind=SUPER,r,reload_config
      bindl=NONE,XF86AudioRaiseVolume,spawn_shell,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0
      bindl=NONE,XF86AudioLowerVolume,spawn_shell,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
      bindl=NONE,XF86AudioMute,spawn_shell,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindl=NONE,XF86AudioMicMute,spawn_shell,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindl=NONE,XF86AudioPlay,spawn,playerctl play-pause
      bindl=NONE,XF86AudioStop,spawn,playerctl stop
      bindl=NONE,XF86AudioPrev,spawn,playerctl previous
      bindl=NONE,XF86AudioNext,spawn,playerctl next
      bindl=NONE,XF86MonBrightnessUp,spawn_shell,brightnessctl --class=backlight set +10%
      bindl=NONE,XF86MonBrightnessDown,spawn_shell,brightnessctl --class=backlight set 10%-

      keymode=resize
      bind=NONE,h,resizewin,-40,0
      bind=NONE,l,resizewin,+40,0
      bind=NONE,k,resizewin,0,-40
      bind=NONE,j,resizewin,0,+40
      bind=NONE,Left,resizewin,-40,0
      bind=NONE,Right,resizewin,+40,0
      bind=NONE,Up,resizewin,0,-40
      bind=NONE,Down,resizewin,0,+40
      bind=SHIFT,h,smartresizewin,left
      bind=SHIFT,l,smartresizewin,right
      bind=SHIFT,k,smartresizewin,up
      bind=SHIFT,j,smartresizewin,down
      bind=NONE,Escape,setkeymode,default
      bind=NONE,Return,setkeymode,default
      bind=SUPER+SHIFT,Return,setkeymode,default

      keymode=move
      bind=NONE,h,smartmovewin,left
      bind=NONE,l,smartmovewin,right
      bind=NONE,k,smartmovewin,up
      bind=NONE,j,smartmovewin,down
      bind=NONE,Left,movewin,-40,0
      bind=NONE,Right,movewin,+40,0
      bind=NONE,Up,movewin,0,-40
      bind=NONE,Down,movewin,0,+40
      bind=NONE,c,centerwin
      bind=NONE,Escape,setkeymode,default
      bind=NONE,Return,setkeymode,default
      bind=SUPER+CTRL,Return,setkeymode,default

      keymode=default
    '';
  };

  xdg.configFile."mango/autostart.sh".source = pkgs.writeShellScript "mango-autostart" ''
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    systemctl --user restart xdg-desktop-portal.service xdg-desktop-portal-wlr.service

    waybar &

    if [ -f "$HOME/.config/wallpaper" ]; then
      swaybg -i "$HOME/.config/wallpaper" -m fill &
    fi

    cliphist wipe
    wl-clip-persist --clipboard regular --reconnect-tries 0 &
    wl-paste --type text --watch cliphist store &
    QT_QPA_PLATFORM=wayland Throne &
  '';
}
