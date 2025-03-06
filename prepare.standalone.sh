curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt-get update -y 
apt install -y \
    net-tools \
    neofetch \
    vim \
    curl \
    moreutils yq \
    openvswitch-switch \
    virt-manager \
    driverctl \
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

# ufw allow from <YOUR IP> 22/tcp
ufw allow 1000:65535/udp
ufw allow 443/tcp
ufw allow proto tcp from 10.30.30.0/24 to any
ufw allow proto tcp from 10.20.40.0/24 to any
ufw enable


mkdir -P /volumes
curl -X GET https://play.2.thinkmay.net/admin/app.qcow2 \
    -H 'pool:app_data' \
    -H 'Authorization:Basic abc' \
    --output /volumes/app.qcow2
curl -X GET https://play.2.thinkmay.net/admin/win11.template.qcow2  \
    -H 'pool:app_data'  \
    -H 'Authorization:Basic abc' \
    --output /volumes/150.template.qcow2
