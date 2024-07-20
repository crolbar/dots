#!/usr/bin/env bash
curr_workspace_name=$(hyprctl activeworkspace -j | jq '.name' | tr -d '\"')

mapfile -t workspace_names < <(hyprctl workspaces -j | jq -r '.[].name')
IFS=$'\n' workspace_names=($(sort -n <<< "${workspace_names[*]}"))

for i in "${!workspace_names[@]}"; do
    if [[ "${workspace_names[$i]}" == "$curr_workspace_name" ]]; then
        curr_workspace_index=$i
    fi
done

if [[ "$1" == "down" ]]; then
    next_workspace_index=$((curr_workspace_index + 1))
    if [[ $next_workspace_index -lt ${#workspace_names[@]} ]]; then
        hyprctl dispatch workspace name:${workspace_names[$next_workspace_index]}
    fi
elif [[ "$1" == "up" ]]; then 
    prev_workspace_index=$((curr_workspace_index - 1))
    if [[ $prev_workspace_index -ge 0 ]]; then
        hyprctl dispatch workspace name:${workspace_names[$prev_workspace_index]}
    fi
fi
