## Hướng dẫn cài đặt và cấu hình openvpn 

**Chuẩn bị ban đầu**

* Môi trường lab: KVM 
* Một số các công cụ sử dụng liên quan: virt-manager, MobaXterm
* OS: CentOS 7

Cấu hình server:

* Gồm 3 card mạng: 
	* Một để bridge, ip 192.168.100.242/24 (dải public, để các máy client kết nối tới)
	* Một Vlan 40, ip 192.168.40.125/24 (dải local)
	* Một Vlan 70, ip 192.168.70.125/24 (dải local để cấp ip cho client khi connet tới trong mode tap)

### Cài đặt và cấu hình


```sh
yum install openvpn easy-rsa -y
# Chú ý phiên bản trong link bên dưới
cp  /usr/share/doc/openvpn-2.4.7/sample/sample-config-files/server.conf /etc/openvpn/server.conf
cat <<EOF > /etc/openvpn/server.conf
port 1194
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key  # This file should be kept secret
dh dh2048.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 208.67.222.222"
push "dhcp-option DNS 208.67.220.220"
keepalive 10 120
tls-auth myvpn.tlsauth # This file is secret
topology subnet
# remote-cert-eku "TLS Web Client Authentication"
cipher AES-256-CBC
user nobody
group nobody
persist-key
persist-tun
status openvpn-status.log
log         openvpn.log
log-append  openvpn.log
verb 3
explicit-exit-notify 1
EOF
echo 1 > /proc/sys/net/ipv4/ip_forward
```

Sửa file `/etc/sysctl.conf`: bỏ comment dòng dưới đây:

	net.ipv4.ip_forward=1

Cấu hình

```sh
mkdir -p /etc/openvpn/easy-rsa/keys
wget -O /tmp/easyrsa https://github.com/OpenVPN/easy-rsa-old/archive/2.3.3.tar.gz
tar xfz /tmp/easyrsa
sudo cp -rf easy-rsa-old-2.3.3/easy-rsa/2.0/* /etc/openvpn/easy-rsa
```

Chỉnh sửa file `vim /etc/openvpn/easy-rsa/vars`

```sh
export KEY_COUNTRY="VN"
export KEY_PROVINCE="HN"
export KEY_CITY="Hanoi"
export KEY_ORG="MediTech"
export KEY_EMAIL="trang.nguyenthihuyen@meditech.vn"
export KEY_OU="MediTech"
export KEY_NAME="server"
```

Lưu lại vào thoát file

```sh
openvpn --genkey --secret /etc/openvpn/myvpn.tlsauth
cd /etc/openvpn/easy-rsa
source ./vars
./clean-all
./build-ca
./build-key-server server
./build-dh
cp /etc/openvpn/easy-rsa/keys/{server.crt,server.key,ca.crt} /etc/openvpn
cd /etc/openvpn/easy-rsa/keys
sudo cp dh2048.pem ca.crt server.crt server.key /etc/openvpn
cd /etc/openvpn/easy-rsa
./build-key client
cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf
```
Add rules on firewall

```sh
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --get-active-zones
public
  interfaces: eth0 eth1 eth2
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --zone=trusted --add-service openvpn
success
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --zone=trusted --add-service openvpn --permanent
success
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --list-services --zone=trusted
openvpn
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --add-masquerade
success
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --permanent --add-masquerade
success
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --query-masquerade
yes
[root@trang-20-51 easy-rsa]# SHARK=$(ip route get 8.8.8.8 | awk 'NR==1 {print $(NF-2)}')
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --permanent --direct --passthrough ipv4 -t nat -A POSTROUTING -s 10.8.0.0/24 -o $SHARK -j MASQUERADE
success
[root@trang-20-51 easy-rsa]# sudo firewall-cmd --reload
success
```

Rút gọn phần bên trên để copy command dễ hơn:

```sh
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=trusted --add-service openvpn
sudo firewall-cmd --zone=trusted --add-service openvpn --permanent
sudo firewall-cmd --list-services --zone=trusted
sudo firewall-cmd --add-masquerade
sudo firewall-cmd --permanent --add-masquerade
sudo firewall-cmd --query-masquerade
SHARK=$(ip route get 8.8.8.8 | awk 'NR==1 {print $(NF-2)}')
sudo firewall-cmd --permanent --direct --passthrough ipv4 -t nat -A POSTROUTING -s 10.8.0.0/24 -o $SHARK -j MASQUERADE
sudo firewall-cmd --reload
```

Hoặc cấu hình firewall bằng iptables:

```sh
apt-get install iptables-persistent –y
iptables -t nat -A POSTROUTING -s 10.8.0.0/8 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/8 -o eth1 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/8 -o eth2 -j MASQUERADE
iptables-save > /etc/iptables/rules.v4
```

Khởi động lại services:

```sh
sudo systemctl restart network.service
sudo systemctl -f enable openvpn@server.service
sudo systemctl start openvpn@server.service
sudo systemctl status openvpn@server.service
```

Cấu hình client copy các file sau:

```sh
/etc/openvpn/easy-rsa/keys/ca.crt
/etc/openvpn/easy-rsa/keys/client.crt
/etc/openvpn/easy-rsa/keys/client.key
/etc/openvpn/myvpn.tlsauth
# scp client1.crt root@192.168.100.248:/root/client
```

Chỉnh sửa file `client.ovpn`

```sh
client # tên client
tls-client
ca /path/to/ca.crt  # Chú ý sửa lại các đường dẫn tới các key cho phù hợp
cert /path/to/client.crt
key /path/to/client.key
tls-crypt /path/to/myvpn.tlsauth
remote-cert-eku "TLS Web Client Authentication"
proto udp
remote 192.168.100.242 1194 udp # Thay đổi ip public openvpn server của bạn
dev tun
topology subnet
pull
user nobody
group nobody
```

Ví dụ một file cấu hình của tôi:

```sh
client
dev tun
proto udp
remote 192.168.100.242 1194
resolv-retry infinite
nobind
user nobody
group nobody
persist-key
persist-tun
ca ca.crt
cert client.crt
key client.key
remote-cert-tls server
tls-auth myvpn.tlsauth 1
cipher AES-256-CBC
verb 3
```

* Với client là windows, file cấu hình thường được đặt tại `C:\Program Files\OpenVPN\config`

* Linux: chạy openvpn với command: `sudo openvpn --config ~/path/to/client.ovpn`

