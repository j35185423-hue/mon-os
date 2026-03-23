#!/bin/bash
set -e

echo "=============================="
echo " Installation de Mon OS Custom"
echo "=============================="

# Mise à jour du système
apt-get update && apt-get upgrade -y

# Installation des paquets
apt-get install -y \
  xserver-xorg \
  xinit \
  openbox \
  pulseaudio \
  chromium-browser \
  joystick \
  onboard \
  wget \
  curl \
  git \
  unzip \
  libsdl2-2.0-0 \
  libvlc5 \
  vlc-plugin-base \
  libcurl4 \
  libasound2 \
  libpoppler-cpp0v5 \
  fuse3

# Installation EmulationStation
wget -O /usr/local/bin/emulationstation \
  "https://gitlab.com/es-de/emulationstation-de/-/package_files/248914983/download"
chmod +x /usr/local/bin/emulationstation

# Création des dossiers
mkdir -p /home/pi/roms/streaming
mkdir -p /home/pi/roms/ps2
mkdir -p /home/pi/roms/raccourcis

# Raccourcis streaming
echo "https://www.netflix.com" > /home/pi/roms/streaming/Netflix.url
echo "https://www.canalplus.com" > /home/pi/roms/streaming/CanalPlus.url
echo "https://www.youtube.com" > /home/pi/roms/raccourcis/YouTube.url

# Config EmulationStation
mkdir -p /home/pi/.emulationstation
cat > /home/pi/.emulationstation/es_systems.cfg << 'ESEOF'
<systemList>
  <system>
    <name>streaming</name>
    <fullname>Streaming</fullname>
    <path>/home/pi/roms/streaming</path>
    <extension>.url</extension>
    <command>chromium-browser --kiosk --app=%ROM%</command>
    <platform>streaming</platform>
  </system>
  <system>
    <name>ps2</name>
    <fullname>PlayStation 2</fullname>
    <path>/home/pi/roms/ps2</path>
    <extension>.iso .ISO .bin .BIN</extension>
    <command>pcsx2 %ROM%</command>
    <platform>ps2</platform>
  </system>
  <system>
    <name>raccourcis</name>
    <fullname>Mes Raccourcis</fullname>
    <path>/home/pi/roms/raccourcis</path>
    <extension>.url</extension>
    <command>chromium-browser --kiosk --app=%ROM%</command>
    <platform>raccourcis</platform>
  </system>
</systemList>
ESEOF

# Démarrage automatique
cat > /home/pi/.bash_profile << 'BPEOF'
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  startx /usr/local/bin/emulationstation
fi
BPEOF

chown -R pi:pi /home/pi

echo "=============================="
echo " Installation terminée !"
echo " Redémarre avec : sudo reboot"
echo "=============================="
