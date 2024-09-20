FROM nginx:alpine
COPY ./html /usr/share/nginx/html
RUN adduser -D -g 'jack' jack \
    && mkdir -p /var/run/nginx /var/cache/nginx /var/log/nginx \
    && chown -R jack:jack /var/run/nginx /var/cache/nginx /var/log/nginx
USER root
CMD ["sh", "-c", "nginx && chown jack:jack /var/run/nginx/nginx.pid && su-exec jack nginx -g 'daemon off;'"]