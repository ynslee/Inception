#ngnix is a versatile and efficient webserver software
#widely used in production environments to serve websites and web applications, handle high volumes of traffic, and improve performance and reliability.
FROM alpine:3.18

COPY /conf/nginx.conf /etc/nginx/nginx.conf

#if I just want to configure my own index.html
#COPY /conf/index.html /var/www/html/index.html


#Update and upgrade apk packages
# Install nginx and openssl
# Create a directory for the SSL certificate and private key
# Generate a self-signed SSL certificate
RUN apk update && apk upgrade \ 
	&& apk add --no-cache nginx openssl\
	&& mkdir -p /run/nginx /etc/nginx/ssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/certificate.key  -out /etc/nginx/ssl/certificate.crt \
	-subj "/C=FR/ST=Helsinki/L=Helsinki/O=42/OU=Hive/CN=yoonslee.42.fr" && \
	# mv /nginx-selfsigned.crt /etc/nginx/ssl/certificate.crt && \
    # mv /nginx-selfsigned.key /etc/nginx/ssl/certificate.key && \
	#add a new user within the nginx container
    addgroup -S www && \
	adduser -S -H -g "" www -G www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

EXPOSE 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]