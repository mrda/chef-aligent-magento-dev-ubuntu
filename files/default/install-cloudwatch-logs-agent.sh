#!/usr/bin/env bash

. /etc/profile.d/cf-stack-environment.sh

pushd /root > /dev/null

process-template.sh "./cwlogs.cfg.template" "./cwlogs.cfg"

curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
chmod +x ./awslogs-agent-setup.py
./awslogs-agent-setup.py -n -r $AWS_REGION -c ./cwlogs.cfg

popd