# Oracle SQL Monitoring Script (Oracle 19c)

Basic SQL monitoring script to identify high CPU SQL and long-running sessions.

## Features
- Top SQL by CPU usage
- Long running active sessions
- Lightweight and production-safe

## Prerequisites
- Oracle Database 19c
- SQL*Plus
- Linux/Unix OS
- SYSDBA access

## Setup
```bash
chmod +x oracle_sql_monitor.sh
export ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1
export ORACLE_SID=ORCL
./oracle_sql_monitor.sh
/var/log/oracle_monitor/
