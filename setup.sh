#!/bin/bash

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

# git clone --recursive git@github.com:baze/wp-starter-theme.git
# cd wp-starter

cd public/content/plugins/

wget -O acf-repeater.zip http://download.advancedcustomfields.com/$ACF_REPEATER_KEY/trunk/ && unzip acf-repeater.zip && rm acf-repeater.zip

wget -O acf-options-page.zip http://download.advancedcustomfields.com/$ACF_OPTIONS_PAGE_KEY/trunk/ && unzip acf-options-page.zip && rm acf-options-page.zip

