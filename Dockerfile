FROM nginx:alpine
COPY ./html /usr/share/nginx/html
RUN adduser -D -g 'jack' jack \
    && chown -R jack /var/cache/nginx \
    && chown -R jack /var/run \
    && chown -R jack /var/log/nginx
USER jack