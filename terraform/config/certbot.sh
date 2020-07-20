sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y nginx 
sudo apt-get install -y certbot python3-certbot-nginx
sudo certbot --nginx -d {{domain}} -m {{email}} --agree-tos --no-eff-email --redirect 