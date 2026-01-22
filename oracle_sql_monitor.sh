#!/bin/bash
###############################################################################
# Script Name : oracle_sql_monitor.sh
# Purpose     : Basic Oracle SQL Monitoring for Oracle 19c
###############################################################################

LOG_DIR="/var/log/oracle_monitor"
DATE=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="$LOG_DIR/sql_monitor_$DATE.log"

if [[ -z "$ORACLE_HOME" || -z "$ORACLE_SID" ]]; then
  echo "ERROR: ORACLE_HOME or ORACLE_SID not set"
  exit 1
fi

mkdir -p "$LOG_DIR"

$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF >> "$LOG_FILE"
SET LINES 200 PAGES 200 FEEDBACK OFF

PROMPT === TOP SQL BY CPU ===
SELECT *
FROM (
  SELECT sql_id,
         executions,
         cpu_time/1000000 cpu_sec,
         substr(sql_text,1,80) sql_text
  FROM v\\$sql
  ORDER BY cpu_time DESC
)
WHERE ROWNUM <= 10;

PROMPT === LONG RUNNING SESSIONS ===
SELECT sid, serial#, username, status, sql_id,
       ROUND(last_call_et/60,2) minutes_running
FROM v\\$session
WHERE status='ACTIVE'
AND last_call_et > 600;

EXIT;
EOF

exit 0
