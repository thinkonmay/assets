mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/nvme0n1 /dev/nvme1n1
mkfs.xfs /dev/md0
mkdir -p /disk/raid0
chmod 777 -R /disk/raid0
mount /dev/md0 /disk/raid0