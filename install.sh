#!/bin/bash

# Función para verificar e instalar paquetes
install_packages() {
    echo "Buscando Paquetes necesarios..."

    PACKAGES_COMMON="kitty rofi feh xclip ranger scrot scrub wmname imagemagick cmatrix htop neofetch python3-pip procps tty-clock fzf lsd bat pamixer flameshot build-essential git vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev"

    for package in $PACKAGES_COMMON; do
        if [ ! dpkg -l | grep -q " $package "; then
            echo "Instalando $package..."
            sudo apt install -y $package
            sleep 2
        else
            echo "$package ya está instalado."
        fi
    done
}
ruta=$(pwd)
# Verificar e instalar paquetes --------------------------------------
install_packages
mkdir ~/github
cd ~/github
echo "Instalando REPOSITORIOS..."
sleep 1.5
#instalando bspwm
git clone https://github.com/baskerville/bspwm.git
echo "Instalando bspwm..."
sleep 1.5
cd ~/github/bspwm
make -j$(nproc)
sudo make install
sudo apt-get install bspwm -y
# instalando sxhkd ----------------------------------------------------
git clone https://github.com/baskerville/sxhkd.git
echo "Instalando sxhkd..."
sleep 1.5
cd ~/github/sxhkd
make -j$(nproc)
sudo make install
# Instalando Polybar -----------------------------------------------------
git clone --recursive https://github.com/polybar/polybar
echo "Instalando polybar..."
sleep 1.5
cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
# Instalando Picom ------------------------------------------------------------
git clone https://github.com/ibhagwan/picom.git
echo "Instalando picom..."
sleep 1.5
cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
# Instalando p10k --------------------------------------------------------------------------
echo "Instalando P10K..."
sleep 1.5
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
# Instalando p10k root ---------------------------------------------------------------------
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k
# Configuramos el tema Nord de Rofi: -------------------------------------------------------
echo "Instalando Rofi..."
sleep 1.5
mkdir -p ~/.config/rofi/themes
cp $ruta/rofi/nord.rasi ~/.config/rofi/themes/
# Instalamos las HackNerdFonts --------------------------------------------------------------
sudo cp -v $ruta/fonts/HNF/* /usr/local/share/fonts/
# Instalando Fuentes de Polybar ------------------------------------------------------------
echo "Instalando HNF..."
sleep 1.5
sudo cp -v $ruta/Config/polybar/fonts/* /usr/share/fonts/truetype/
# Instalando Wallpapers ---------------------------------------------------
echo "Instalando estilos..."
sleep 1.5
mkdir ~/Wallpaper
cp -v $ruta/Wallpaper/* ~/Wallpaper
# Copiando Archivos de Configuración ----------------------------------------
echo "Configurando..."
sleep 1.5
cp -rv $ruta/Config/* ~/.config/
sudo cp -rv $ruta/Config/kitty ~/.config/
# Kitty Root ------------------------------------------------------------------
sudo cp -rv $ruta/Config/kitty /root/.config/
# Copia de configuracion de .p10k.zsh y .zshrc ----------------------------------
rm -rf ~/.zshrc
cp -v $ruta/zshrc ~/.zshrc
cp -v $ruta/p10k.zsh ~/.p10k.zsh
sudo cp -v $ruta/p10k.zsh-root /root/.p10k.zsh
# Script -------------------------------------------------------------------------
sudo cp -v $ruta/scripts/whichSystem.py /usr/local/bin/
sudo cp -v $ruta/scripts/screenshot /usr/local/bin/
# Plugins ZSH ----------------------------------------------------------------------
sudo apt-get install -y zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
# Cambiando de SHELL a zsh ----------------------------------------------------------
chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root
sudo ln -s -fv ~/.zshrc /root/.zshrc
# Asignamos Permisos a los Scritps --------------------------------------------------
chmod +x ~/.config/sxhkd/sxhkdrc
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
# Configuramos el Tema de Rofi ---------------------------------------------------
rofi-theme-selector
# Elijiendo Wallpaper ------------------------------------------------------------
echo "#WALLPAPER" >> ~/.config/bspwm/bspwmrc
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
        echo "feh --bg-fill ~/Wallpaper/a.jpg &" >> ~/.config/bspwm/bspwmrc
        ;;
    2)
        echo "feh --bg-fill ~/Wallpaper/cat.jpg &" >> ~/.config/bspwm/bspwmrc
        ;;
    3)
        echo "feh --bg-fill ~/Wallpaper/eivor.jpg &" >> ~/.config/bspwm/bspwmrc    
        ;;
    4)
        echo "feh --bg-fill ~/Wallpaper/fsociety.jpg &" >> ~/.config/bspwm/bspwmrc
        ;;
    5)
        echo "feh --bg-fill ~/Wallpaper/wakanda.jpg &" >> ~/.config/bspwm/bspwmrc
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
