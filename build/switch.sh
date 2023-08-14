#!/bin/sh

############################################
# Customize
############################################

# Remove branding
/usr/share/plymouth/themes/spinner/watermark.png

# Remove snap
apt-get -y remove snapd libreoffice-common || true
rm -rf /var/lib/snapd || true

# Install software
apt-get -y install falkon baloo-kf5 libqalculate22 plasma-integration libqt5multimedia5 plymouth-theme-spinner
# elementary-xfce-icon-theme

# Remove software
apt-get -y remove plymouth-theme-lubuntu-text plymouth-theme-lubuntu-logo plymouth-theme-ubuntu-text pcmanfm-qt \
lxqt-panel 2048-qt geoclue-2.0 gcr gtk2-engines-pixbuf kdeconnect plasma-framework \
vim-common htop libgtk-3-common libgtk2.0-common catdoc cracklib-runtime emacsen-common kde-cli-tools-data \
kde-config-updates plasma-discover-common

# Remove font spam
apt -y remove  fonts-deva-extra fonts-gargi fonts-gubbi fonts-gujr fonts-gujr-extra fonts-guru fonts-guru-extra \
'fonts-tlwg-*' 'fonts-smc-*' 'fonts-lohit-*' 'fonts-telu*' 'fonts-samyak-*' 'fonts-liberation*' \
'fonts-sil*' 'fonts-beng*' 'fonts-dejavu*' 'fonts-kacst*' 'fonts-khmeros*' 'fonts-oryga*'  \
'fonts-pagul*' 'fonts-lklug*' 'fonts-lao*' 'fonts-tibetan*'

# Download and install components
cd /
wget -c https://github.com/helloSystem/Menu/releases/download/continuous/Menu_Ubuntu.zip
wget -c https://github.com/helloSystem/launch/releases/download/continuous/launch_Ubuntu.zip
wget -c https://github.com/probonopd/Filer/releases/download/continuous/Filer_Ubuntu.zip
sudo mkdir -p /System
sudo unzip -o Menu_Ubuntu.zip -d /System
sudo unzip -o Filer_Ubuntu.zip -d /System
sudo unzip -o launch_Ubuntu.zip -d /
rm *.zip
cd -

sudo ln -sf /usr/bin/lxqt-leave /System/Menu.app/Shutdown

mkdir -p /etc/skel/

cd /etc/skel/

mkdir -p .config/autostart/
cat > .config/autostart/Filer.desktop <<\EOF
[Desktop Entry]
Exec=launch Filer
Name=Filer
Type=Application
Version=1.0
EOF

cat > .config/autostart/Menu.desktop <<\EOF
[Desktop Entry]
Exec=launch Menu
Name=Menu
Type=Application
Version=1.0
EOF

mkdir -p .config/lxqt/
cat > .config/lxqt/session.conf <<\EOF
[General]
__userfile__=true

[Environment]
BROWSER=launch Falkon
GTK_CSD=0
GTK_OVERLAY_SCROLLING=0
SAL_USE_VCLPLUGIN=qt5
SAL_VCL_QT5_USE_CAIRO=true
TERM=qterminal
UBUNTU_MENUPROXY=1
SUDO_ASKPASS=""
GTK_MODULES="appmenu-gtk-module"
QT_QPA_PLATFORMTHEME=kde
EOF

mkdir -p .config/qterminal.org/
cat > .config/qterminal.org/qterminal.ini <<\EOF
[General]
AskOnExit=true
BoldIntense=true
BookmarksFile=/home/rolling/.config/qterminal.org/qterminal_bookmarks.xml
BookmarksVisible=true
Borderless=false
ChangeWindowIcon=true
ChangeWindowTitle=true
CloseTabOnMiddleClick=true
ConfirmMultilinePaste=false
DisableBracketedPasteMode=false
FixedTabWidth=true
FixedTabWidthValue=500
HandleHistory=
HideTabBarWithOneTab=false
HistoryLimited=true
HistoryLimitedTo=1000
KeyboardCursorShape=0
LastWindowMaximized=false
MenuVisible=true
MotionAfterPaste=2
NoMenubarAccel=true
OpenNewTabRightToActiveTab=false
PrefDialogSize=@Size(700 700)
SavePosOnExit=true
SaveSizeOnExit=true
ScrollbarPosition=2
ShowCloseTabButton=true
TabBarless=false
TabsPosition=0
Term=xterm
TerminalBackgroundImage=
TerminalBackgroundMode=0
TerminalMargin=0
TerminalTransparency=0
TerminalsPreset=0
TrimPastedTrailingNewlines=false
UseBookmarks=false
UseCWD=false
UseFontBoxDrawingChars=false
colorScheme=BlackOnWhite
emulation=default
enabledBidiSupport=true
fontFamily=Ubuntu Mono
fontSize=11
guiStyle=
highlightCurrentTerminal=false
showTerminalSizeHint=true
version=0.17.0

