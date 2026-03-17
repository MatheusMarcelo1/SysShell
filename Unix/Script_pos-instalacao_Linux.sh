#Definir botão maximizar Linux
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

echo "Botão adicionado com sucesso!"

# Tecla personalizada (Super+E -> nautilus)
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Arquivos'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal -- nautilus'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>e'


# Tecla personalizada (Super+R -> terminal)
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>r'


#Instalando programas:
#Brave
sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg -y
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list -y
sudo apt update -y
sudo apt install brave-browser -y

#programs
sudo apt install remmina -y
sudo apt install nodejs -y
sudo apt install git -y
sudo apt install calc -y
sudo snap install --classic code -y
sudo apt-get install flameshot -y
sudo apt-get install wine -y 
sudo apt-get install vlc -y
sudo apt-get install python3 -y
echo "Instalações concluídas!"

#extensões code
code --install-extension zhuangtongfa.material-theme -y
code --install-extension ms-python.python -y
code --install-extension dsznajder.es7-react-js-snippets -y
echo "extensões do VSCode instaladas"

#não fechar softwares em segundo plano do terminal
nohup "$@" >/dev/null 2>&1 &

echo "Finalizando"
sudo apt update && sudo apt dist-upgrade && sudo apt upgrade -y
sudo apt autoclean
sudo apt autoremove -y


##Salvar o script com a extensão .sh e executar com permissões de superusuário. 
#Abra o terminal na pasta onde o script foi salvo e execute o comando:
#sudo bash script.sh
