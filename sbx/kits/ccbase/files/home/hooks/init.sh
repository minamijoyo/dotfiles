#!/bin/bash

set -eo pipefail

# TerraformのAWSプロバイダでprofileを指定すると環境変数の指定が無視される問題の回避策として
# AWS_PROFILEが指定されている場合は、環境変数の一時認証情報をaws configureで設定する
if [ -n "$AWS_PROFILE" ]; then
  aws configure --profile "$AWS_PROFILE" set region "$AWS_REGION"
  aws configure --profile "$AWS_PROFILE" set aws_access_key_id "$AWS_ACCESS_KEY_ID"
  aws configure --profile "$AWS_PROFILE" set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
  aws configure --profile "$AWS_PROFILE" set aws_session_token "$AWS_SESSION_TOKEN"
fi
