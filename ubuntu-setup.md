# Ubuntu Setup

This document shows some of the steps I apply to newly installed Ubuntu systems (typically virtual machines) to make them better fit my needs.

## First steps

##### Change keyboard layout to Swiss (german)  
`sudo dpkg-reconfigure keyboard-configuration` -> Generic 105-key (Intl) PC -> Switzerland -> Switzerland -> default -> No compose key

##### Fix Ubuntu privacy
`wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash`

## Install new things

### Install from repository
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install wireshark vim colordiff tree libxml2-utils xmlstarlet dos2unix gnome-session-fallback

Re-Login with "GNOME Flashback (Metacity)"

### Eclipse

Install Eclipse with file from http://www.eclipse.org

## Make working more pleasant

##### Bring back gear-wheel in case it disappeared
Alt-right-click on top bar -> Add to panel -> Indicator Applet Complete

##### Auto-Login
Gear-wheel (top right corner) -> System settings -> User accounts -> *User* -> Automatic Login

##### Disable screensaver / lock
Gear-wheel (top right corner) -> System settings -> Brightness & Lock

##### Configure Firefox
- Preferences -> General -> Downloads -> Always ask me where to save files
- Preferences -> Privacy -> Tracking -> Tell sites that I do not want to be tracked
- Preferences -> Advanced -> Data choices -> Disable all
- Preferences -> Advanced -> General -> Browsing -> [X] Use autoscrolling, [ ] Use smooth scrolling

##### Configure Terminal
- Increase scrollbuffer
- Black font on white background

### Configure Eclipse

##### Switch Tabs with Ctrl-Tab
Window -> Preferences -> General -> Keys -> Command: "Change Next Editor" (Ctrl-F6) to Ctrl-Tab and "Previous Editor" to Shift-Ctrl-Tab

##### Install Vrapper plugin
Help -> Install new software -> Work with: http://vrapper.sourceforge.net/update-site/stable/ -> Enter
Vrapper -> Choose Vrapper

##### Show line numbers
Right-click to the left of the source code -> Show line numbers

##### Show 80 characters border line
Window -> Preferences -> General -> Editors -> Text Editors -> Show print margin

##### Enable code-folding
Proceed according to http://kosiara87.blogspot.in/2011/12/how-to-install-coffee-bytes-plugin-in.html . Needs file eclipse-folding-plugin.tar.gz (MD5: 4fa41ee14d58ac3c0a50ce346d4b3daa )

##### Increase console output buffer size
Window -> Preferences -> Run/Debug -> Console -> Console buffer size

### Configure Git

##### Let there be colours
    git config --global color.ui true

##### Ignore Vim swap files
    echo '.*.sw?' >> ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global

##### Use Vim as Git's editor
    git config --global core.editor "vim"

## Performance tweaks

##### Don't save file/directory access times
In `/etc/fstab` add the options `noatime,nodiratime`.

##### Remove packages
     sudo apt-get autoremove libreoffice-* transmission-* deja-dup zeitgeist bluez brasero rhythmbox gnome-screensaver apport thunderbird unity-webapps-common


