#  | tail -n +2 | rofi -dmenu -p "Wi-Fi SSID" 

set res (echo -e "$(nmcli -g SSID,SECURITY,BARS device wifi list)\ntoogle wifi\ndisconnect" | uniq | column -t -s \t | rofi -dmenu -P "Wi-fi ")
if test -z (echo $res)
    notify-send "Exited wifi" -t 1000
    exit 0
end
# | awk -F : '{print $1}')
if test (echo $res | awk -F : '{print $1}') = "toogle wifi"
    if test (nmcli radio wifi) = enabled
        nmcli radio wifi off
        notify-send "Dectivated wifi" -t 10000
    else
        nmcli radio wifi on
        notify-send "Activated wifi" -t 10000
    end
    exit 0
end
if test (echo $res | awk -F : '{print $1}') = "disconnect"
    nmcli con down uuid (nmcli -g UUID,TYPE con show --active | grep "802-11-wireless" | awk -F : '{print $1}')
    notify-send "Disconnected" -t 10000
    exit 0
end

set ssid (echo $res | awk -F : '{print $1}')
if ! test (nmcli device wifi connect $ssid)
    set security (echo $res | awk -F : '{print $2}')
    echo $res
    echo $security
    if test $security = "WPA2"
    or test $security = "WEP"
    or test $security = "WPA1"
    or test $security = "WPA1 WPA2"
        set password (echo -en "" | rofi -dmenu -password -p "Password: " -mesg "Enter the password of the network" -lines 0)
        if test (nmcli dev wifi con $ssid password $password)
            notify-send "Connected to $ssid" -t 10000
            exit 0
        end
        notify-send "Could not connect to $ssid, maybe password is wrong ($password)" -t 10000
        exit 0
    end
    notify-send "Cannot connect to this wifi: Unsupported security $security" -t 10000 -u critical
    exit 1
end
notify-send "Connected to $ssid" -t 10000
# ask for password
    