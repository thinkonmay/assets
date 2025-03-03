set -x
export apiIF=$(yq '.interface.api' cluster.yaml  | tr -d '"' )
export PRIVIP="$(ifdata -pa $apiIF)"

ip addr flush dev $apiIF
ip route add default via 10.30.30.2
