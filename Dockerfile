FROM nginx:1.23.3
WORKDIR /etc/nginx
ADD nginx.conf /etc/nginx/nginx.conf
COPY ./build /usr/share/nginx/html
# Expose it on port 8080
EXPOSE 8080
ENTRYPOINT ["nginx","-g","daemon off;"]

# ==== CONFIGURE =====
# Use a Node 18 base image
FROM node:18 as development

RUN apt-get update -qq \
    && apt-get install -y nodejs \
    ca-certificates \
    curl \
    git \
    yarn \
    sudo \
    openssl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces/app

# ==== BUILD =====
# Copy app files
COPY package.json .
# Install dependencies (npm ci makes sure the exact versions in the lockfile gets installed)
RUN yarn install

# Copy the root folder to the docker container
COPY . .

VOLUME [ "/workspaces/app/node_modules" ]