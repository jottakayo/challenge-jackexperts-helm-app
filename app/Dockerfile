FROM --platform=linux/amd64 nginx:alpine
RUN adduser -D -g 'jack' jack \
    && mkdir -p /var/run/nginx /var/cache/nginx /var/log/nginx /usr/share/nginx/html \
    && chown -R jack:jack /var/run/nginx /var/cache/nginx /var/log/nginx /usr/share/nginx/html
COPY ./html /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
RUN touch /var/run/nginx.pid \
    && chown -R jack:jack /var/run/nginx.pid \
    && chmod -R 755 /usr/share/nginx/html
EXPOSE 8080
USER jack
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]