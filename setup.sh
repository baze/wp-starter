#!/bin/bash

THEME=wp-starter-theme

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

cd public/content/plugins/

wget -O acf-repeater.zip http://download.advancedcustomfields.com/$ACF_REPEATER_KEY/trunk/ && unzip acf-repeater.zip && rm acf-repeater.zip

wget -O acf-options-page.zip http://download.advancedcustomfields.com/$ACF_OPTIONS_PAGE_KEY/trunk/ && unzip acf-options-page.zip && rm acf-options-page.zip

# WP CLI
# ----------
wp core install

for PAGENAME in 'Startseite' 'Kontakt' 'Anfahrt' 'Impressum' 'Datenschutz'
do
	wp post create --post_type=page --post_title=$PAGENAME
done

wp plugin activate 'timber'
cd timber
composer install

for PLUGIN in 'contact-form-7' 'contact-form-7-honeypot' 'advanced-custom-fields' 'acf-repeater' 'acf-options-page' 'custom-post-type-ui' 'wp-plugin-dependencies' 'polylang' 'regenerate-thumbnails' 'reveal-ids-for-wp-admin-25' 'taxonomy-terms-order' 'wordpress-seo' 'AssetsMinify' 'mappress-google-maps-for-wordpress' 'redirection' 'wp-html-compression' 'stream' 'ewww-image-optimizer' 'wp-ban' 'defer-cf7-scripts'
do
    wp plugin activate $PLUGIN
done

wp theme activate $THEME