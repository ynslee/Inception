#ngnix is a versatile and efficient webserver software
#widely used in production environments to serve websites and web applications, handle high volumes of traffic, and improve performance and reliability.
FROM alpine:latest

WORKDIR /app

COPY /conf .

#Update and upgrade apk packages
# Install nginx and openssl
# Create a directory for the SSL certificate and private key
# Generate a self-signed SSL certificate
RUN apk update && apk upgrade \ 
	&& apk add --no-cache nginx openssl \
	&& mkdir -p /run/nginx /etc/nginx/ssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MO/L=KH/O=1337/OU=student/CN=sahafid.1337.ma"

# RUN apk update && apk add --no-cache nginx && \
# 	adduser -D -g 'www' www && \
# 	mkdir /www && \
# 	chown -R www:www /var/lib/nginx && \
# 	chown -R www:www /www && \
# 	mv /etc/nginx/nginx.conf /etc/

EXPOSE 443

# Start NGINX
CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]