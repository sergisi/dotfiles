#!/bin/fish
#
mkdir -p doom
mkdir -p config
mkdir -p config/BetterDiscord

pacman -Qe > packages.txt

set config ~sergi/.config
cp "$config/BetterDiscord/themes" config/BetterDiscord/ -r
cp ~sergi/.doom.d/config.el ~sergi/.doom.d/custom.el ~sergi/.doom.d/init.el ~sergi/.doom.d/packages.el ~sergi/.doom.d/snippets ~sergi/.doom.d/themes doom -r
for f in fish helix hypr kitty mako pipewire rofi spotify-tui swaylock wallpapers waybar wlogout;
    cp "$config/$f" "config" -r
end

rm config/spotify-tui/client.yml
rm config/spotify-tui/.spotify_token_cache.json
# activate as user spotifyd and emacs service
# add username and password for spotifyd
# i should change my secrets
