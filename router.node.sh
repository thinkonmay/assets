set -x
export apiIF=$(yq '.interface.api' cluster.yaml  | tr -d '"' )
export publicIF=$(yq '.interface.public' cluster.yaml  | tr -d '"' )
export PRIVIP="$(ifdata -pa $apiIF)"

ip addr flush dev $apiIF
ip route add default via 10.30.30.2
ip addr flush dev $publicIF
