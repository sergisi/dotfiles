function preprocess
  echo "state>>"(hyprctl clients -j | 
    jq -c "[.[] | {id: .address, class: .class, workspace: .workspace.id}]")
  echo "activewindowv2>>"(hyprctl activewindow -j | 
    jq -c ".address" -r | cut -c 3-)
   echo "workspace>>"(hyprctl activeworkspace -j | 
    jq -c ".id")
   while read input
    echo $input
  end
end

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | preprocess