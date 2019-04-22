#!/bin/bash

rsync -azP --exclude '.DS_Store' public/ $SSH_USER@$SSH_HOST:$BLOG_DIR/$1/
