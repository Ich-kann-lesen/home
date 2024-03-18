#!/nix/store/7q1b1bsmxi91zci6g8714rcljl620y7f-bash-5.2-p15/bin/bash

installdir=/

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
defaultpanel="$XDG_CONFIG_HOME/herbstluftwm/panel.sh"

[ -x "$defaultpanel" ] || defaultpanel="$installdir/nix/store/43syrfrpxc3d7dyhbhkh1i3wpzq8knfz-herbstluftwm-0.9.5/etc/xdg/herbstluftwm/panel.sh"

panelcmd="${1:-$defaultpanel}"

herbstclient emit_hook quit_panel

for i in $(herbstclient list_monitors | cut -d':' -f1) ; do
    "$panelcmd" $i &
done
