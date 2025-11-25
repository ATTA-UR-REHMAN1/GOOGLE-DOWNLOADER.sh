#!/bin/bash

# ==============================
# ATTA-UR-REHMAN GOOGLE SEARCH TOOL
# ==============================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

HISTORY_FILE="search_history.txt"

# Banner
banner() {
    clear
    echo -e "${CYAN}"
    echo "=============================================="
    echo "     ★★  ATTA-UR-REHMAN GOOGLE SEARCH TOOL  ★★"
    echo "=============================================="
    echo -e "${NC}"
}

# Save search to history file
save_history() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" >> "$HISTORY_FILE"
}

# Main menu
menu() {
    echo -e "${YELLOW}Select an option:${NC}"
    echo "1) Search Movie"
    echo "2) Search PDF"
    echo "3) Search Song"
    echo "4) Search Drama"
    echo "5) Custom Search"
    echo "6) View Search History"
    echo "0) Exit"
    echo
    read -p "Enter your choice: " choice
}

# Build Google search link
google_search() {
    local name="$1"
    local suffix="$2"

    query="${name// /+}$suffix"
    google_link="https://www.google.com/search?q=$query"

    echo
    echo -e "${GREEN}Your Google Search Link:${NC}"
    echo -e "$google_link"
    echo

    save_history "$google_link"

    # Auto-open (Enable if you want)
    # xdg-open "$google_link" > /dev/null 2>&1
}

# Main loop
while true; do
    banner
    menu

    case $choice in
        1)
            read -p "Enter movie name: " name
            google_search "$name" "+movie"
            ;;
        2)
            read -p "Enter PDF name/topic: " name
            google_search "$name" "+filetype:pdf"
            ;;
        3)
            read -p "Enter song name: " name
            google_search "$name" "+song"
            ;;
        4)
            read -p "Enter drama name: " name
            google_search "$name" "+drama"
            ;;
        5)
            read -p "Enter your search: " name
            google_search "$name" ""
            ;;
        6)
            echo -e "${CYAN}"
            echo "========== SEARCH HISTORY =========="
            if [[ -f "$HISTORY_FILE" ]]; then
                cat "$HISTORY_FILE"
            else
                echo "No history found."
            fi
            echo "===================================="
            echo -e "${NC}"
            ;;
        0)
            echo -e "${RED}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option, try again!${NC}"
            ;;
    esac

    echo
    read -p "Press Enter to return to menu..."
done
