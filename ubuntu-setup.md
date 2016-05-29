# Ubuntu Setup

This document shows some of the steps I apply to newly installed Ubuntu systems (typically virtual machines) to make them better fit my needs. This is tested with Ubuntu 14.10 Desktop 64-bit.

## First steps

##### Change keyboard layout to Swiss (german)  
`sudo dpkg-reconfigure keyboard-configuration` -> Generic 105-key (Intl) PC -> Switzerland -> Switzerland -> default -> No compose key

##### Fix Ubuntu privacy
`wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash`

## Install new things

### Install from repository
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install wireshark vim colordiff tree libxml2-utils xmlstarlet dos2unix gnome-session-fallback gnome-tweak-tool vlc

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
- Preferences -> Security -> [ ] Block reported attack sites ; [ ] Block reported web forgeries
- Preferences -> Advanced -> Data choices -> Disable all
- Preferences -> Advanced -> General -> Browsing -> [X] Use autoscrolling, [ ] Use smooth scrolling
- Preferences -> Advanced -> Certificates -> [ ] Query OCSP responder servers to confirm the current validity of certificates

If Firefox doesn't recognize PDF files, but instead wants to open them with VLC, open (or create) `~/.local/share/applications/defaults.list` and add the following lines:

```
[Default Applications]
application/pdf=evince.desktop;
```

##### Configure Terminal
- Increase scrollbuffer
- Black font on white background

##### Disable subpixel font anti-aliasing 
`gnome-tweak-tool` -> Fonts -> Antialiasing -> Grayscale

##### Disable tap (on mousepad) to click

On MATE:

System -> Preferences -> Startup Applications -> Startup Programs -> Add -> `synclient MaxTapTime=0`

### Configure Eclipse

##### Switch Tabs with Ctrl-Tab
Window -> Preferences -> General -> Keys -> Command: "Change Next Editor" (Ctrl-F6) to Ctrl-Tab and "Previous Editor" to Shift-Ctrl-Tab (when working with Eclipse CDT, one needs to unbind/remap the command "Toggle Source/Header", which is mapped to Ctrl-Tab by default)

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

##### Set default push policy
Push only the current branch and only if it has a similarly named remote tracking branch on upstream (see also http://stackoverflow.com/a/17096880 ).
    git config --global push.default simple

## Performance tweaks

##### Don't save file/directory access times
In `/etc/fstab` add the options `noatime,nodiratime`.

Make sure that there are no syntax errors by remounting the changed entry, e.g. `sudo mount -o remount /`. There MUST NOT be any error messages.

##### Remove packages
     sudo apt-get autoremove libreoffice-* transmission-* deja-dup zeitgeist bluez brasero rhythmbox gnome-screensaver apport thunderbird unity-webapps-common

##### Disable border shadows
    gsettings set org.gnome.metacity compositing-manager false

##### Disable animated logos when clicking on shortcuts in the top taskbar
The animation can be disabled with `gsettings set org.gnome.desktop.interface enable-animations false`. Unfortunately the setting is not permanent. http://forum.ubuntuusers.de/topic/gnome-animationen-deaktivieren/ recommends:

Start `gnome-session-properties` and put the above command into auto start.
