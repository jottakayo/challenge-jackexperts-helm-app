FROM nginx:alpine
RUN adduser -D -g 'jack' jack \
    && mkdir -p /var/run/nginx /var/cache/nginx /var/log/nginx /usr/share/nginx/html \
    && chown -R jack:jack /var/run/nginx /var/cache/nginx /var/log/nginx /usr/share/nginx/html
COPY ./html /usr/share/nginx/html
RUN touch /var/run/nginx.pid \
    && chown -R jack:jack /var/run/nginx.pid
USER jack
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
