#!/bin/bash

set -e

echo "Installing gems..."

bundle config path vendor/bundle
bundle install --jobs 4 --retry 3

echo "Building Jekyll site..."

JEKYLL_ENV=production bundle exec jekyll build $INPUT_JEKYLL_ARGS
