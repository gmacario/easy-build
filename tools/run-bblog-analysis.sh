#!/bin/sh
# ==========================================================
# Purpose: This script invokes bblog-analyze.sh
# for each available timestamped BitBake logile
# saved as *.log under ${LOGDIR}.
# The corresponding output files are saved under ${OUTDIR}
# ==========================================================

set -e
#set -x

BBLOG_ANALYZE=bblog-analyze.sh
BBLOG_ANALYZE_URL=https://raw.githubusercontent.com/gmacario/easy-build/master/tools/${BBLOG_ANALYZE}

LOGDIR=${PWD}/logs
OUTDIR=${PWD}/out

# Check whether the BBLOG_ANALYZE script is already available
BBLOG_ANALYZE_PATH=$(which ${BBLOG_ANALYZE} 2>/dev/null) || {
  echo "WARNING: Cannot find ${BBLOG_ANALYZE}"
  echo "INFO: Fetching script from ${BBLOG_ANALYZE_URL}"
  curl -O ${BBLOG_ANALYZE_URL}
  chmod 755 ${BBLOG_ANALYZE}
  BBLOG_ANALYZE_PATH=${PWD}/${BBLOG_ANALYZE}
}
echo "INFO: ${BBLOG_ANALYZE} installed at ${BBLOG_ANALYZE_PATH}"

if [ ! -d "${LOGDIR}" ]; then
  echo "ERROR: Cannot find ${LOGDIR}"
  exit 1
fi
mkdir -p ${OUTDIR}
pushd ${OUTDIR}
# Run the script against all the tests in tests/
for f in ${LOGDIR}/*.log; do
  echo "INFO: Analyzing $f"
  ${BBLOG_ANALYZE_PATH} $f
done
popd

# EOF
