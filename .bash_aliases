alias gti='git'
#alias tmux='tmux -2'
alias less='less -R'
alias diff='colordiff'
alias dc='cd'
alias nethack-online='ssh nethack@nethack.alt.org ; clear'
alias tron-online='ssh sshtron.zachlatta.com ; clear'
alias glog='git log --oneline --graph --color --all --decorate'
alias ls='ls --color -lvha'
alias lsblk='lsblk -f'
alias nano='vim'
alias mkdir='mkdir -p'
alias dd='dd bs=4M status=progress'
alias vpn='sudo openconnect vpn.kranchie.de'
alias ext_400p1='sudo cryptsetup open /dev/disk/by-uuid/ce1059f4-14fe-4a33-9291-a01f7887b29d ext_400p1 --key-file /home/martin/.keyfiles/kranchie.key'
alias ext_500p1='sudo cryptsetup open /dev/disk/by-uuid/3fe7da45-b201-4c2e-b613-808dcdeac84b ext_500p1 --key-file /home/martin/.keyfiles/kranchie.key'
alias ext_wd4tbp1='sudo cryptsetup open /dev/disk/by-uuid/70d436eb-357f-4885-9be5-20ffac0fc99c ext_wd4tb1 --key-file /home/martin/.keyfiles/hdd.key'
alias console='tmux new-session -d -s console screen /dev/ttyUSB0 115200;tmux send-keys -t console ENTER;tmux split-window -t console;tmux split-window -h -t console;tmux a -t console'