#!/bin/sh
# deploy.sh

cd public && find . -type f -exec curl --ftp-create-dirs -T {} -u $FTP_USER:$FTP_PASS ftp://$FTP_HOST/{} \;