set -x
export turnIF=$(yq '.interface.turn' cluster.yaml | tr -d '"' )
export apiIF=$(yq '.interface.api' cluster.yaml  | tr -d '"' )
export publicIF=$(yq '.interface.public' cluster.yaml  | tr -d '"' )
export PRIVIP="$(ifdata -pa $apiIF)"


echo "
default-lease-time 14400;
max-lease-time 28800;

subnet 10.30.30.0 netmask 255.255.255.0 {
 range 10.30.30.0 10.30.30.255;
 option routers 10.30.30.0;
 option domain-name-servers 8.8.8.8;


# host your_machine_name {
#   hardware ethernet the:MAC:Address;
#   fixed-address 10.30.30.10;
# }

" >  /etc/dhcp/dhcpd.conf

echo "
INTERFACESv4=""$apiIF""
" >  /etc/default/isc-dhcp-server

echo 1 > /proc/sys/net/ipv4/ip_forward

ip addr add 10.30.30.0 dev $apiIF
systemctl restart isc-dhcp-server.service

# setup NAT
# https://www.revsys.com/writings/quicktips/nat.html
iptables -t nat -A POSTROUTING -o $turnIF -j MASQUERADE
iptables -A FORWARD -i $turnIF -o $apiIF -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $apiIF -o $turnIF -j ACCEPT
ip addr flush dev $publicIF