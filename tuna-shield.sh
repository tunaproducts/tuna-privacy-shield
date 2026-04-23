#!/bin/bash

# --- MURAT PRIVACY SHIELD v7.5 (OFFICIAL RELEASE) ---
# Developed by Tuna Products © 2026
# All Rights Reserved. For Educational Purposes Only.

# Color Palette
G='\033[0;32m' # Green
R='\033[0;31m' # Red
C='\033[0;36m' # Cyan
Y='\033[1;33m' # Yellow
B='\033[0;34m' # Blue
P='\033[0;35m' # Purple
W='\033[1;37m' # White
NC='\033[0m'   # No Color

INTERFACE="wlan0" 
NIPE_DIR="$HOME/nipe"

function display_banner() {
    clear
    echo -e "${C}"
    echo "       _                        "
    echo "       \`*-.                    "
    echo "        )  \          _..-'\`*-. "
    echo "       / .  )        ( ,     \\  "
    echo "      (  \`*-.        ) .  (   | "
    echo "       ) .  )       ( ,     /   "
    echo "      (  \`*-.        ) .  (   | "
    echo "       ) .  )        ) .  (   | "
    echo "      (  \`*-.        ( ,     /   "
    echo "       ) .  )        ) .  (   | "
    echo "      (  \`*-.      _..-'\`*-.  /   "
    echo "       ) .  )     ( ,       | /    "
    echo "------------------------------------------------"
    echo -e "${Y}    Murat Privacy Shield v7.5 | Tuna Products${NC}"
    echo -e "${W}      All Rights Reserved. Educational Use Only.${NC}"
    echo "------------------------------------------------"
}

function check_deps() {
    if [[ ! -d "$NIPE_DIR" ]]; then
        echo -e "${B}[i] Initializing dependency installation...${NC}"
        git clone https://github.com/htrgouvea/nipe $NIPE_DIR > /dev/null 2>&1
        cd $NIPE_DIR && sudo cpan install Try::Tiny Class::Accessor IO::Socket::IP Config::Simple Readonly > /dev/null 2>&1
        sudo perl nipe.pl install > /dev/null 2>&1
    fi
}

function start_anonymity() {
    check_deps
    echo -e "${B}[i] Executing stealth protocols...${NC}"
    NEW_HOST="STATION-$(shuf -i 1000-9999 -n 1)"
    sudo hostnamectl set-hostname $NEW_HOST
    echo "127.0.0.1 $NEW_HOST" | sudo tee -a /etc/hosts > /dev/null 2>&1
    sudo ip link set $INTERFACE down > /dev/null 2>&1
    sudo macchanger -r $INTERFACE > /dev/null 2>&1
    sudo ip link set $INTERFACE up > /dev/null 2>&1
    sudo service tor start > /dev/null 2>&1
    (cd $NIPE_DIR && sudo perl nipe.pl start) > /dev/null 2>&1
    echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf > /dev/null
    echo -e "${G}[✓] Privacy tunnel online. Network identity masked.${NC}"
}

function stop_anonymity() {
    echo -e "${R}[!] Reverting to standard protocols...${NC}"
    (cd $NIPE_DIR && sudo perl nipe.pl stop) > /dev/null 2>&1
    sudo service tor stop > /dev/null 2>&1
    sudo ip link set $INTERFACE down > /dev/null 2>&1
    sudo macchanger -p $INTERFACE > /dev/null 2>&1
    sudo ip link set $INTERFACE up > /dev/null 2>&1
    sudo hostnamectl set-hostname kali
    history -c
    sudo find /var/log -type f -exec truncate -s 0 {} \; > /dev/null 2>&1
    sudo systemctl restart NetworkManager > /dev/null 2>&1
    echo -e "${G}[✓] Identity restored. Forensic logs cleared.${NC}"
}

while true; do
    display_banner
    echo -e "${G}1) Activate Anonymity Mode${NC}"
    echo -e "${R}2) Return to Sivil Mode & Wipe Tracks${NC}"
    echo -e "${P}3) Identity Status Check${NC}"
    echo -e "${B}4) Product Info & Legal Terms${NC}"
    echo -e "${Y}5) Secure Exit${NC}"
    echo "------------------------------------------------"
    echo -en "${C}Select Action: ${NC}"
    read secim

    case $secim in
        1) start_anonymity; echo -en "\n${Y}Press Enter to return...${NC}"; read ;;
        2) stop_anonymity; echo -en "\n${Y}Press Enter to return...${NC}"; read ;;
        3) echo -e "${B}[i] Status:${NC}"; (cd $NIPE_DIR && sudo perl nipe.pl status); echo -en "\n${Y}Press Enter...${NC}"; read ;;
        4) 
            echo -e "${C}------------------------------------------------${NC}"
            echo -e "${W}DEVELOPER:${NC} Tuna Products © 2026"
            echo -e "${W}LEGAL:${NC} All Rights Reserved."
            echo -e "${R}DISCLAIMER:${NC} This tool is strictly for educational"
            echo -e "purposes and authorized penetration testing only."
            echo -e "Tuna Products is not responsible for any misuse."
            echo -e "${C}------------------------------------------------${NC}"
            echo -e "${B}TECH SPECS:${NC}"
            echo -e " - Tor-Multi-Layer-Tunneling"
            echo -e " - Automated-MAC-Spoofing"
            echo -e " - DNS-Leak-Protection"
            echo -e " - Forensic-Wipe-Technology"
            echo -e "${C}------------------------------------------------${NC}"
            echo -en "${Y}Press Enter...${NC}"; read ;;
        5) echo -e "${C}Session terminated. Goodbye.${NC}"; exit ;;
        *) echo -e "${R}Error: Invalid input.${NC}"; sleep 1 ;;
    esac
done
