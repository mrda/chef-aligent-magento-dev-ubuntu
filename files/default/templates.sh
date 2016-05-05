#!/bin/bash

for target in /etc/varnish/default.vcl /etc/my.conf; do

    template="${target}.template"

    process-template.sh $template $target
done
