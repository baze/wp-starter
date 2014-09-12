<?php

//include dirname(__DIR__) . '/config/wordpress.php';

/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 * @package WordPress
 */

define('APP_ROOT', dirname(__DIR__));
// define('APP_ENV', getenv('APPLICATION_ENV'));

define('APP_ENV', 'development');

/** Require environment-specific configuration */


define('WP_HOME', 'http://127.0.0.1:8080/sites/wp-starter/public');
define('WP_SITEURL', WP_HOME . '/wordpress/');

define('WP_CONTENT_DIR', APP_ROOT . '/public/content');
define('WP_CONTENT_URL', WP_HOME . '/content');

define('WP_DEBUG', true);

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wp-starter');

/** Ersetze username_here mit deinem MySQL-Datenbank-Benutzernamen */
define('DB_USER', 'root');

/** Ersetze password_here mit deinem MySQL-Passwort */
define('DB_PASSWORD', 'root');

/** Ersetze localhost mit der MySQL-Serveradresse */
define('DB_HOST', '127.0.0.1');

/** Der Datenbankzeichensatz der beim Erstellen der Datenbanktabellen verwendet werden soll */
define('DB_CHARSET', 'utf8');

/** Der collate type sollte nicht geändert werden */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY', 'X[uUOZ3]{C@k.jTt_:xmfL1-pd-E_42E[+YLeM6K$ky}NTo-+x+=-rs:|[!>6|`H');
define('SECURE_AUTH_KEY', '!<UW~)d&8a8Zl33e[nec24:vP)Z_.Lht^sj#5-[#V+`Y>-G-|EbZGha</*=|aPF1');
define('LOGGED_IN_KEY', '@$g!,VL`xw]Dwn!d /.E|!ixa1m8M|S@Tks)dL<|lrA}ys1]u8[1NUFhLi?$POpD');
define('NONCE_KEY', 'e6cvQv(H[p 7jP&#{*Bf5xy0]NhY__+RsA+Y{45f%([a&*Mh=B##}CXj;3t4nBr!');
define('AUTH_SALT', '.+-WP/mw-xkhrR!{G-hU#lYx]ei`IX*:*G5|h/lm U@!bYqw%rO}n6S*/%A] t q');
define('SECURE_AUTH_SALT', '9];f#YY<BhLnBKlNuIt+Bu*PZ+?SP6dVW]N.Uak{W>Jt>)%95n[Lv<3ZOwkHI_5S');
define('LOGGED_IN_SALT', '|^@5!S[E,!m6ZpSz{=u?|Zx>Z|;2^.sPK?PC6;.NE2[h|Xf098M~7kOz$yoH?0Vl');
define('NONCE_SALT', 'Hx5d+Vz=&4/o0t8qPTW i#!{.Q Ytp1+K(3N,)c*[j+N,Zh[MTiBlXl5C&N.t2mz');


// require APP_ROOT . '/config/env/development.php';

/** Require Composer autoload file */
// require APP_ROOT . '/vendor/autoload.php';


/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', 'de_DE');

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if (!defined('ABSPATH'))
    define('ABSPATH', dirname(dirname(__FILE__)) . '/public/wordpress/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');