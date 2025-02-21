# Use official PHP with FPM and PostgreSQL support
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    nano \
    unzip \
    git \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    postgresql-client \
    bash \
    && docker-php-ext-install \
    pdo \
    pdo_pgsql \
    pgsql \
    zip \
    gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install NVM (Node Version Manager) and Node.js
ENV NVM_DIR /root/.nvm
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install 20 && \
    nvm use 20 && \
    nvm alias default 20 && \
    npm install -g npm

# Ensure NVM and Node.js are available for all users
ENV NODE_VERSION 20
ENV PATH "$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH"

# Set working directory
WORKDIR /var/www

# Set permissions
RUN chown -R www-data:www-data /var/www

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
