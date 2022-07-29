<p class='image code for the git hub display sorry for the inconvenience of markdown reading' align="center">
  <img src="https://user-images.githubusercontent.com/89363735/161449318-2979760e-e44e-4ece-8bcd-56ae3507a13f.png" alt="![pacshweep](https://user-images.githubusercontent.com/89363735/161449318-2979760e-e44e-4ece-8bcd-56ae3507a13f.png)"/>
</p>

# /!\ Disclaimer : the man pages and this README are written for the final project, for now the BETA can only list your out of date packages for the aur database, just run the script which is for now pretty simple to understand
# Pacshweep - The package cleaner
## Quick overview
A tool to clean your arch system from it's deprecated and out-of-date AUR packages. Pacshweep allows you to know what packages are deprecated on your system and can help you remove or replace them, see man for more details. Coded with GNU bash, and ncurses.

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
To save space if the files are going to be re downloaded each time, then they are deleted after each use.

## Running

An internet connection is needed if you havent set UPDATE_TIME in pac.conf and run pacshweep at least once.

> $ pacshweep --help

Or 

>$ pacswheep-gui


## Dependencies

**Necessary software :**
- wget
- wc
- rm
- cat
- sed
- paste
- install
- sort
- comm

**For the GUI :**
 - stdio.h  
- stdlib.h  
- ncurses.h

