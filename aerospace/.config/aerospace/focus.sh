#!/bin/bash

# Optional: Switch to a clean workspace first
aerospace workspace 3

# 1. Open the first app (this will take up 100% of the screen initially)
open -n -a Ghostty --args --title='spotatui' -e 'fish' '-i' '-c' 's'
sleep 0.6 # Wait for the window to actually render

# 2. Open the second app (AeroSpace will automatically tile it next to the first)
open -n -a Ghostty --args --title='pomo' -e 'fish' '-i' '-c' 'pomo'
sleep 0.6

# 3. Position the windows
# AeroSpace usually puts the newest window on the right.
# If you want Ghostty on the left instead, move it:
# aerospace move left

# 4. Resize the focused window
# You can change the width by an absolute pixel amount (e.g., make it 800px wide)
aerospace resize width +400

# Or you can adjust it relative to its current size (+/- pixels)
# aerospace resize width +200
