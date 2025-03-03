curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt-get update -y 
apt install -y \
    net-tools \
    neofetch \
    vim \
    curl \
    openvswitch-switch \
    virt-manager \
    driverctl \
    pppoeconf \
    libevdev-dev

docker network create internal  \
    --gateway 10.20.40.1 \
    --subnet 10.20.40.0/31 \
    --opt com.docker.network.bridge.name=tmvirbr0

driverctl set-override 0000:1a:00.0 vfio-pci
driverctl set-override 0000:1a:00.1 vfio-pci
driverctl set-override 0000:1b:00.0 vfio-pci
driverctl set-override 0000:1b:00.1 vfio-pci
driverctl set-override 0000:3d:00.0 vfio-pci
driverctl set-override 0000:3d:00.1 vfio-pci
driverctl set-override 0000:3e:00.0 vfio-pci
driverctl set-override 0000:3e:00.1 vfio-pci
driverctl set-override 0000:5e:00.0 vfio-pci
driverctl set-override 0000:5e:00.1 vfio-pci
driverctl set-override 0000:88:00.0 vfio-pci
driverctl set-override 0000:88:00.1 vfio-pci
driverctl set-override 0000:89:00.0 vfio-pci
driverctl set-override 0000:89:00.1 vfio-pci
driverctl set-override 0000:b1:00.0 vfio-pci
driverctl set-override 0000:b1:00.1 vfio-pci
driverctl set-override 0000:b2:00.0 vfio-pci
driverctl set-override 0000:b2:00.1 vfio-pci
driverctl set-override 0000:da:00.0 vfio-pci
driverctl set-override 0000:da:00.1 vfio-pci
ufw disable



rclone mount --config rclone.conf thinkmay:qcow2 ./qcow2
