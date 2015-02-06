#!/bin/sh
# =============================================================================
# Description:
#   Postprocess a timestamped BitBake build.log in order to identify
#   possible build time bottlenecks or inefficiencies.
#
# Usage:
#   $ bblog-analyze.sh <path-to-timestamped-build.log>
#
# Notes:
#   To create a timestamped build.log the script "prepend-timestamp.sh"
#   can be used, like in the following example
#   $ bitbake core-image-minimal | prepend-timestamp.sh | tee my-build.log
#
# Result:
#   The following files will be created in current directory:
#   1. <timestamped-build>-analysis-<now>.txt
#   2. <timestamped-build>-summary-<now>.csv
# =============================================================================

BUILDLOG=$1
#BUILDLOG=tests/my-build.log

if [ "${BUILDLOG}" = "" ]; then
  echo "ERROR: Usage $(basename $0) <path-to-timestamped-build.log>"
  exit 1
fi
if [ ! -e "${BUILDLOG}" ]; then
  echo "ERROR: Cannot open ${BUILDLOG}"
  exit q
fi

NOW=$(date '+%Y%m%d-%H%M')
#NOW=test

OUTFILE=$(basename ${BUILDLOG})-analysis-${NOW}.txt
echo "DEBUG: OUTFILE=${OUTFILE}"

CSVFILE=$(basename ${BUILDLOG})-summary-${NOW}.csv
echo "DEBUG: CSVFILE=${CSVFILE}"

echo "INFO: Analyzing BUILDLOG"
wc -l ${BUILDLOG}

#cat ${BUILDLOG} | grep NOTE | grep Started
#cat ${BUILDLOG} | grep NOTE | grep Running
#cat ${BUILDLOG} | grep NOTE | grep Succeeded

#cat ${BUILDLOG} | grep NOTE | grep sys-image
#cat ${BUILDLOG} | grep NOTE | grep linux

# Leftovers
#cat ${BUILDLOG} | grep NOTE | grep -v Started | grep -v Running | grep -v Succeeded

cat ${BUILDLOG} | gawk '
function now_to_tm(now) {
              now_str = substr(now, 1, 4)
              now_str = now_str " " substr(now, 6, 2)
              now_str = now_str " " substr(now, 9, 2)
              now_str = now_str " " substr(now, 12, 2)
              now_str = now_str " " substr(now, 15, 2)
              now_str = now_str " " substr(now, 18, 2)
              tm = mktime(now_str)
              return tm
            }
BEGIN       {
              print "INFO: Analysis start"
              date_firstevent = 0;
              date_lastevent = 0;
              # Format of events["pkg/task/begin/event"] = tm
              #events["1"] = "OK"
              #events["2"] = "KO"
            }
/Started/   {
              #print "DEBUG: Started: $0=" $0
              now = substr($0, 1, index($0, "NOTE")-2)
              #print "DEBUG: now=" now
              tm = now_to_tm(now)
              pkg=$5
              gsub(/:/, "", pkg)
              task=$7
              gsub(/:/, "", task)
              print "INFO: TASK STARTED: now=" now ", tm=" tm ", pkg=" pkg ", task=" task
              # TODO if (date_firstevent == 0)...
              # TODO if (date_lastevent < tm)...
              events[pkg "/" task "/STARTED"] = tm
              next;
            }
/Succeeded/ {
              #print "DEBUG: Succeeded: $0=" $0
              now = substr($0, 1, index($0, "NOTE")-2)
              tm = now_to_tm(now)
              pkg=$5
              gsub(/:/, "", pkg)
              task=$7
              gsub(/:/, "", task)
              print "INFO: TASK SUCCEED: now=" now ", tm=" tm ", pkg=" pkg ", task=" task
              # TODO if (date_firstevent == 0)...
              # TODO if (date_lastevent < tm)...
              events[pkg "/" task "/SUCCEED"] = tm
              next;
            }
END         {
              print "INFO: Analysis ending"

              #print "DEBUG: Before printing events"
              for (k in events) {
                  tm = events[k]
                  #print "DEBUG: k=" k ", tm=" tm
                  if (k ~ /SUCCEED/) {
                      # Find when the event started
                      k1 = k;
                      gsub(/SUCCEED/, "STARTED", k1)
                      tm1 = events[k1];
                      #print "DEBUG: k1=" k ", tm1=" tm1 ", delta=" (tm - tm1)
                      pkg = substr(k, 1, index(k, "/")-1)
                      #task = "???"
                      task = substr(k, length(pkg)+2)
                      task = substr(task, 1, index(task, "/")-1)
                      #str_tm1 = strftime("???", tm1)
                      #print "INFO: pkg=" pkg ", task=" task ", start=" tm1 ", elapsed=" (tm - tm1)
                      #print "SUMMARY, " pkg ", " task ", " tm1 ", " (tm - tm1)
                      print "\"STARTED-SUCCEED\", \"" pkg "\", \"" task "\", " tm1 ", " (tm - tm1)
                    }
              }
              #print "DEBUG: After printing events"

            }
' >${OUTFILE}

echo "INFO: Analysis created as ${OUTFILE}"

echo "INFO: Analyzing OUTFILE"
wc -l ${OUTFILE}

echo "INFO: Creating summary CSV as ${CSVFILE}"
grep "^\"STARTED-SUCCEED\"" <${OUTFILE} >${CSVFILE}

echo "INFO: Analyzing CSVFILE"
wc -l ${CSVFILE}

# EOF
