#!/bin/sh

############################################
# Customize
############################################

# Remove snap
apt-get -y remove snapd libreoffice-common || true
rm -rf /var/lib/snapd || true

# Install software
apt-get -y install falkon baloo-kf5 libqalculate22 plasma-integration libqt5multimedia5 # elementary-xfce-icon-theme

# Remove software
apt-get -y remove 2048-qt geoclue-2.0 gcr gtk2-engines-pixbuf kdeconnect plasma-framework \
vim-common htop libgtk-3-common libgtk2.0-common catdoc cracklib-runtime emacsen-common \
fonts-deva-extra fonts-gargi fonts-gubbi fonts-gujr fonts-gujr-extra fonts-guru fonts-guru-extra
# TODO: Remove more font spam

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

sudo ln -sf /usr/bin/lxqt-leave /System/Menu.app/Shutdown

# Remove .desktop files from desktop
rm *.desktop || true

cd -

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
