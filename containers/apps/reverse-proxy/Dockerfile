# ### STAGE 1: Build ###
# # We label our stage as ‘builder’
# FROM node:12 as node

# # build-time variables
# # prod|sandbox its value will be come from outside
# ARG env=prod

# # Create a directory where our app will be placed
# RUN mkdir -p /usr/src/app
# # Change directory so that our commands run inside this new directory

# WORKDIR /usr/src/app

# # Copy dependency definitions

# COPY ../../../../hl7-diff-tool-frontend/package.json /usr/src/app
# # Install dependecies

# RUN npm install
# # Get all the code needed to run the app

# COPY ../../../../hl7-diff-tool-frontend/ /usr/src/app

# # Run the angular in product
# RUN npm run build:$env



# # Pull base image.
# FROM ubuntu-base

# RUN \
#   gpg --keyserver hkp://keyserver.ubuntu.com:80 \
#       --recv-keys 8B3981E7A6852F782CC4951600A6F0A3C300EE8C && \
#   add-apt-repository -y ppa:nginx/stable && \
#   apt-get update && \
#   apt-get install -y nginx && \
#   rm -rf /var/lib/apt/lists/* && \
#   chown -R www-data:www-data /var/lib/nginx

# # Copy default webpage
# # RUN rm /var/www/html/index.nginx-debian.html && \
# #     rm /etc/nginx/sites-enabled/*
# # COPY html/index.html /var/www/html/index.html
# # COPY html/robots.txt /var/www/html/robots.txt

# COPY config/nginx.conf /etc/nginx/nginx.conf
# # The child image will copy over the default.conf

# ## From ‘builder’ stage copy over the artifacts in dist folder to default nginx public folder
# RUN mkdir -p /etc/app
# COPY --from=node /usr/src/app/dist /etc/app

# # Define mountable directories.
# VOLUME ["/etc/nginx/certs", "/var/log/nginx", "/var/www/html"]

# RUN apt-get update && apt-get install -y iputils-ping net-tools bind9-host
# RUN chmod 4755 /bin/ping

# ARG serverhost=localhost
# ARG servercer=certs/hit-dev.crt
# ARG serverkey=certs/hit-dev.key
# # ARG servercer=certs/cert.pem
# # ARG serverkey=certs/key.pem

# COPY config/nginx-default.conf /tmp/default.conf.in
# RUN sed -e '/server_name/ s/_;/'$serverhost';/' /tmp/default.conf.in \
#         > /etc/nginx/conf.d/default.conf

# COPY $servercer /etc/ssl/certs/localhost.crt
# COPY $serverkey /etc/ssl/private/localhost.key

# CMD nginx


### STAGE 1: Build ###
# We label our stage as ‘builder’
FROM node:12 as node

# build-time variables
# prod|sandbox its value will be come from outside
ARG env=prod

# Create a directory where our app will be placed
RUN mkdir -p /usr/src/app
# Change directory so that our commands run inside this new directory

WORKDIR /usr/src/app

# Copy dependency definitions

COPY ./hl7-diff-tool-frontend/package.json /usr/src/app
# Install dependecies

RUN npm install
# Get all the code needed to run the app

COPY ./hl7-diff-tool-frontend/ /usr/src/app

# Run the angular in product
RUN npm run build:$env


### STAGE 2: Setup ###
FROM nginx:1.21.5
## Copy our default nginx config
COPY ./hl7-diff-tool-infra/containers/apps/reverse-proxy/config/nginx-default.conf /etc/nginx/conf.d/default.conf

## From ‘builder’ stage copy over the artifacts in dist folder to default nginx public folder
RUN mkdir -p /etc/app
COPY --from=node /usr/src/app/dist /etc/app


CMD ["nginx", "-g", "daemon off;"]