#!/bin/bash

# Color
BLUE='\033[0;34m'       
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Display welcome message
display_welcome() {
  echo -e ""
  echo -e "${BLUE}[+] ============================================== [+]${NC}"
  echo -e "${BLUE}[+]                                                [+]${NC}"
  echo -e "${BLUE}[+]                AUTO INSTALLER THEME            [+]${NC}"
  echo -e "${BLUE}[+]                  © DisasterVanz                [+]${NC}"
  echo -e "${BLUE}[+]                                                [+]${NC}"
  echo -e "${RED}[+] =============================================== [+]${NC}"
  echo -e ""
  echo -e "Dilarang Share/Membagikan Token"
  echo -e "Share? Delete Repo & No Reff!"
  echo -e ""
  echo -e "𝗧𝗘𝗟𝗘𝗚𝗥𝗔𝗠 :"
  echo -e "@VanzWasHere"
  echo -e "𝗖𝗥𝗘𝗗𝗜𝗧𝗦 :"
  echo -e "@DisasterVanz"
  sleep 4
  clear
}

#Update and install jq
install_jq() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]             UPDATE & INSTALL JQ                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sudo apt update && sudo apt install -y jq
  if [ $? -eq 0 ]; then
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]              INSTALL JQ BERHASIL                [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
  else
    echo -e "                                                       "
    echo -e "${RED}[+] =============================================== [+]${NC}"
    echo -e "${RED}[+]              INSTALL JQ GAGAL                   [+]${NC}"
    echo -e "${RED}[+] =============================================== [+]${NC}"
    exit 1
  fi
  echo -e "                                                       "
  sleep 1
  clear
}
#Check user token
check_token() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]               LICENSE INSTALLER CODE            [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  echo -e "${YELLOW}MASUKAN AKSES TOKEN :${NC}"
  read -r USER_TOKEN

  if [ "$USER_TOKEN" = "vanztheme" ]; then
    echo -e "${GREEN}AKSES BERHASIL${NC}}"
  else
    echo -e "${GREEN}Token Salah! Beli Kode Token Di Vanz Dulu!!${NC}"
    echo -e "${YELLOW}TELEGRAM : @VanzWasHere${NC}"
    echo -e "${YELLOW}WHATSAPP : +6285825319121{NC}"
    echo -e "${YELLOW}HARGA TOKEN : 25K FREE UPDATE JIKA ADA TOKEN BARU${NC}"
    echo -e "${YELLOW}© DisasterVanz${NC}"
    exit 1
  fi
  clear
}

# Install theme
check_result() {
    if [ $? -ne 0 ]; then
        echo -e "${RED}[!] Error: $1${NC}"
        return 1
    fi
    return 0
}

