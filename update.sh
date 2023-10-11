#!/bin/fish
#
mkdir -p doom
mkdir -p config
mkdir -p config/BetterDiscord

pacman -Qe > packages.txt

set config ~sergi/.config
cp "$config/BetterDiscord/themes" config/BetterDiscord/ -r
cp ~sergi/.doom.d/config.el ~sergi/.doom.d/custom.el ~sergi/.doom.d/init.el ~sergi/.doom.d/packages.el ~sergi/.doom.d/snippets ~sergi/.doom.d/themes doom -r
mkdir -p config/spotify-tui
cp ~sergi/.config/spotify-tui/config.yml ~sergi/.config/spotify-tui/frappe.yml ~sergi/.config/spotify-tui/latte.yml ~sergi/.config/spotify-tui/macchiato.yml ~sergi/.config/spotify-tui/mocha.yml config/spotify-tui

mkdir -p config/nvim/lua/custom/
cp "$config/nvim/lua/custom" "config/nvim/lua/custom" -r

for f in fish helix hypr kitty mako pipewire rofi swaylock wallpapers wlogout eww fish kitty zathura;
    cp "$config/$f" "config" -r
end

rm config/spotify-tui/client.yml
rm config/spotify-tui/.spotify_token_cache.json
# activate as user spotifyd and emacs service
# add username and password for spotifyd
# i should change my secrets
