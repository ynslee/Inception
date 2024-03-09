#ngnix is a versatile and efficient webserver software
#widely used in production environments to serve websites and web applications, handle high volumes of traffic, and improve performance and reliability.
FROM alpine:latest

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/index.html /var/www/inex.html


#Update and upgrade apk packages
# Install nginx and openssl
# Create a directory for the SSL certificate and private key
# Generate a self-signed SSL certificate
RUN apk update && apk upgrade \ 
	&& apk add --no-cache nginx openssl\
	&& mkdir -p /run/nginx /etc/nginx/ssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx-selfsigned.key -out nginx-selfsigned.crt \
	-subj "/C=FR/ST=Helsinki/L=Helsinki/O=42/OU=Hive/CN=yoonslee.42.fr" && \
	mv /nginx-selfsigned.crt /etc/nginx/ssl/certificate.crt && \
    mv /nginx-selfsigned.key /etc/nginx/ssl/certificate.key


# RUN apk update && apk add --no-cache nginx && \
# 	adduser -D -g 'www' www && \
# 	mkdir /www && \
# 	chown -R www:www /var/lib/nginx && \
# 	chown -R www:www /www && \
# 	mv /etc/nginx/nginx.conf /etc/

EXPOSE 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]