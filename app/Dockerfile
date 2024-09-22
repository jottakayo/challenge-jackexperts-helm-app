FROM --platform=linux/amd64 nginx:alpine
RUN adduser -D -g 'jack' jack \
    && mkdir -p /var/run/nginx /var/cache/nginx /var/log/nginx /usr/share/nginx/html \
    && chown -R jack:jack /var/run/nginx /var/cache/nginx /var/log/nginx /usr/share/nginx/html
COPY ./html /usr/share/nginx/html
RUN touch /var/run/nginx.pid \
    && chown -R jack:jack /var/run/nginx.pid \
    && chmod -R 755 /usr/share/nginx/html
RUN apk add --no-cache libcap \
    && setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx
EXPOSE 80
USER jack
CMD ["nginx", "-g", "daemon off;"]