install_theme() {
  while true; do
    echo -e "                                                       "
    echo -e "${BLUE}[+] =============================================== [+]${NC}"
    echo -e "${BLUE}[+]                   SELECT THEME                  [+]${NC}"
    echo -e "${BLUE}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
    echo -e "PILIH THEME YANG INGIN DI INSTALL"
    echo "1. stellar"
    echo "2. billing"
    echo "3. enigma"
    echo "4. elysium"
    echo "x. kembali"
    echo -ne "masukan pilihan (1/2/3/4/x) : "
    read -r SELECT_THEME

    case "$SELECT_THEME" in
      1) THEME_NAME="stellar"; break ;;
      2) THEME_NAME="billing"; break ;;
      3) THEME_NAME="enigma"; break ;;
      4) THEME_NAME="elysium"; break ;;
      x) return ;;
      *) echo -e "${RED}Pilihan tidak valid, silakan coba lagi.${NC}" ;;
    esac
  done

  THEME_URL="https://github.com/DisasterVanz/Pterodactyl-Theme-Autoinstaller/raw/main/${THEME_NAME}.zip"

  echo -e "${YELLOW}[+] Memulai instalasi tema ${THEME_NAME}...${NC}"
  
  # Pastikan direktori kerja ada dan bersih
  echo "[+] Menghapus folder lama..."
  sudo rm -rf /root/pterodactyl
  sudo rm -f "/root/${THEME_NAME}.zip"

  # Download tema
  echo "[+] Mendownload theme ${THEME_NAME}..."
  wget -q "$THEME_URL" -O "/root/${THEME_NAME}.zip"
  check_result "Download tema gagal" || return

  # Periksa file zip
  if [ ! -s "/root/${THEME_NAME}.zip" ]; then
    echo -e "${RED}[!] File zip kosong atau tidak terdownload dengan benar${NC}"
    return
  fi

  # Ekstrak tema
  echo "[+] Mengekstrak theme..."
  sudo unzip -o "/root/${THEME_NAME}.zip" -d /root
  check_result "Unzip gagal" || return

  # Verifikasi hasil ekstrak
  if [ ! -d "/root/pterodactyl" ]; then
    echo -e "${RED}[!] Folder hasil ekstrak tidak ditemukan${NC}"
    return
  fi

  # Jika Enigma, minta input user dan ubah placeholder
  if [ "$THEME_NAME" == "enigma" ]; then
    echo -e "${YELLOW}Masukkan link WhatsApp (https://wa.me/...) : ${NC}"
    read LINK_WA
    echo -e "${YELLOW}Masukkan link Group : ${NC}"
    read LINK_GROUP
    echo -e "${YELLOW}Masukkan link Channel : ${NC}"
    read LINK_CHNL

    FILE_PATH="/root/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx"
    if [ -f "$FILE_PATH" ]; then
      sudo sed -i "s|LINK_WA|$LINK_WA|g" "$FILE_PATH"
      sudo sed -i "s|LINK_GROUP|$LINK_GROUP|g" "$FILE_PATH"
      sudo sed -i "s|LINK_CHNL|$LINK_CHNL|g" "$FILE_PATH"
    else
      echo -e "${RED}[!] File $FILE_PATH tidak ditemukan${NC}"
    fi
  fi

  # Backup folder pterodactyl asli
  echo "[+] Backup folder panel pterodactyl asli..."
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  sudo cp -r /var/www/pterodactyl "/var/www/pterodactyl_backup_$TIMESTAMP"
  check_result "Backup folder panel gagal" || return

  # Menyalin tema ke lokasi panel
  echo "[+] Menyalin theme ke /var/www/pterodactyl..."
  sudo cp -rfT /root/pterodactyl /var/www/pterodactyl
  check_result "Copy files gagal" || return

  # Instalasi dependensi
  echo "[+] Instalasi dependensi..."
  curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt update
  sudo apt install -y nodejs
  check_result "Instalasi NodeJS gagal" || return
  
  # Verifikasi versi Node.js
  NODE_VERSION=$(node -v)
  echo "[+] Versi Node.js: $NODE_VERSION"
  
  # Instalasi yarn
  sudo npm i -g yarn
  check_result "Instalasi yarn gagal" || return

  # Build tema
  echo "[+] Build theme..."
  cd /var/www/pterodactyl || { echo -e "${RED}[!] Folder panel tidak ditemukan.${NC}"; return; }

  # Pastikan semua dependencies terinstall
  echo "[+] Instalasi dependencies panel..."
  yarn install --frozen-lockfile
  check_result "Yarn install gagal" || return

  # Tambahkan react-feather
  echo "[+] Menambahkan react-feather..."
  yarn add react-feather
  check_result "Gagal menambahkan react-feather" || return

  # Jalankan migrasi database
  echo "[+] Menjalankan migrasi database..."
  php artisan migrate --force
  check_result "Migrasi database gagal" || return

  # Build panel
  echo "[+] Building panel..."
  yarn build:production
  check_result "Build panel gagal" || return

  # Clear cache
  echo "[+] Membersihkan cache..."
  php artisan view:clear
  php artisan cache:clear
  php artisan config:clear
  check_result "Gagal membersihkan cache" || return

  # Set permission yang benar
  echo "[+] Mengatur permission..."
  sudo find /var/www/pterodactyl -type f -exec chmod 644 {} \;
  sudo find /var/www/pterodactyl -type d -exec chmod 755 {} \;
  
  # Tentukan web server yang digunakan
  if command -v nginx >/dev/null 2>&1; then
    WEB_USER="nginx"
    WEB_SERVICE="nginx"
  else
    WEB_USER="www-data"
    WEB_SERVICE="apache2"
  fi
  
  # Set ownership
  sudo chown -R $WEB_USER:$WEB_USER /var/www/pterodactyl
  check_result "Gagal mengatur permission" || return

  # Restart web server
  echo "[+] Restart web server..."
  sudo systemctl restart $WEB_SERVICE
  check_result "Gagal restart web server" || return

  # Membersihkan file sementara
  echo "[+] Membersihkan file sementara..."
  sudo rm -rf "/root/${THEME_NAME}.zip"
  sudo rm -rf /root/pterodactyl

  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]           THEME ${THEME_NAME^^} BERHASIL DIINSTALL          [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${YELLOW}[!] Jika tema belum muncul, silahkan clear cache browser Anda${NC}"
  echo -e "${YELLOW}[!] Backup panel lama tersimpan di: /var/www/pterodactyl_backup_$TIMESTAMP${NC}"
  echo -e "${YELLOW}[!] Untuk kembali ke panel lama, jalankan:${NC}"
  echo -e "${YELLOW}    sudo rm -rf /var/www/pterodactyl${NC}"
  echo -e "${YELLOW}    sudo cp -r /var/www/pterodactyl_backup_$TIMESTAMP /var/www/pterodactyl${NC}"
  echo -e "${YELLOW}    sudo chown -R $WEB_USER:$WEB_USER /var/www/pterodactyl${NC}"
  echo -e "${YELLOW}    sudo systemctl restart $WEB_SERVICE${NC}"
  
  sleep 5
  exit 0
}



