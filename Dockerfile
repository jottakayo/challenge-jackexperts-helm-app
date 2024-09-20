FROM nginx:alpine
COPY ./html /usr/share/nginx/html
RUN adduser -D -g 'jack' jack \
    && mkdir -p /var/run/nginx \
    && chown -R jack:jack /var/run/nginx /var/cache/nginx /var/log/nginx \
    && chmod -R 755 /var/run/nginx /var/cache/nginx /var/log/nginx
USER jack