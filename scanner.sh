#!/bin/bash

function check_root() {
	if [ $EUID -ne 0 ]; then
		echo """
		        ###################
                        #Must run as root!#
		        ###################
		      
		                           """

		exit 1
	else
		clear
	fi
}

check_nmap() {
        if ! command -v nmap &> /dev/null; then
echo "Nmap not installed. Installing..."
apt update && apt install -y nmap
clear

        fi
}

basic_scan() {
        read -p "Enter target IP address: " target
nmap $target | tee scan.txt
        clear
        echo "Scan results in scan.txt"
}

fullport_scan() {
        read -p "Enter target IP address: " target
nmap -p- $target | tee fullport.txt
        clear
        echo "Scan results in fullport.txt"
}

tcp_scan() {
        read -p "Enter target IP address: " target
nmap -sS $target | tee tcp.txt
        clear
        echo "Scan results in tcp.txt"
}

udp_scan() {
        read -p "Enter target IP address: " target
nmap -sU $target | tee udp.txt
        clear
        echo "Scan results in udp.txt"
}

version_scan() {
        read -p "Enter target IP address: " target
nmap -sV $target | tee version.txt
        clear
        echo "Scan results in version.txt"
}

check_root
check_nmap

echo "####################################
#Welcome to the Nmap Scanner Script#
####################################

"

choice=-1

while [[ $choice -ne 0 && $choice -le 5 ]];

do

echo "Choose type of scan:"
echo "1. Basic Scan"
echo "2. Full port scan"
echo "3. TCP scan"
echo "4. UDP scan"
echo "5. Version scan"
echo "0. Exit"

read -p "Enter your choice: " choice


case $choice in
        1) basic_scan ;;
        2) fullport_scan ;;
        3) tcp_scan ;;
        4) udp_scan ;;
        5) version_scan ;;
        0) echo "Exiting..." ;;
        *) echo "Invalid choice. Exiting..." ;;

esac

done