# Uninstall theme
uninstall_theme() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    DELETE THEME                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  bash <(curl https://raw.githubusercontent.com/disastervanz/Pterodactyl-Theme-Autoinstaller/main/repair.sh)
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 DELETE THEME SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}
install_themeSteeler() {
#!/bin/bash

echo -e "                                                       "
echo -e "${BLUE}[+] =============================================== [+]${NC}"
echo -e "${BLUE}[+]                  INSTALLASI THEMA               [+]${NC}"
echo -e "${BLUE}[+] =============================================== [+]${NC}"
echo -e "                                                                   "

# Unduh file tema
wget -O /root/stellar.zip https://github.com/disastervanz/Pterodactyl-Theme-Autoinstaller/raw/main/stellar.zip


# Ekstrak file tema
unzip /root/stellar.zip -d /root/pterodactyl

# Salin tema ke direktori Pterodactyl
sudo cp -rfT /root/pterodactyl /var/www/pterodactyl

# Instal Node.js dan Yarn
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm i -g yarn

# Instal dependensi dan build tema
cd /var/www/pterodactyl
yarn add react-feather
php artisan migrate
yarn build:production
php artisan view:clear

# Hapus file dan direktori sementara
sudo rm /root/stellar.zip
sudo rm -rf /root/pterodactyl

echo -e "                                                       "
echo -e "${GREEN}[+] =============================================== [+]${NC}"
echo -e "${GREEN}[+]                   INSTALL SUCCESS               [+]${NC}"
echo -e "${GREEN}[+] =============================================== [+]${NC}"
echo -e ""
sleep 2
clear
exit 0

}
create_node() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    CREATE NODE                  [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  #!/bin/bash
#!/bin/bash

# Minta input dari pengguna
read -p "Masukkan nama lokasi: " location_name
read -p "Masukkan deskripsi lokasi: " location_description
read -p "Masukkan domain: " domain
read -p "Masukkan nama node: " node_name
read -p "Masukkan RAM (dalam MB): " ram
read -p "Masukkan jumlah maksimum disk space (dalam MB): " disk_space
read -p "Masukkan Locid: " locid

# Ubah ke direktori pterodactyl
cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
php artisan p:location:make <<EOF
$location_name
$location_description
EOF

# Membuat node baru
php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$domain
yes
no
no
$ram
$ram
$disk_space
$disk_space
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]        CREATE NODE & LOCATION SUKSES            [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
  exit 0
}
uninstall_panel() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    UNINSTALL PANEL              [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "


bash <(curl -s https://pterodactyl-installer.se) <<EOF
y
y
y
y
EOF


  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 UNINSTALL PANEL SUKSES          [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
  exit 0
}
configure_wings() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    CONFIGURE WINGS              [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  #!/bin/bash

# Minta input token dari pengguna
read -p "Masukkan token Configure menjalankan wings: " wings

eval "$wings"
# Menjalankan perintah systemctl start wings
sudo systemctl start wings

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 CONFIGURE WINGS SUKSES          [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
  exit 0
}
hackback_panel() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    HACK BACK PANEL              [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  # Minta input dari pengguna
read -p "Masukkan Username Panel: " user
read -p "password login " psswdhb
  #!/bin/bash
cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
php artisan p:user:make <<EOF
yes
autohb@vanz.hb
$user
$user
$user
$psswdhb
EOF
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 AKUN TELAH DI ADD               [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  
  exit 0
}
ubahpw_vps() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    UBAH PASSWORD VPS            [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
read -p "Masukkan Pw Baru: " pw
read -p "Masukkan Ulang Pw Baru " pw

passwd <<EOF
$pw
$pw

EOF


  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 GANTI PW VPS SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  
  exit 0
}
# Main script
display_welcome
install_jq
check_token

while true; do
  clear
  echo -e "                                                                     "
  echo -e "${RED}        _,gggggggggg.                                     ${NC}"
  echo -e "${RED}    ,ggggggggggggggggg.                                   ${NC}"
  echo -e "${RED}  ,ggggg        gggggggg.                                 ${NC}"
  echo -e "${RED} ,ggg'               'ggg.                                ${NC}"
  echo -e "${RED}',gg       ,ggg.      'ggg:                               ${NC}"
  echo -e "${RED}'ggg      ,gg'''  .    ggg     Pterodactyl Tools Installer   ${NC}"
  echo -e "${RED}gggg      gg     ,     ggg      ------------------------  ${NC}"
  echo -e "${RED}ggg:     gg.     -   ,ggg       • Telegram : VanzWasHere      ${NC}"
  echo -e "${RED} ggg:     ggg._    _,ggg        • Credit  : DisasterVanz  ${NC}"
  echo -e "${RED} ggg.    '.'''ggggggp           • Support by Vanz1337  ${NC}"
  echo -e "${RED}  'ggg    '-.__                                           ${NC}"
  echo -e "${RED}    ggg                                                   ${NC}"
  echo -e "${RED}      ggg                                                 ${NC}"
  echo -e "${RED}        ggg.                                              ${NC}"
  echo -e "${RED}          ggg.                                            ${NC}"
  echo -e "${RED}             b.                                           ${NC}"
  echo -e "                                                                     "
  echo -e "BERIKUT LIST INSTALL :"
  echo "1. Install theme"
  echo "2. Uninstall theme"
  echo "3. Configure Wings"
  echo "4. Create Node"
  echo "5. Uninstall Panel"
  echo "6. Stellar Theme"
  echo "7. Hack Back Panel"
  echo "8. Ubah Pw Vps"
  echo "x. Exit"
  echo -e "Masukkan pilihan 1/2/x:"
  read -r MENU_CHOICE
  clear

  case "$MENU_CHOICE" in
    1)
      install_theme
      ;;
    2)
      uninstall_theme
      ;;
      3)
      configure_wings
      ;;
      4)
      create_node
      ;;
      5)
      uninstall_panel
      ;;
      6)
      install_themeSteeler
      ;;
      7)
      hackback_panel
      ;;
      8)
      ubahpw_vps
      ;;
    x)
      echo "Keluar dari skrip."
      exit 0
      ;;
    *)
      echo "Pilihan tidak valid, silahkan coba lagi."
      ;;
  esac
done
