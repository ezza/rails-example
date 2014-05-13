#!/bin/bash
set -e

google-chrome --version

echo '--- bundling'
# export AMAZON_S3_BUCKET=...
# export AMAZON_ACCESS_KEY_ID=...
# export AMAZON_SECRET_ACCESS_KEY=...
export TRAVIS_RUBY_VERSION=`cat .ruby-version`
export TRAVIS_REPO_SLUG=$BUILDBOX_PROJECT_SLUG
./script/cached-bundle install --deployment

echo '--- preparing database'
./bin/rake db:create
./bin/rake db:schema:load

# echo '--- setting up sphinx'
# ./bin/rake ts:configure
# ./bin/rake ts:start

echo '--- running specs'
./bin/rspec
