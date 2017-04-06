#!/usr/bin/env bash

. /etc/profile.d/cf-stack-environment.sh

pushd /tmp > /dev/null

process-template.sh "./cwlogs.cfg.template" "./cwlogs.cfg"

curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
chmod +x ./awslogs-agent-setup.py
./awslogs-agent-setup.py -n -r us-east-1 -c ./cwlogs.cfg

popd