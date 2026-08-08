#!/bin/bash
#
#  ┏┓┏┓             
#    ┃┃ ━━┏┓┏┓┏╋     
#  ┗┛┗┛  ┣┛┗┛┛┗     
#        ┛   ┏      
#            ╋┏┓┏╋┏┓
#            ┛┗┻┗┗┗┛
################################                 
                 
# Coloring scheme for notfications
ESC="\x1b["
RESET=$ESC"39;49;00m"
CYAN=$ESC"33;36m"
RED=$ESC"31;01m"
GREEN=$ESC"32;01m"

# Warning
warning(){
	echo -e "\n$RED [!] $1 $RESET\n"
	}

# Green notification
notification() {
	echo -e "\n$GREEN [+] $1 $RESET\n"
	}

# Cyan notification
notification_b() {
	echo -e "\n$CYAN [-] $1 $RESET\n"
	}


# Declarative array for random obfus mode
declare -A rndopt
   
rndopt[opt0]=" -s 1 -t 1 --no-mangling "
rndopt[opt1]=" -s 3 -t 3 "
rndopt[opt2]=" -s 1 -t 2 --no-mangling"
rndopt[opt3]=" -s 3 -t 1 "
rndopt[opt4]=" -s 1 -t 1 --layers 2"
rndopt[opt5]=" -s 2 -t 2 --no-mangling "
rndopt[opt6]=" --choose-mutators token/forcode -s 1"
rndopt[opt7]="--choose-mutators compress/gzip -s 1 "
 
 
obfs(){
   
    arg1=$1
    arg2=$2

   
    if [[ "$arg1" == "c" && "$arg2" == "default" ]]; then
        read -p "Command to Obfuscate: " cmd
        
        bashfuscator -c "$cmd" --choose-mutators token/forcode encode/xor_non_null compress/gzip -s 1  -o outfile.sh
    
    elif [[ "$arg1" == "i" && "$arg2" == "default" ]]; then
        read -p "Path to file: " infile
        
        bashfuscator --file "$infile" --choose-mutators token/forcode encode/xor_non_null compress/gzip -s 1  -o outfile.sh
        
    elif [[ "$arg1" == "c" && "$arg2" == "random" ]]; then
        read -p "Command to Obfuscate: " cmd
    
        bashfuscator -c "$cmd" rand=$[ $RANDOM % 7 ] && ${rndopt[$rand]} -o outfile.sh
    
    elif [[ "$arg1" == "i" && "$arg2" == "random" ]]; then
        read -p "Path to file: " infile
        
        bashfuscator --file "$infile" rand=$[ $RANDOM % 7 ] && ${rndopt[$rand]} -o outfile.sh
    
    elif  [[ "$arg1" == "c" && "$arg2" == "custom" ]]; then
        read -p "Command to Obfuscate: " cmd
        # If the user wants to choose their own mutators we print the list to STDOUT
        bashfuscator -l
        read -p "Enter your obfuscators:  " cstm
        bashfuscator -c "$cmd" $cstm -o outfile.sh
    
    elif [[ "$arg1" == "i" && "$arg2" == "custom" ]]; then
        read -p "Path to file: " infile
        # Same as above list to STDOUT
        bashfuscator -l
        read -p "Enter your obfuscators:  " cstm
        bashfuscator --file "$infile" $cstm -o outfile.sh
    fi
    
    
    };


# Check to see if Bashfuscator is installed
# May add function to auto install it if user desires
if ! command -v bashfucator &>/dev/null; then
    warning "Bashfuscator not found"
    sleep 2 && clear
    notification_b "Please install Bashfuscator"
    exit 1
fi


echo -e "$CYAN
     +----------------------+
     | Bashfuscator Wrapper |
     | V0.1  |----|  H3ST1A |
     +----------------------+
$RESET     
     
Please select input method.
  L-Command [1]
  L-Infile  [2]
  L-Exit    [q]
"

read -p "Choice: " choice
if [[ "$choice" == "1" ]]; then
    INPUT='c'
elif [[ "$choice" == "2" ]]; then
    INPUT='i'
elif [[ "$choice" == "q" ]]; then
    notification "Exiting..." 
    sleep 1.5 && exit 0
else
    warning "Unhandled Option"
    exit 1
fi


echo -e "

Please select option.
  L-Use random mutators for obfuscation  [1]
  L-Use custom mutators for obfuscation  [2]
  L-Use default mutators for obfiscation [3]
  L-Exit                                 [q]
"

read -p "Choice: " choice

if [[ "$choice" == "1" ]]; then
    MUTATORS='random' 
    if [[ "$INPUT" == "c" ]]; then
        obfs "$INPUT" "$MUTATORS"
    fi
elif [[ "$choice" == "2" ]]; then
    MUTATORS='custom'
    if [[ "$INPUT" == "c" ]]; then
        obfs "$INPUT" "$MUTATORS"
    fi
elif [[ "$choice" == "3" ]]; then
    MUTATORS='default'
    if [[ "$INPUT" == "c" ]]; then
        obfs "$INPUT" "$MUTATORS"
    fi
elif [[ "$choice" == "q" ]]; then
    notification "Exiting..."
    sleep 1.5 && exit 0
else
    warning "Unhandled Option"
    exit 1
fi


