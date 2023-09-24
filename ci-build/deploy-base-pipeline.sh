#!/bin/bash

npm install aws-cdk-lib
. ~/.bash_profile
cdk bootstrap aws://$AWS_ACCOUNT_ID/$AWS_REGION
npm install
cdk deploy --app "npx ts-node --prefer-ts-exts ./base-pipeline.ts"  --parameters BASEREPO=$BASE_REPO --parameters BASEIMAGETAG=$BASE_TAG --parameters BASEIMAGEAMDTAG=$BASE_AMD_TAG --parameters BASEIMAGEARMTAG=$BASE_ARM_TAG --parameters GITHUBREPO=$GITHUB_REPO --parameters GITHUBUSER=$GITHUB_USER --parameters GITHUBBRANCH=$GITHUB_BRANCH --parameters GITHUBOAUTHTOKEN=$GITHUB_OAUTH_TOKEN
