#!/bin/bash

. /etc/profile.d/cf-stack-environment.sh

for target in /etc/varnish/default.vcl /etc/my.conf; do

    template="${target}.template"

    if [ -f $template ]; then
        sed -e "s/%BACKEND_ELB_HOST_NAME%/$BACKEND_ELB_HOST_NAME/g" \
            -e "s/%AWS_REGION%/$AWS_REGION/" \
            < $template > $target
    fi
done
