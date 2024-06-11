#!/bin/fish
#
mkdir -p config
mkdir -p config/BetterDiscord

pacman -Qe > packages.txt

set config ~sergi/.config
rm -rf config  # Nuke config files
mkdir config
cp "$config/BetterDiscord/themes" config/BetterDiscord/ -r

for f in fish helix hypr kitty mako pipewire rofi swaylock wallpapers wlogout eww fish kitty zathura doom 'spotify-tui' nvim;
    mkdir "config/$f"
    cp "$config/$f" "config" -r
end

rm config/spotify-tui/client.yml
rm config/spotify-tui/.spotify_token_cache.json
# activate as user spotifyd and emacs service
# add username and password for spotifyd
# i should change my secrets
