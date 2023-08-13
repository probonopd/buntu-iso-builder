#!/bin/sh

############################################
# Customize
############################################

wget https://gist.github.com/probonopd/2f53a49b021f270b9106d8f8bb1f199b/raw/customize-lubuntu.sh
sh -x ./customize-lubuntu.sh
rm ./customize-lubuntu.sh

apt-get -y remove snapd libreoffice-common || true
rm -rf /var/lib/snapd || true
apt-get -y install falkon

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
