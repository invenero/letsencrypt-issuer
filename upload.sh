#!/bin/bash

. setup.sh
echo $CR_TOKEN

rm -rf .deploy
mkdir -p .deploy
helm package . --destination .deploy

cr upload -o $REPO -r letsencrypt-issuer -p .deploy

git checkout gh-pages

cr index -i ./index.yaml -p .deploy --owner $REPO -r letsencrypt-issuer --charts-repo https://$REPO.github.io/letsencrypt-issuer/

git add index.yaml
git commit -m "updated index.yaml"
git push

git checkout master