[DropMode]
Height=45
KeepOpen=false
ShortCut=F12
ShowOnStart=true
Width=70

[MainWindow]
ApplicationTransparency=0
fixedSize=@Size(600 400)
pos=@Point(0 0)
size=@Size(800 600)
state=@ByteArray()

[Sessions]
size=0

[Shortcuts]
Add%20Tab=Ctrl+Shift+T
Bottom%20Subterminal=Alt+Down
Clear%20Active%20Terminal=Ctrl+Shift+X
Close%20Tab=Ctrl+Shift+W
Collapse%20Subterminal=
Copy%20Selection=Ctrl+Shift+C
Find=Ctrl+Shift+F
Fullscreen=F11
Handle%20history=
Hide%20Window%20Borders=
Left%20Subterminal=Alt+Left
Move%20Tab%20Left=Alt+Shift+Left|Ctrl+Shift+PgUp
Move%20Tab%20Right=Alt+Shift+Right|Ctrl+Shift+PgDown
New%20Window=Ctrl+Shift+N
Next%20Tab=Ctrl+PgDown
Next%20Tab%20in%20History=Ctrl+Shift+Tab
Paste%20Clipboard=Ctrl+Shift+V
Paste%20Selection=Shift+Ins
Preferences...=
Previous%20Tab=Ctrl+PgUp
Previous%20Tab%20in%20History=Ctrl+Tab
Quit=
Rename%20Session=Alt+Shift+S
Right%20Subterminal=Alt+Right
Show%20Tab%20Bar=
Split%20Terminal%20Horizontally=
Split%20Terminal%20Vertically=
Tab%201=
Tab%2010=
Tab%202=
Tab%203=
Tab%204=
Tab%205=
Tab%206=
Tab%207=
Tab%208=
Tab%209=
Toggle%20Bookmarks=Ctrl+Shift+B
Toggle%20Menu=Ctrl+Shift+M
Top%20Subterminal=Alt+Up
Zoom%20in=Ctrl++
Zoom%20out=Ctrl+-
Zoom%20reset=Ctrl+0
EOF

cd -

# KWin has unreasonable dependencies, pulls in half of Plasma (and more)
# apt-get -y install kwin-x11
# So try DDE KWin
yes | sudo apt-add-repository ppa:ubuntudde-dev/stable
sudo apt-get -y install dde-kwin

# Customize casper, this runs late in the boot process

mkdir -p /usr/share/initramfs-tools/scripts/casper-bottom/
cat > /usr/share/initramfs-tools/scripts/casper-bottom/70customize <<\EOF
#!/bin/sh

PREREQ=""
DESCRIPTION="Customize..."

prereqs()
{
       echo "$PREREQ"
}

case $1 in
# get pre-requisites
prereqs)
       prereqs
       exit 0
       ;;
esac

. /scripts/casper-functions

log_begin_msg "$DESCRIPTION"

# mkdir -p /root/home/$USERNAME/.config
# touch /root/home/$USERNAME/.config/ibus-mozc-gnome-initial-setup-done
# chroot /root chown -R $USERNAME.$USERNAME /home/$USERNAME/.config

rm -rf /home/$USERNAME/Desktop/*.desktop

log_end_msg
EOF
chmod +x /usr/share/initramfs-tools/scripts/casper-bottom/70customize


############################################
# Clean up system files
############################################

apt-get clean -y
apt-get autopurge -y
apt-get clean
sed -i 's/^set -e//g' /var/lib/dpkg/info/snapd.prerm #For minimal as snapd fails at some point
sed -i 's/^set -e//g' /var/lib/dpkg/info/snapd.postrm
echo 'find / -type f -name "*snap*" -delete 2> /dev/null' >> /var/lib/dpkg/info/snapd.postrm #to make snap is fully removed
echo 'rm -rf /snap' >> /var/lib/dpkg/info/snapd.postrm
echo 'rm -rf ~/snap' >> /var/lib/dpkg/info/snapd.postrm
echo 'rm -rf /root/snap' >> /var/lib/dpkg/info/snapd.postrm
