FROM alpine:3.5

RUN apk --update add \
    bash nano vim \
    ca-certificates \
    nginx && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/nginx/sites-available && \
    mkdir -p /etc/nginx/sites-enabled

ADD docker/nginx/docker-nginx.conf /etc/nginx/nginx.conf
ADD docker/nginx/docker-web.conf /etc/nginx/sites-available/webapp.conf
RUN ln /etc/nginx/sites-available/webapp.conf /etc/nginx/sites-enabled/webapp

COPY webapp/config /var/www/
COPY webapp/public /var/www/
COPY webapp/src /var/www/
COPY webapp/.env.dist /var/www/.env
COPY webapp/composer.json /var/www/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

RUN adduser -D -g '' -G www-data www-data

EXPOSE 80

CMD ["nginx"]
