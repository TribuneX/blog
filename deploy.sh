#!/bin/bash

SRC=~/git/blog.farb-foto.de/public/
DST=ssh-w01250de@w00b42f4.kasserver.com:/www/htdocs/w01250de/blog.farb-foto.de/

rsync -azP --exclude '.DS_Store' $SRC $DST
