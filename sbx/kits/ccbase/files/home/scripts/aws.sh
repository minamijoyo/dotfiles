#!/usr/bin/env bash

curl -s \
  -H"authorization: ${X_AWS_CONTAINER_AUTHORIZATION_TOKEN}" \
  "${X_AWS_CONTAINER_CREDENTIALS_FULL_URI/127.0.0.1/host.docker.internal}" \
  | jq '{Version: 1, AccessKeyId: .AccessKeyId, SecretAccessKey: .SecretAccessKey, SessionToken: .Token, Expiration: .Expiration}'
