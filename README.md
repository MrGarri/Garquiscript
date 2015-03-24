# Garquiscript
A small script to compile and execute m68k files. 
To do this, I'm using BSVC emulator. You can find it here: http://www4.ncsu.edu/~bwmott/bsvc/

This is meant to be used if you're studying Computer Ingeneering on FIUPM (ETSIINF). You can obviously use this if
you need to and you are not studying this, but this was the main purpose.

It's all explained the first time you fire up the script, but just in case, this script will need to install some
utilities to work properly. It's ok if you don't want to, but give them a chance. You can check the main program I
use here in the following link: https://github.com/jordansissel/xdotool.

The other utilities are optional. They're only needed to improve the readibility of the m68k files when using Gedit
or Sublime Text 3.


Right after you've downloaded the script (right-click on it and select 'Save link as...' option), open a terminal
emulator, navigate to the location the script is and execute the following command:

    chmod +x garquiscript.sh
        

**Usage**

*-h, --help:* Shows this help text. 
*--version:* Shows actual version of the script.
*--update:* Auto-updates the script to the latest version.
*--plugins:* Downloads and installs some plugins to improve readibility of source files.
*--install:* Downloads and installs all emulator files.

**Execution example**

    ./garquiscript.sh -mp <filename> -> This command will compile the file, launch the emulator,
                                        load the necessary program to execute it and open program
                                        listing and memory viewer windows within the emulator.
