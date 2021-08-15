./clean-all.sh

cp /sites/www/certs/hit-dev.key reverse-proxy/certs/hit-dev.key
cp /sites/www/certs/hit-dev.crt reverse-proxy/certs/hit-dev.crt
docker-compose -f docker-compose.yml up --build  -d
