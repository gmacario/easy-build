#!/bin/sh
# ==========================================================
# Purpose: This script invokes bblog-analyze.sh
# for each timestamped BitBake logfile under ${LOGFILES}.
# The corresponding output files are saved under ${OUTDIR}.
# ==========================================================

set -e
#set -x

LOGFILES=${PWD}/logs/*.log
OUTDIR=${PWD}/out

BBLOG_ANALYZE=bblog-analyze.sh
BBLOG_ANALYZE_URL=https://raw.githubusercontent.com/gmacario/easy-build/master/tools/${BBLOG_ANALYZE}

# Check whether the BBLOG_ANALYZE script is already available
BBLOG_ANALYZE_PATH=$(which ${BBLOG_ANALYZE} 2>/dev/null) || {
  echo "WARNING: Cannot find ${BBLOG_ANALYZE}"
  echo "INFO: Fetching script from ${BBLOG_ANALYZE_URL}"
  curl -O ${BBLOG_ANALYZE_URL}
  chmod 755 ${BBLOG_ANALYZE}
  BBLOG_ANALYZE_PATH=${PWD}/${BBLOG_ANALYZE}
}
echo "INFO: ${BBLOG_ANALYZE} installed at ${BBLOG_ANALYZE_PATH}"

mkdir -p ${OUTDIR}
pushd ${OUTDIR}
# Run the script against all the tests in tests/
for f in ${LOGFILES}; do
  echo "INFO: Analyzing $f"
  ${BBLOG_ANALYZE_PATH} $f
done
popd

# EOF
