set -x
export apiIF=$(yq '.interface.api' cluster.yaml  | tr -d '"' )
export publicIF=$(yq '.interface.public' cluster.yaml  | tr -d '"' )
export PRIVIP="$(ifdata -pa $apiIF)"


ip addr flush dev $apiIF
ip addr add 10.30.30.1/24 dev $apiIF
ip link set dev $apiIF mtu 9000

ip route add default 10.30.30.0 via 10.30.30.1
ip addr flush dev $publicIF