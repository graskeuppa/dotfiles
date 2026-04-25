#!/bin/bash

aerospace workspace 3

open -n -a Ghostty --args --title='spotatui' -e 'fish' '-i' '-c' 's'
sleep 0.6

open -n -a Ghostty --args --title='pomo' -e 'fish' '-i' '-c' 'pomo'
sleep 0.6

aerospace resize width +400
