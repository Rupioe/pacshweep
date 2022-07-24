![pacshweep](https://user-images.githubusercontent.com/89363735/161449318-2979760e-e44e-4ece-8bcd-56ae3507a13f.png)

# Pacshweep - The package cleaner
## Quick overview
A tool to clean your arch system from it's deprecated and out-of-date AUR packages. Pacshweep allows you to know what AUR packages are deprecated on your system and can help you remove or replace them, see man for more details. Coded with GNU bash, version 5.1.4(1)-release.

## Install from source
>$ git clone https://github.com/Rupioe/pacshweep
>$ cd pacshweep


**Tested on Linux 64 bits :**
>$ make
>$ sudo make install

## Install binary
**Arch Linux :**
>$ yay -S pacshweep

## GUI
There is a GUI available, it is automatically included in the AUR packages and included is the make if you install from source.
If you don't want to compile the GUI you can use
>$ make nogui

## Configuration
You can configure a minimum time to wait before re-downloading the database(s) at pacswheep execution.
Edit the config file :
>$ vim ~/.config/pacswheep/pac.conf

And input your chosen value :

UPDATE_TIME=1d

is the default value, use nothing to download each run, no suffix for ticks, s for seconds, mi for minutes, d for days, m for months and y for years.

## Running

> $ pacshweep --help

Or 

>$ pacswheep-gui


## Dependencies

**Necessary software :**
cmake >= *3.18*
testé avec GNU make *4.3*
testé avec cc *10.2.1*

**For the GUI :**
 - stdio.h  
- stdlib.h  
- ncurses.h

## Contact me
rupioe@protonmail.com for bug report.
