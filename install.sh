#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)

# Actualizando el sistema

sudo apt update

sudo parrot-upgrade

# Instalando dependencias de Entorno

sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

# Instalando Requerimientos para la polybar

sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libuv1-dev libnl-genl-3-dev

# Dependencias de Picom

sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpcre3 libpcre3-dev

# Instalamos paquetes adionales

sudo apt install -y feh scrot scrub zsh rofi xclip bat locate neofetch wmname acpi bspwm sxhkd imagemagick ranger kitty

# Creando carpeta de Reposistorios
mkdir ~/github
cd ~/github
echo "Instalando REPOSITORIOS..."
sleep 1.5
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
git clone --recursive https://github.com/polybar/polybar
git clone https://github.com/ibhagwan/picom.git
#instalando bspwm
echo "Instalando bspwm..."
sleep 1.5
cd ~/github/bspwm
make -j$(nproc)
sudo make install
sudo apt install bspwm -y
# instalando sxhkd
echo "Instalando sxhkd..."
sleep 1.5
cd ~/github/sxhkd
make -j$(nproc)
sudo make install
# Instalando Polybar
echo "Instalando polybar..."
sleep 1.5
cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
# Instalando Picom
echo "Instalando picom..."
sleep 1.5
cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
# Instalando p10k
echo "Instalando P10K..."
sleep 1.5
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
# Instalando p10k root
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k
# Configuramos el tema Nord de Rofi:
echo "Instalando Rofi..."
sleep 1.5
mkdir -p ~/.config/rofi/themes
cp $ruta/rofi/nord.rasi ~/.config/rofi/themes/
# Instalamos las HackNerdFonts
sudo cp -v $ruta/fonts/HNF/* /usr/local/share/fonts/
# Instalando Fuentes de Polybar
echo "Instalando HNF..."
sleep 1.5
sudo cp -v $ruta/Config/polybar/fonts/* /usr/share/fonts/truetype/
# Instalando Wallpapers
echo "Instalando estilos..."
sleep 1.5
mkdir ~/Wallpaper
cp -v $ruta/Wallpaper/* ~/Wallpaper
mkdir ~/ScreenShots
# Copiando Archivos de Configuración
echo "Configurando..."
sleep 1.5
cp -rv $ruta/Config/* ~/.config/
sudo cp -rv $ruta/Config/kitty ~/.config/
# Kitty Root
sudo cp -rv $ruta/Config/kitty /root/.config/
# Copia de configuracion de .p10k.zsh y .zshrc
rm -rf ~/.zshrc
cp -v $ruta/.zshrc ~/.zshrc
cp -v $ruta/.p10k.zsh ~/.p10k.zsh
sudo cp -v $ruta/.p10k.zsh-root /root/.p10k.zsh
# Script
sudo cp -v $ruta/scripts/whichSystem.py /usr/local/bin/
sudo cp -v $ruta/scripts/screenshot /usr/local/bin/
# Plugins ZSH
sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
# Cambiando de SHELL a zsh
chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root
sudo ln -s -fv ~/.zshrc /root/.zshrc
# Asignamos Permisos a los Scritps
chmod +x ~/.config/xshkd/xshkdrc
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/whichSystem.py
sudo chmod +x /usr/local/bin/screenshot
# Configuramos el Tema de Rofi
rofi-theme-selector
# Elijiendo Wallpaper
clear
echo "Menú de opciones:"
echo "1. Anime"
echo "2. Dia de muertos"
echo "3. AC Valhalla"
echo "4. Mr Robot"
echo "5. Black Panther"
read -p "Ingresa el número del wallpaper que quiere: " Wall_num
case $Wall_num in
    1)
        echo "#WALLPAPER \n feh --bg-fill ~/Wallpaper/a.jpg" >> ~/.config/bspwm/bspwmrc
        ;;
    2)
        echo "#WALLPAPER \n feh --bg-fill ~/Wallpaper/cat.jpg" >> ~/.config/bspwm/bspwmrc
        ;;
    3)
        echo "#WALLPAPER \n feh --bg-fill ~/Wallpaper/eivor.jpg" >> ~/.config/bspwm/bspwmrc    
        ;;
    4)
        echo "#WALLPAPER \n feh --bg-fill ~/Wallpaper/fsociety.jpg" >> ~/.config/bspwm/bspwmrc
        ;;
    5)
        echo "#WALLPAPER \n feh --bg-fill ~/Wallpaper/wakanda.jpg" >> ~/.config/bspwm/bspwmrc
        ;;
esac

# Removiendo Repositorio
rm -rf ~/github
rm -rf $ruta
# Mensaje de Instalado
notify-send "BSPWM INSTALLED"

while true; do
		echo -en "[?] It's necessary to restart the system. Do you want to restart the system now? ([y]/n) "
		read -r
		REPLY=${REPLY:-"y"}
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo -e "[+] Restarting the system..."
			sleep 1
			sudo reboot
		elif [[ $REPLY =~ ^[Nn]$ ]]; then
			exit 0
		else
			echo -e "[!] Invalid response, please try again"
		fi
done