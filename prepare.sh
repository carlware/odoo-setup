# Install the PostgreSQL database
sudo apt update
sudo apt upgrade -y
sudo apt install postgresql -y # Install PostgreSQL
sudo su -c "createuser -s $USER" postgres # Create db superuser

# create db
sudo vim /etc/postgresql/9.6/main/pg_hba.conf*
# local   all             postgres                                md5
su - postgres
createuser --interactive --pwprompt
# At the Enter name of role to add: prompt, type the user's name.
# At the Enter password for new role: prompt, type a password for the user.
# At the Enter it again: prompt, retype the password.
# At the Shall the new role be a superuser? prompt, type y if you want to grant superuser access. Otherwise, type n.
# At the Shall the new role be allowed to create databases? prompt, type y if you want to allow the user to create new databases. Otherwise, type n.
# At the Shall the new role be allowed to create more new roles? prompt, type y if you want to allow the user to create new users. Otherwise, type n.
# PostgreSQL creates the user with the settings you specified.
createdb -O user dbname
# GRANT permissions ON DATABASE dbname TO username;
dropdb dbname

# Install the Odoo system dependencies
sudo apt install git  # Install Git
sudo apt install python3-dev python3-pip # Python 3 for dev
sudo apt install build-essential libxslt-dev libzip-dev libldap2-dev libsasl2-dev libssl-dev

# Install wkhtmltox, which is needed to print reports
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb
sudo dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb
sudo apt-get -fy install

# Install Python dependencies
wget https://raw.githubusercontent.com/odoo/odoo/12.0/requirements.txt
sudo -H pip3 install -r requirements.txt

# Preparing a dedicated system user
sudo adduser --disabled-password --gecos "Odoo" odoo
sudo su -c "createuser odoo" postgres
createdb --owner=odoo odoo-prod

# Install Odoo from source
sudo su odoo
git clone https://github.com/odoo/odoo.git /home/odoo/odoo-12 -b 12.0 --depth=1
/home/odoo/odoo-12/odoo-bin --version
mkdir addons
exit

sudo mkdir /etc/odoo
sudo cp /home/odoo/.odoorc /etc/odoo/odoo.conf
sudo chown -R odoo /etc/odoo
sudo chmod u=r,g=rw,o=r /etc/odoo/odoo.conf  # for extra hardening

sudo mkdir /var/log/odoo
sudo chown odoo /var/log/odoo
sudo mkdir /var/lib/odoo
sudo chown odoo /var/lib/odoo

sudo systemctl enable odoo.service
sudo systemctl start odoo
sudo systemctl status odoo
sudo systemctl stop odoo


