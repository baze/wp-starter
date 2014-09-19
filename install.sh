#!/bin/bash



# ------------ CONFIGURE THIS ------------
SITE_NAME=
THEME_NAME=wp-starter-theme
DB_NAME=

MY_IP=192.168.1.99
MY_PORT=8080
MY_SUBPATH=sites/

DB_USER=root
DB_PASSWORD=root
DB_HOST=192.168.1.55
DB_PORT=8889



# ------------ ACF non-free plugin keys ------------
ACF_REPEATER_KEY=
ACF_OPTIONS_PAGE_KEY=



# ------------ Usage ------------
usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -h      Show this message
   -t      Theme name
   -s      Site name
   -d      Database name

EXAMPLE:
   $0 -t my_theme -s my_site
EOF
}



# ------------ Parameters ------------
while getopts "h:s:t:d:" OPTION
do
  case $OPTION in
  	h)
		usage
		exit 1
		;;
    s)
		SITE_NAME=$OPTARG
		;;
	t)
		THEME_NAME=$OPTARG
		;;
	d)
		DB_NAME=$OPTARG
		;;
    ?)
		usage
		exit 1
		;;
  esac
done

if [[ -z $SITE_NAME ]] || [[ -z $THEME_NAME ]] || [[ -z $DB_NAME ]]
then
     usage
     exit 1
fi


# ------------ Set up the database ------------
echo "--- Setting up database ---"
mysql --user=$DB_USER --password=$DB_PASSWORD --host=$DB_HOST --port=$DB_PORT << QUERY_INPUT
CREATE DATABASE IF NOT EXISTS $DB_NAME;
QUERY_INPUT



# ------------ WordPress installation ------------
echo "--- Cloning repository---"
git clone --recursive git@github.com:baze/wp-starter.git $SITE_NAME



echo "--- Configuring installation ---"
cd $SITE_NAME

rm public/wp-config.php

# configure
wp core config --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST:$DB_PORT

cat << EOF > public/wp-config.php
<?php

define('APP_ROOT', dirname(__DIR__));
// define('APP_ENV', getenv('APPLICATION_ENV'));
// define('APP_ENV', 'development');

define('WP_HOME', 'http://$MY_IP:$MY_PORT/$MY_SUBPATH$SITE_NAME/public');
define('WP_SITEURL', WP_HOME . '/wordpress/');

define('WP_CONTENT_DIR', APP_ROOT . '/public/content');
define('WP_CONTENT_URL', WP_HOME . '/content');

define('WP_DEBUG', false);

EOF

tail -n +2 public/wordpress/wp-config.php >> public/wp-config.php

rm public/wordpress/wp-config.php



echo "--- Installing WordPress ---"
wp core install

wp theme activate $THEME_NAME

wp plugin install 'timber-library' --activate

for PLUGIN in 'advanced-custom-fields' 'contact-form-7' 'contact-form-7-honeypot' 'custom-post-type-ui' 'ewww-image-optimizer' 'polylang' 'redirection' 'regenerate-thumbnails' 'reveal-ids-for-wp-admin-25' 'stream' 'taxonomy-terms-order' 'wordpress-importer' 'wordpress-seo' 'wp-ban' 'wp-html-compression'
do
    wp plugin install $PLUGIN --activate
done

# 'mappress-google-maps-for-wordpress' is currently broken
wp plugin deactivate mappress-google-maps-for-wordpress



echo "--- Installing ACF non-free plugins ---"

pushd public/content/plugins/

if [ ! -z "$ACF_REPEATER_KEY" ]; then
	wget -O acf-repeater.zip http://download.advancedcustomfields.com/$ACF_REPEATER_KEY/trunk/ && unzip acf-repeater.zip && rm acf-repeater.zip
	wp plugin activate 'acf-repeater'
fi

if [ ! -z "$ACF_OPTIONS_PAGE_KEY" ]; then
	wget -O acf-options-page.zip http://download.advancedcustomfields.com/$ACF_OPTIONS_PAGE_KEY/trunk/ && unzip acf-options-page.zip && rm acf-options-page.zip
	wp plugin activate 'acf-options-page'
fi

popd



echo "--- Creating Pages ---"
for PAGENAME in 'Startseite' 'Kontakt' 'Anfahrt' 'Impressum' 'Datenschutz'
do
	wp post create --post_type=page --post_title=$PAGENAME
done

wp rewrite structure '/%year%/%monthnum%/%day%/%postname%/' --hard



URL=http:$MY_IP:$MY_PORT/$MY_SUBPATH$SITE_NAME/public
echo "--- All done! Visit $URL ---"
open $URL
