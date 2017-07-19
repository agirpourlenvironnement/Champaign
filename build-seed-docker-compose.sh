#!/bin/sh

echo "--------------------------------------------"
echo "[1/4] Building web-champaign docker image..."
echo "--------------------------------------------"
docker-compose build

echo "--------------------------------------------"
echo "[2/4] Loading database schema and seeding..."
echo "--------------------------------------------"
docker-compose run web rake db:reset
docker-compose run web rake champaign:seed_liquid

echo "-------------------------------------------------------"
echo "[3/4] Adding admin user r@r.com (password: 12345678)..."
echo "-------------------------------------------------------"
docker-compose run web rails r "User.create! email: 'r@r.com', password: '12345678', admin: true"

echo "--------------------------------------------"
echo "[4/4] Adding English and French languages..."
echo "--------------------------------------------"
docker-compose run web rails r "Language.create! name: 'English', code: 'en', actionkit_uri: 'http://whatever.com'"
docker-compose run web rails r "Language.create! name: 'French', code: 'fr', actionkit_uri: 'http://whatever.com'"

echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo '[DONE] Ready to start up with "docker-compose up"'
echo "You shouldn’t run this script again, unless you removed these built containers."
