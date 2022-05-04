alias gti='git'
#alias tmux='tmux -2'
alias less='less -R'
alias diff='colordiff'
alias dc='cd'
alias glog='git log --oneline --graph --color --all --decorate'
alias ls='ls --color -lvha'
alias lsblk='lsblk -f'
alias nano='vim'
alias mkdir='mkdir -p'
#alias dd='sudo dd bs=4M status=progress'
alias console='tmux new-session -d -s console screen /dev/ttyUSB0 115200;tmux send-keys -t console ENTER;tmux split-window -t console;tmux split-window -h -t console;tmux a -t console'
alias getevdi='git clone https://github.com/DisplayLink/evdi.git'
alias home='cd ~'
#alias homevpn='sudo wg-quick up wg0'
#alias killhomevpn='sudo wg-quick down wg0'
#alias localvpn='sudo wg-quick up wg1'
#alias killlocalvpn='sudo wg-quick down wg1'
#alias publicvpn='sudo wg-quick up wg2'
#alias killpublicvpn='sudo wg-quick down wg2'
alias homevpn='nmcli con up homevpn-wg0'
alias killhomevpn='nmcli con down homevpn-wg0'
alias localvpn='nmcli con up localvpn-wg1'
alias killlocalvpn='nmcli con down localvpn-wg1'
alias publicvpn='nmcli con up publicvpn-wg2'
alias killpublicvpn='nmcli con down publicvpn-wg2'
alias gdb='gdb --batch --ex run --ex bt --ex q --args'
alias update='sudo pacman -Syuu --needed --noconfirm && pacaur -Syuu --noconfirm'
#alias update='sudo apt-get update && sudo apt-get dist-upgrade -y'
alias speedtest='speedtest-cli --secure'
alias speedtest-file='speedtest-cli --secure --single'
#alias clearpaccache='sudo paccache -r && sudo paccache -ruk0'
alias createpw='date +%s | sha256sum | base64 | head -c 64 ; echo'
alias hiber='systemctl hibernate'
alias suspend='systemctl suspend'
alias rkupdate='sudo rkhunter --propupd'
alias huntrk='sudo rkhunter --propupd && sudo rkhunter --check --sk'
alias opensocks='/home/martin/bin/ownscripts/opensocks'
alias killsocks='/home/martin/bin/ownscripts/killsocks'
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist
