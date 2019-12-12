# create user
adduser username
usermod -aG sudo username
su - username
deluser username

# add ssh key
vi  ~/.ssh/authorized_keys

# edit
# PermitRootLogin without-password
sudo vi /etc/ssh/sshd_config
sudo systemctl reload sshd.service

sudo apt-get install nginx python-certbot-nginx ufw vim zsh curl wget htop screen git -y
sudo apt-get install git python3-dev python3-pip -y
sudo apt-get install build-essential libxslt-dev libzip-dev libldap2-dev libsasl2-dev libssl-dev

sudo ufw allow 22
sudo ufw allow 443
sudo ufw allow 80
sudo ufw enable