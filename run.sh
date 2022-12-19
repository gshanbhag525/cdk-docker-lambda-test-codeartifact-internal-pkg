#!/usr/bin/env bash

AWS_ACCOUNT_ID="your_acc_id"
AWS_DEFAULT_REGION="your_region"
AWS_ACCESS_KEY_ID="your_access_key_id"
AWS_SECRET_ACCESS_KEY="your_secret_access_key_id"

CODEARTIFACT_DOMAIN="cdkpipelines-codeartifact"
CODEARTIFACT_REPO="cdkpipelines-codeartifact-repository"

CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token --domain "${CODEARTIFACT_DOMAIN}" --domain-owner "${AWS_ACCOUNT_ID}" --query authorizationToken --output text --duration-seconds 900)

#echo "${CODEARTIFACT_AUTH_TOKEN}"

PIP_INDEX_URL="https://aws:${CODEARTIFACT_AUTH_TOKEN}@${CODEARTIFACT_DOMAIN}-${AWS_ACCOUNT_ID}.d.codeartifact.${AWS_DEFAULT_REGION}.amazonaws.com/pypi/${CODEARTIFACT_REPO}/simple/"

echo "${PIP_INDEX_URL}"
