#!/bin/sh
# =============================================================================================================
# Prepend timestamp to each line on stdin
#
# Usage: $ cat somefile.txt | prepend-timestamp.sh
#
# Credits:
# http://stackoverflow.com/questions/21564/is-there-a-unix-utility-to-prepend-timestamps-to-lines-of-text
# =============================================================================================================

awk '{ print strftime("%Y-%m-%d %H:%M:%S"), $0; fflush(); }'

# === EOF ===
