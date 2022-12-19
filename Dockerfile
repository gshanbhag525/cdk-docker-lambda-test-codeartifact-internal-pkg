FROM public.ecr.aws/lambda/python:3.8

RUN pip install --upgrade pip
RUN pip install awscli

ENV AWS_ACCOUNT_ID your_aws_account_id
ENV AWS_DEFAULT_REGION your_aws_region
ENV AWS_ACCESS_KEY_ID your_access_key_id
ENV AWS_SECRET_ACCESS_KEY your_secret_access_key_id

ENV CODEARTIFACT_DOMAIN cdkpipelines-codeartifact
ENV CODEARTIFACT_REPO cdkpipelines-codeartifact-repository

RUN CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token --domain "${CODEARTIFACT_DOMAIN}" --domain-owner "${AWS_ACCOUNT_ID}" --query authorizationToken --output text)

# RUN echo "${CODEARTIFACT_AUTH_TOKEN}"

RUN PIP_INDEX_URL="https://aws:${CODEARTIFACT_AUTH_TOKEN}@${CODEARTIFACT_DOMAIN}-${AWS_ACCOUNT_ID}.d.codeartifact.${AWS_DEFAULT_REGION}.amazonaws.com/pypi/${CODEARTIFACT_REPO}/simple/"

#RUN echo ${PIP_INDEX_URL}

# Copy function code
COPY lambda/demo.py ${LAMBDA_TASK_ROOT}
COPY pip.conf /root/.pip/pip.conf

RUN pip install -U internalparser

RUN rm /root/.pip/pip.conf

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "demo.handler" ]