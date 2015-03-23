#!/bin/bash

UPDATE_BASE=https://dl.dropboxusercontent.com/u/43551467/garquiscript.sh 

BSVC=https://dl.dropboxusercontent.com/u/43551467/Linux_bsvc-2.1%2B_Estatica.tar.gz
GEDIT=https://dl.dropboxusercontent.com/u/43551467/m68kasm.lang
SUBL=https://dl.dropboxusercontent.com/u/43551467/M68k-Assembly.tar.gz
CUR_DIR="$(pwd)"
VERSION=0.4
SELF=$(basename $0)
bold=`tput bold`
normal=`tput sgr0`
input="ma niqqa"

HAS_GEDIT=false
HAS_SUBL=false
HAS_XDOTOOL=false

#echo $EXEC

if [[ -e /usr/bin/gedit ]]
	then
		HAS_GEDIT=true
	fi
if [[ -e /usr/bin/subl ]]
	then
		HAS_SUBL=true
	fi
if [[ -e /usr/bin/xdotool ]]
	then
		HAS_XDOTOOL=true
	fi


if [[ ! $HAS_XDOTOOL ]]
	then	
		echo "We need to install some useful utilities to use this script correctly. Do you want to continue? [Y/n]"
		read input
		if [[ $input == "Y" || $input == "y" || $input == "" ]]
			then
				echo "In order to install the program properly, you may need to enter your password. Please, follow the steps."
				sudo echo -ne
				echo "Installing utilities..."
				sudo apt-get install xdotool
				clear
				printf "\nInstallation completed.\n\n"
				echo "-------------------------------${bold}HELP${normal}-------------------------------"
			fi
	fi
	
if [[ $HAS_GEDIT && ! -f /usr/share/gtksourceview-3.0/language-specs/m68kasm.lang ]]
	then
		if [[ $input == "ma niqqa" ]]
			then
				echo "We have detected you have Gedit installed, which is really useful to edit .s files. Do you want to install a plugin to improve readibility? [Y/n] 
(you may need to enter your administration password)"
				read input
			fi
		if [[ $input == "Y" || $input == "y" || $input == "" ]]
		then
			echo "Installing utilities..."
			wget --quiet --output-document=m68kasm.lang $GEDIT
			sudo cp m68kasm.lang /usr/share/gtksourceview-3.0/language-specs/
			rm m68kasm.lang
		fi
fi

if [[ $HAS_SUBL && ! -d ~/.config/sublime-text-3/Packages/M68k-Assembly && -d ~/.config/sublime-text-3 ]]
	then
		if [[ $input == "ma niqqa" ]]
			then
				echo "We have detected that you have Sublime Text 3 installed, which is really useful to edit .s files. Do you want to install a  
plugin to improve readibility? [Y/n]"
				read input
			fi	
		if [[ $input == "Y" || $input == "y" || $input == "" ]]
		then
			echo "Installing utilities..."
			wget --quiet --output-document=M68k-Assembly.tar.gz $SUBL
			cd ~/.config/sublime-text-3/Packages/
			tar -zxf $CUR_DIR/M68k-Assembly.tar.gz 
			cd $CUR_DIR
			rm M68k-Assembly.tar.gz
		fi
fi
		 
		

function download {

	wget --quiet --output-document=$1 $2 &

	while [[ $(jobs | grep "Running" | wc -l) -gt 0 ]]
		do
			echo -ne "Downloading files.  \r"
			sleep 0.5
			echo -ne "Downloading files.. \r"
			sleep 0.5
			echo -ne "Downloading files...\r"
			sleep 0.5
	done

	printf "\rDone!                    \n"

}

