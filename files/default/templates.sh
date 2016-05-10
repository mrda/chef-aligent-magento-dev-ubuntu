#!/bin/bash

for target in /etc/nginx/nginx.conf /etc/my.conf; do

    template="${target}.template"

    process-template.sh $template $target
done
