# Một số trường hợp sử dụng của ip route command hữu ích

```sh
# ip address show - show all IP addresses (also ip ad sh) 
# ip address show ens36 - show IP addresses of a particular interface 
# ip address show up - only show IPs of those interfaces that are up
# ip address show dynamic|permanent - show dynamic or static IPv6 addys
# ip address add 192.0.2.1/27 dev ens36 - add a new IP address to the interface
First addy you added will be used as SRC addy for outgoing traffic by def, often called primary addy . Receiving will do for all added IPs
# ip address add 192.0.2.1/29 dev ens36 lablel ens36:hahaha - add IP and label it
# ip address delete 192.0.2.1/29 dev ens36 delete Ip address from interface
# ip address flush dev ens36 - delete all IPs from an interface
ROUTE If you set up a static route and interface through which it is available goes down - the route is removed from active routing table as well. Also you cannot add route via inaccessible gateways.
# ip route [show] / ip ro Show the routing table, includes IPv4 and IPv6
# ip -6 route - show only IPv6 , which are not shown by def
# ip -4 route
# ip route show root 192.0.2.0/24 - can use supernet to include multiple more specific routes to show, i.e. show this net and SMALLER subnets
# ip route show match 192.0.2.0/29 // show routes to this and LARGER nets
# ip route show exact 192.168.13.0/24 // show routes to EXACT network only
# ip route get 192.176.12.1/24 // simulate resolving of a route in real time
# ip route add 192.192.13.1/24 via 10.13.77.1 Add new route to 192.192.13.1/24 via nexthop
# ip route add 192.192.13.1/24 dev ens36 Add new route to 192.192.13.1/24 via interface
# ip route delete 192.192.13.1/24 via 10.13.77.1 Delete specific route
# ip route delete 192.192.13.1/24 Delete specific route
# ip route change 192.192.13.1/24 dev ens32 change some params of existing route
# ip route replace 192.192.13.1/24 dev ens36 replace if exists add if not 
# ip route add default via 10.10.10.1 Add default route via next hop
# ip route add default dev ens36 Add default route via interface
# ip route add 0.0.0.0/0 dev ens36 Add default route via the interface 
# ip route delete default dev ens36 Delete Default route
# ip -6 route add default via 2001:db8 Add IPv6 default route
# ip route add blackhole 192.1.1.0/24 Black hole some route
# ip route add unreachable 10.10.10.0/24 Block destination route, sends “Host unreachable”
# ip route add prohibit 10.1.1.1/32 Block destination route, sends ICMp “Administratively prohibited”
# ip route add throw 10.1.1.1/32 Block destination route, sends “net unreachable”
# ip route add 10.10.10.0/24 via 10.1.1.1 metric 5 Add route with custom metrics
# ip route add default nexthop via 10.10.10.1 weight 1 nexthop dev ens33 weight 10 Add default route with custom weight, higher weight is preferred
Link Management
# ip link show | ip link | ip link list Show all available interfaces/links
# ip link show ens33 Show information about specific interface, more verbose than above
# ip link set dev eth0 down | up Set interface down or up
# ip link set dev name Rename the interface, 1st bring interface down
# ip link set dev eth0 address 22:11:33:cc:33:11 Change MAC address
# ip link set dev tun0 mtu 1480 Set MTU size of interface
# ip link delete dev Delete interface, relevant to VLAn and bridges only
# ip link set dev ens36 arp off|on disable/enable ARP on interface
# ip link set dev ens36 multicast on|off disable/enable multicast on interface
# ip link add name eth0.110 link eth0 type vlan id 110 Add new VLAN 110 on eth0
# ip link add name eth0.100 link eth0 type vlan proto 802.1ad id 100
ip link add name eth0.100.200 link eth0.100 type vlan proto 802.1q id 200
// QinQ encapsulation (available since kernel 3.10)
# ip link add name peth0 link eth0 type macvlan
# ip link add name dummy10 type dummy Create new interface
# ip link add name br0 type bridge Create bridge interface
ip link set dev eth0 master br0 Add eth0 to the bridge
ip link set dev eth0 nomaster
# ip link add ifb10 type ifb // Intermediate functional block interface
Grouping.
Links not assigned to any group belong to group 0 Group names are stored in /etc/iproute2/group file, up to 255 groups are possible
# ip link set dev eth0 group 33
# ip link set dev eth0 group 0
# ip link set group 33 down
# ip link set group 33 mtu 1300
# ip link list group 33
# ip neighbor show
# ip -6 neighbor show
# ip neighbor show dev eth0
# ip neighbor flush dev eth0
# ip neighbor add 192.1.1.1 lladdr 22:33:44:55:ff:11 dev eth0
# ip neighbor delete 192.1.1.1 lladdr 22:33:44:55:ff:11 dev eth0
Tunnel ints: IPIP, SIT (IPV6 in IPV4), IP 6IP6 (IPv6 in IPv6), IPIP6 (IPv4 in IPv6), GRE, VTI kernel 3.6 or later (IPv4 in IPSec) Tunnels are created in DOWN state, dont forget to bring up
# ip tunnel add tun0 mode ipip local 192.0.2.1 remote 198.13.22.12
# ip link set dev tun0 up
# ip address add 10.1.1.1/30 dev tun0
# ip tunnel add tun9 mode sit local 192.0.2.1 remote 198.21.33.13
# ip link set dev tun9 up
# ip addres add 2001:db8:1::1/64
Gretap tunnel - encapsulate ETH into IPv4 , used to connect L2 segments over L3. L2 interface. # ip link add gretap0 type gretap local 192.0.2.1 remote 198.21.13.14
GRE.
# ip tunnel add tun7 mode gre local 192.0.2.1 remote 197.13.12.1
# ip link set dev tun7 up
# ip address add 192.168.1.1/30 dev tun7
# ip tunnel add tun11 mode gre local 192.0.2.1 key 1234 GRE point to multipoint
# ip link set dev tun11 up
# ip add add 10.1.1.1/24 dev tun11
# ip neighbor add 10.1.1.2/24 lladdr 192.0.2.1 dev tun11
# ip tunnel delete tun11
# ip tunnel change tun0 remote 194.13.221.1
# ip tunnel show
```