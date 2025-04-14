set -x
export apiMAC=$(yq '.interface.api.mac' cluster.yaml | tr -d '"' )
export apiIF=$(ip link show | grep $apiMAC -B 1 | head -n1 | cut -d: -f2 | awk '{print $1}')

export publicMAC=$(yq '.interface.public.mac' cluster.yaml | tr -d '"')
export publicIF=$(ip link show |  grep  $publicMAC -B 1 | head -n1 | cut -d: -f2 | awk '{print $1}')

export PRIVIP="$(ifdata -pa $apiIF)"

ifconfig $apiIF up
ifconfig $publicIF up


ip addr flush dev $apiIF
ip addr add 10.30.30.2/24 dev $apiIF
ip link set dev $apiIF mtu 9000

route add default gw 10.30.30.0 $apiIF
