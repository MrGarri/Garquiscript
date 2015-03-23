# garquiscript
A small script to compile and execute m68k files.

This is meant to be used if you're studying Computer Ingeneering on FIUPM (ETSIINF). You can obviously use this if
you need to and you are not studying this, but this was the main purpose.

It's all explained the first time you fire up the script, but just in case, this script will need to install some
utilities to work properly. It's ok if you don't want to, but give them a chance. You can check the main program I
use here in the following link: https://github.com/jordansissel/xdotool.

The other utilities are optional. They're only needed to improve the readibility of the m68k files when using Gedit
or Sublime Text 3.

Example:

    ./garquiscript.sh -mp <filename> -> This command will compile the file, launch the emulator,
                                        load the necessary program to execute it and open program
                                        listing and memory viewer windows within the emulator.
