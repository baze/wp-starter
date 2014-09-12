<?php # -*- coding: utf-8 -*-
declare( encoding = 'UTF-8' );
/**
 * Plugin Name: Defer Contact Form 7 Scripts
 * Description: Adds <code>defer='defer'</code> to enqueued javascripts.
 * Version:     1.0
 * Required:    3.3
 * Author:      Thomas Scholz
 * Author URI:  http://toscho.de
 * License:     GPL
 * License URI: http://www.gnu.org/copyleft/gpl.html
 *
 *
 * Defer Scripts, Copyright (C) 2011 Thomas Scholz
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

! defined( 'ABSPATH' ) and exit;

if ( ! function_exists( 'add_defer_to_cf7' ) )
{
	function add_defer_to_cf7( $url )
	{
	    if ( // comment the following line out add 'defer' to all scripts
	    FALSE === strpos( $url, 'contact-form-7' ) or
	    FALSE === strpos( $url, '.js' )
	    )
	    { // not our file
	        return $url;
	    }
	    // Must be a ', not "!
	    return "$url' defer='defer";
	}
	add_filter( 'clean_url', 'add_defer_to_cf7', 11, 1 );
}