#!/usr/bin/env bash
if [ -n "$AWS_STACK_NAME" -a -n "$AWS_ROLE_NAME" ]; then
    if [ "$AWS_STACK_NAME" == "env-prod" -o "$AWS_STACK_NAME" == "env-production" ]; then
        color="\[\033[38;5;9m\]"
    else
        color="\[\033[38;5;12m\]"
    fi
fi

export PS1="$color$AWS_STACK_NAME\[$(tput sgr0)\] \[\033[38;5;10m\]$AWS_ROLE_NAME\[$(tput sgr0)\] [\u@\h] \W\$ "


