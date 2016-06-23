#!/usr/bin/env bash
if [ -n "$AWS_STACK_NAME" -a -n "$AWS_ROLE_NAME" ]; then
	if [ "$AWS_STACK_NAME" == "env-prod" -o "$AWS_STACK_NAME" == "env-production" ]; then
	        export PS1="\[\033[38;5;9m\]$AWS_STACK_NAME\[$(tput sgr0)\] \[\033[38;5;10m\]$AWS_ROLE_NAME\[$(tput sgr0)\] $PS1"
	else
        	export PS1="\[\033[38;5;12m\]$AWS_STACK_NAME\[$(tput sgr0)\] \[\033[38;5;10m\]$AWS_ROLE_NAME\[$(tput sgr0)\] $PS1"
	fi
fi