function inst {

	if [[ ! -f Linux_bsvc-2.1+_Estatica.tar.gz ]]
		then
			download Linux_bsvc-2.1+_Estatica.tar.gz $BSVC
		fi

	echo "In order to install the program properly, you may need to enter your password. Please, follow the steps."
	cd /
	umask 22
	
	if [[ -d /usr/local/bsvc ]]
		then
			echo "It seems that a version of the emulator is already installed. Do you want to reinstall it? [Y/n]"
			read input
			if [[ $input == "Y" || $input == "y" || $input == "" ]]
				then
					sudo rm -r /usr/local/bsvc
			else
				printf "\nThanks for using GarquiScript, $USER!\n\n"
				exit 0
			fi
		fi
	
	echo "Removing old files and copying new ones..."
	sleep 0.1
	
	sudo tar -zxf $CUR_DIR/Linux_bsvc-2.1+_Estatica.tar.gz

	if [[ $? != 0 ]]
		then
			echo "An unexpected error occured. Please, try again later."
			exit $?
	fi

	sudo mv /usr/local/bsvc/bin/UI/bsvc.ad /usr/local/bsvc/bin/UI/bsvc.ad.bak
	sudo touch /usr/local/bsvc/bin/UI/bsvc.ad 

	echo "export PATH="'$PATH'":/usr/local/bsvc/bin" >> ~/.bashrc
}

function execute {

	bsvc practica.setup &
	sleep 1
	WID=`xdotool search "BSVC: Version 2.1"`
	xdotool windowactivate --sync $WID
	xdotool key ctrl+l
	sleep 0.5
	setxkbmap us
	xdotool type $1.h68
	setxkbmap es
	sleep 0.5
	xdotool key Return

}

if [[ $1 == "--help" || $1 == "-h" || $1 == "" ]]
	then 
		clear
		printf "Compiles .s files using 68kasm program and executes them using bsvc emulator. It writes your commands and open your configuration files by itslef.\n\n"
		echo "Usage:  ${bold}garquiscript.sh${normal} [OPTION] NAME"
			printf "\t${bold}Name:${normal}\t\tname of the file without extension.\n\n"
			
		echo "OPTION:"
			printf "\t${bold}-c:${normal} Only compiles the given file without executing it.\n"
			printf "\t${bold}-m:${normal} Compiles the file, execute it and open memory window within the emulator.\n"
			printf "\t${bold}-p:${normal} Compiles the file, execute it and open program listing window within the emulator.\n\n"
			
		echo "Special options:"		
			printf "\t${bold}-h, --help:${normal} Shows this help text.\n"
			printf "\t${bold}--version:${normal} Shows actual version of the script.\n"
			printf "\t${bold}--update:${normal} Auto-updates the script to the latest version.\n"
			printf "\t${bold}--install:${normal} Downloads and installs all emulator files.\n"
		
		printf "\nYou can ask my cat now how this script works.\n\n"
		exit 0	

elif [[ $1 == "--install" ]]
	then
		inst
elif [[ $1 == "--update" ]]
	then
		# Download new version
		download $0.tmp $UPDATE_BASE
		# Copy over modes from old version
		OCTAL_MODE=$(stat -c '%a' $0)
		chmod $OCTAL_MODE $0.tmp
		# Overwrite old file with new
		mv -f $0.tmp $0
		
		if [[ $? == 0 ]]
			then
				NEWVER=$(head garquiscript.sh | grep "VERSION=" | sed 's/[^0-9.]//g')
				if [[ $NEWVER != $VERSION ]]
					then
						echo "Succesfully updated to version $NEWVER!"
					else
						echo "No updates found."
				fi
				exit 0
			else
				echo "There was an error performing the update, please try again later. Exit code: $?"
				exit 1
		fi
		
elif [[ $1 == "--version" ]]
	then
		printf "\n${bold}GarquiScript version:${normal} $VERSION\n\n"
		#printf "${bold}Last updated${normal} on $(date -r $SELF).\n\n"
		exit 0				
		
elif [[ $(echo $1 | grep "-" | grep -c "c") -gt 0 ]]
	then
		68kasm -l $2.s

elif [[ ! $2 ]]
	then
		68kasm -l $1.s
		if [[ $? == 22 ]]
			then
				execute $1
			fi
		
else
	68kasm -l $2.s
	if [[ $? == 22 ]]
		then
			execute $2
			if [[ $(echo $1 | grep "-" | grep -c "p") -gt 0 ]]
				then
					xdotool windowactivate --sync $WID
					xdotool key ctrl+p
				fi
			if [[ $(echo $1 | grep "-" | grep -c "m") -gt 0 ]]
				then
					xdotool windowactivate --sync $WID
					xdotool key ctrl+m
				fi					
		fi
	
fi

