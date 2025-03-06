set -x
export turnIF=$(yq '.interface.turn' cluster.yaml | tr -d '"' )
export apiIF=$(yq '.interface.api' cluster.yaml  | tr -d '"' )
export publicIF=$(yq '.interface.public' cluster.yaml  | tr -d '"' )
export PRIVIP="$(ifdata -pa $apiIF)"


ip addr flush dev $apiIF
ip addr add 10.30.30.0/24 dev $apiIF
ip link set dev $apiIF mtu 9000

# setup NAT
# https://www.revsys.com/writings/quicktips/nat.html
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o $turnIF -j MASQUERADE
iptables -A FORWARD -i $turnIF -o $apiIF -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $apiIF -o $turnIF -j ACCEPT
ip addr flush dev $publicIF