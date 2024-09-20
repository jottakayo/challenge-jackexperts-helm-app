FROM nginx:alpine
RUN adduser -D -g 'jack' jack \
    && mkdir -p /var/run/nginx /var/cache/nginx /var/log/nginx \
    && chown -R jack:jack /var/run/nginx /var/cache/nginx /var/log/nginx /usr/share/nginx/html
COPY ./html /usr/share/nginx/html
USER root
CMD ["nginx", "-g", "daemon off;"]