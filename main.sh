#!/usr/bin/env bash

while IFS= read -r line
do
    domain=$(echo "$line" | jq -r '.domain')
    case $domain in
        'nagome')
            if [[ $(echo "$line" | jq -r '.command') = 'Broad.Open' ]]; then
                connectTime=$(date +%s)
            fi
            ;;
        'nagome_comment')
            commentDate=$(echo "$line" | jq -r '.content.date')
            # skip comments before connected
            if [[ $(date -d ${commentDate} +%s) -ge "$connectTime" ]]; then
                notify-send "Nagome comment" "$(echo "$line" | jq -r '.content.comment')"
            fi
            ;;
    esac
done
