#!/bin/sh

git config user.email "EMAIL"

git filter-branch --env-filter '
GIT_COMMITTER_EMAIL="EMAIL"
GIT_AUTHOR_EMAIL="EMAIL"
' --tag-name-filter cat -- --branches --tags
