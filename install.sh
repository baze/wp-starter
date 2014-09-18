#!/bin/bash

THEME=wp-starter-theme

DB_USER=root
DB_PASSWORD=root
DB_HOST=192.168.1.55
DB_HOST_PORT=8889

DB_NAME=wp_starter

# Set up the database
# ----------
mysql --user=$DB_USER --password=$DB_PASSWORD --host=$DB_HOST --port=$DB_HOST_PORT <<QUERY_INPUT
CREATE DATABASE IF NOT EXISTS $DB_NAME;
SHOW DATABASES;
QUERY_INPUT

# WP CLI
# ----------

wp core install

wp theme activate $THEME

wp rewrite structure '/%year%/%monthnum%/%day%/%postname%/' --hard

for PAGENAME in 'Startseite' 'Kontakt' 'Anfahrt' 'Impressum' 'Datenschutz'
do
	wp post create --post_type=page --post_title=$PAGENAME
done

wp plugin install 'timber-library' --activate

# 'mappress-google-maps-for-wordpress' is currently broken
for PLUGIN in 'advanced-custom-fields' 'contact-form-7' 'contact-form-7-honeypot' 'custom-post-type-ui' 'ewww-image-optimizer' 'polylang' 'redirection' 'regenerate-thumbnails' 'reveal-ids-for-wp-admin-25' 'stream' 'taxonomy-terms-order' 'wordpress-importer' 'wordpress-seo' 'wp-ban' 'wp-html-compression'
do
    wp plugin install $PLUGIN --activate
done

# ACF non-free plugins
# ----------

# Set your ACF Keys
ACF_REPEATER_KEY=
ACF_OPTIONS_PAGE_KEY=

if [ -z "$ACF_REPEATER_KEY" ]; then
   echo "Please provide your ACF_REPEATER_KEY"
   exit 1
fi

if [ -z "$ACF_OPTIONS_PAGE_KEY" ]; then
   echo "Please provide your ACF_OPTIONS_PAGE_KEY"
   exit 1
fi

pushd public/content/plugins/

wget -O acf-repeater.zip http://download.advancedcustomfields.com/$ACF_REPEATER_KEY/trunk/ && unzip acf-repeater.zip && rm acf-repeater.zip
wget -O acf-options-page.zip http://download.advancedcustomfields.com/$ACF_OPTIONS_PAGE_KEY/trunk/ && unzip acf-options-page.zip && rm acf-options-page.zip

popd

wp plugin activate 'acf-repeater'
wp plugin activate 'acf-options-page'