systemctl stop virtdaemon
systemctl stop proxy
systemctl stop pocketbase

systemctl disable virtdaemon
systemctl disable proxy
systemctl disable pocketbase

systemctl daemon-reload
systemctl reset-failed