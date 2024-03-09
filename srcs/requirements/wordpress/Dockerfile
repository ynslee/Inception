FROM	alpine:3.18

RUN apk update && apk add --no-cache nginx && \
	adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	mv /etc/nginx/nginx.conf /etc/

#https://stackoverflow.com/questions/65627946/how-to-start-nginx-server-within-alpine-image-using-rc-service-command