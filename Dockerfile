FROM nginx:alpine
COPY ./html /usr/share/nginx/html
RUN adduser -D -g 'jack' experts
USER jack