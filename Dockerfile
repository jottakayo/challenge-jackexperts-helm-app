FROM nginx:alpine
COPY ./html /usr/share/nginx/html
RUN adduser -D -g 'jack' jack \
    && mkdir -p /var/run/nginx \
    && chown -R jack /var/cache/nginx \
    && chown -R jack /var/run \
    && chown -R jack /var/log/nginx \
    && chmod -R 755 /var/cache/nginx /var/run /var/log/nginx
USER jack