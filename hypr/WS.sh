#!/bin/bash
workspaces_per_monitor=5
monitor1="DP-1"
monitor2="DP-2"
for ((workspace=1; workspace <= workspaces_per_monitor; workspace++)); do
  echo "wsbind=$workspace,$monitor1"
done
for ((workspace=workspaces_per_monitor+1; workspace <= 2*workspaces_per_monitor; workspace++)); do
  echo "wsbind=$workspace,$monitor2"
done
