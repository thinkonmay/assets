@echo off

set SERVICE_NAME=think-remote

net stop %SERVICE_NAME%

sc delete %SERVICE_NAME%
