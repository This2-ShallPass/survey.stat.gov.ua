FROM nginx:alpine

# del default conf
RUN rm /etc/nginx/conf.d/default.conf

# copy global nginx.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# copy server conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# copy landing
COPY --chown=nginx:nginx . /usr/share/nginx/html

# grant priv for nginx user for cache and logs
RUN chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /var/log/nginx

# switch to non-root
USER nginx

# open non priv port
EXPOSE 8080

# start as main procces 
CMD ["nginx", "-g", "daemon off;"]