# Garquiscript
A small script to compile and execute m68k files. 
To do this, I'm using BSVC emulator. You can find it <a href="http://www4.ncsu.edu/~bwmott/bsvc/" target="_blank">here</a>.

This is meant to be used if you're studying Computer Ingeneering on FIUPM (ETSIINF). You can obviously use this if
you need to and you are not studying this, but this was the main purpose.

It's all explained the first time you fire up the script, but just in case, this script will need to install some
utilities to work properly. It's ok if you don't want to, but give them a chance. You can check the main program I
use to do some really cool things <a href="https://github.com/jordansissel/xdotool" target="_blank">here</a>.

The other utilities are optional. They're only needed to improve the readibility of the m68k files when using Gedit
or Sublime Text 3.


Right after you've downloaded the script from <a href="https://raw.githubusercontent.com/MrGarri/Garquiscript/master/garquiscript.sh" target="_blank">here</a> (right-click on the link and select 'Save link as...' option), open a terminal
emulator, navigate to the location the script is and execute the following command:

    chmod +x garquiscript.sh
        

### Usage

    ./garquiscript [OPTION] FILENAME
    
The file must be specified without the extension, just by its name. By default, the script will compile the file,
execute the emulator and load the .h68 file needed to run the program. However, you can specify the following options:

*    *-c:* Only compiles the given file without executing it.
*    *-m:* Compiles the file, executes it and opens memory window within the emulator.
*    *-p:* Compiles the file, executes it and opens program listing window within the emulator.

Here are also some special options you may find useful:

*   *-h, --help:* Shows this help text.<br> 
*   *--version:* Shows actual version of the script.<br>
*   *--update:* Auto-updates the script to the latest version.<br>
*   *--plugins:* Downloads and installs some plugins to improve readibility of source files.<br>
*    *--install:* Downloads and installs all emulator files.

**Execution example**

The following command will compile the file, launch the emulator, load the necessary file to execute it and open program
listing and memory viewer windows within the emulator.

    ./garquiscript.sh -mp <filename> 
    
In case you've made some changes to your source code while the emulator was opened, there's no need to close it. Just use the script to compile the file again using the following command:

    ./garquiscript.sh -c <filename>
    
After that, reload the .h68 file into the emulator and the setup, click reset and you're done.
