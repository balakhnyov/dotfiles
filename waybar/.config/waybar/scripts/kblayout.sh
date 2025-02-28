#!/bin/bash

hyprctl -j devices | jq -r '.keyboards[] | select(.main) | .active_keymap' | sed -E 's/English \(US\)/us/; s/Russian/ru/'
