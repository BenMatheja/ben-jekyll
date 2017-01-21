#!/bin/sh

rsync -crvz --chown=www-data:www-data --delete-after --delete-excluded _site root@srv2.benmatheja.de:/var/www/benmatheja.de/jekyll 
ssh root@srv2.benmatheja.de 'chown -R www-data:www-data /var/www/benmatheja.de/jekyll'
