sudo apt-get install nginx
sudo service nginx start  # start nginx, if not already started

sudo rm /etc/nginx/sites-enabled/default
sudo touch /etc/nginx/sites-available/odoo
sudo ln -s /etc/nginx/sites-available/odoo /etc/nginx/sites-enabled/odoo

# edit Nginx configuration file
# sudo nano /etc/nginx/sites-available/odoo

sudo nginx -t
sudo /etc/init.d/nginx reload
sudo systemctl reload nginx 
curl http://localhost

sudo apt-get install python-certbot-nginx
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
sudo certbot --nginx -d example.com -d www.example.com
sudo certbot renew --dry-run