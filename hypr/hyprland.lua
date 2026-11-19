-------------------
-- VARIÁVEIS
-------------------
local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "yazi"
local menu = "rofi"

-------------------
-- DARK MODE (env vars)
-------------------
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("GTK_USE_PORTAL", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("TERMINAL", "kitty")

-------------------
-- MONITORS
-------------------
hl.monitor({ output = "*", mode = "preferred", position = "auto", scale = "auto" })
-- Tela do notebook (Dell Inspiron 15 3511, 15,6" 1080p): auto escolhia 1.5
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1.25 })

-------------------
-- AUTOSTART
-------------------
hl.on("hyprland.start", function()
    -- exec-once = $terminal
    -- exec-once = nm-applet &
    -- hl.exec_cmd executa na hora; hl.dsp.exec_cmd só cria um dispatcher (pra binds)
    hl.exec_cmd("qs -p $HOME/.config/quickshell/yoru")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("swaync")
    hl.exec_cmd("gammastep -O 5000")
    hl.exec_cmd("hypridle") -- bloqueio por inatividade (config em hypridle.conf)
end)

-------------------
-- PERMISSIONS -- API confirmada no Hyprland 0.57.2 (config de exemplo gerado):
-- hl.permission(path, categoria, modo) com argumentos posicionais.
-- Mudanças aqui exigem reiniciar o Hyprland (não aplicam no reload).
-------------------
hl.config({
    ecosystem = { enforce_permissions = 1 },
})
hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-------------------
-- LOOK AND FEEL
-------------------
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        ["col.active_border"] = "rgba(666666ff)",
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 15,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(000000aa)",
        },
        blur = {
            enabled = true,
            size = 4,
            passes = 2,
            vibrancy = 0.15,
        },
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

-------------------
-- ANIMATIONS
-------------------
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-------------------
-- WINDOW RULES
-------------------
hl.window_rule({
    name = "float-yoru-settings",
    match = { title = "^Yoru Settings$" },
    float = true,
    center = true,
})

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "vscode-blur",
    match = { class = "code" },
    opacity = 0.9,
})

-------------------
-- LAYER RULES
-------------------
hl.layer_rule({ name = "waybar_blur", match = { namespace = "waybar" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ name = "rofi_blur", match = { namespace = "rofi" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ name = "swaync_blur", match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ name = "swaync_notif_blur", match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })

-------------------
-- LAYOUTS
-------------------
hl.config({
    dwindle = { preserve_split = true },
    master  = { new_status = "master" },
})

-------------------
-- INPUT
-------------------
hl.config({
    input = {
        kb_layout    = "br",
        kb_variant   = "abnt2",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad     = { natural_scroll = true },
    },
})

-- 3 dedos na horizontal = trocar workspace (API confirmada no 0.57.2)
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-------------------
-- DEVICES (API confirmada no 0.57.2)
-- Regras por nome de periférico; sem efeito se o dispositivo não existir.
-------------------
hl.device({ name = "beken-2.4g-wireless-device", sensitivity = 0 })

-------------------
-- KEYBINDINGS
-------------------
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("qs -p $HOME/.config/quickshell/yoru ipc call wallpaper toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- hl.dsp.exit() nao existe mais no Lua -- usar "uwsm stop" no lugar do dispatch antigo
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || uwsm stop"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " -e /usr/bin/yazi"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + P",
    hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Screenshots/$(date +"%Y-%m-%d_%H-%M-%S").png | wl-copy'))

-- Foco entre janelas
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Trocar workspaces (0-9)
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("ALT + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll entre workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mover/redimensionar com o mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimídia / brilho (laptop)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, release = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, release = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, release = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, release = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, release = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, release = true })

-- playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })