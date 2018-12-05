service  apache2 stop;

# nginx -g 'daemon off;'

php -S 0.0.0.0:8888 -t site/public