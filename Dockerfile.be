# Use the official image as a parent image
FROM php:8.2.4 

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install pdo pdo_mysql gd


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Allow plugins to run as superuser
ENV COMPOSER_ALLOW_SUPERUSER=1

# Copy the current directory contents into the container at /app
COPY . /app

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql gd

# Install dependencies
RUN composer install --no-plugins --no-scripts --prefer-dist --no-interaction

# Expose port to allow communication to/from server
EXPOSE XX

# Run the application
CMD ["php", "artisan", "serve", "--host", "0.0.0.0"]



