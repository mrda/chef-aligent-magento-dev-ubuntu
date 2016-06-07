#!/bin/bash

TARGETS=(/etc/nginx/nginx.conf /etc/my.conf)

for target in ${TARGETS[@]}; do
    template="${target}.template"

    process-template.sh "${template}" "${target}"
done
