#!/bin/bash
sudo -u postgres psql -f ./company_database.sql
sudo cp postgrest.conf /etc/postgrest.conf
sudo -u postgres /usr/local/bin/postgrest /etc/postgrest.conf &
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22

cd src
npm install
npm run build
sudo cp -R dist/* /var/www/html/
sudo cp ../default /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

