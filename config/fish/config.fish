if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path /home/sergi/.my-programs/


set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/sergi/.ghcup/bin # ghcup-env
