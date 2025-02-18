#!/usr/bin/env bash

HEADER=$'/**\n * Generated stub declarations for Yoast.\n * @see https://yoast.com/\n * @see https://github.com/php-stubs/wordpress-seo-stubs\n */'

FILE="wordpress-seo-stubs.php"

set -e

test -f "$FILE"
test -d "source/wordpress-seo"

# Exclude globals.
"$(dirname "$0")/vendor/bin/generate-stubs" \
    --force \
    --finder=finder.php \
    --header="$HEADER" \
    --functions \
    --classes \
    --interfaces \
    --traits \
    --out="$FILE"

printf '\nnamespace Yoast\\WP\\Free\\Loggers { class Migration_Logger {} }\n' >>"$FILE"

# There are no WC functions to read these constants.
# See define_constants() in includes/class-woocommerce.php
printf '\nnamespace {\n    %s\n}\n' "define('WPSEO_VERSION', '0.0.0');" >>"$FILE"
