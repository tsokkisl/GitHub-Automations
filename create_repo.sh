#!/usr/bin/env bash

# This script creates and syncs remote and local GitHub repositories

# Set GitHub API token from .env
token=`cat .env | grep TOKEN= | cut -d '=' -f2`

# Set current directory name as the repository name
repository_name=`pwd | rev| cut -d '/' -f 1 | rev`

# Create remote repository and get origin
origin=`curl -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $token" -d '{"name": "'"$repository_name"'"}' https://api.github.com/user/repos | jq -r '.clone_url'`

# Initialise local reporistory and sync with remote
git init

git remote add origin $origin

git remote -v