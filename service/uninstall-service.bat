@echo off

set SERVICE_NAME=thinkmay

net stop %SERVICE_NAME%

sc delete %SERVICE_NAME%
