FROM php:8.2.27-fpm

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add Composer to the PATH
ENV PATH="$PATH:/usr/local/bin"
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install necessary packages and libraries in one step
RUN apt-get update && apt-get -y install --fix-missing \
    apt-utils nano wget dialog vim build-essential git curl \
    libcurl4 libcurl4-openssl-dev zlib1g-dev libzip-dev zip \
    libbz2-dev locales libmcrypt-dev libicu-dev libonig-dev \
    libxml2-dev libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set the working directory
WORKDIR /var/www

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 20.9.0

# Create NVM directory and install nvm, node, and npm
RUN mkdir -p $NVM_DIR && \
    curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.40.1/install.sh | bash && \
    source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# Add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Confirm installation
RUN node -v
RUN npm -v


# Expose the port
EXPOSE 9000

# Define the entry point
CMD ["php-fpm"]
