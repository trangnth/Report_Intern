## Hướng dẫn cài đặt FTP server (vsftpd) trên ubuntu 16

### Bước 1: Cài đặt vsftpd

```sh
sudo apt-get install vsftpd -y 
cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
```

* Tạo user

```sh
adduser meditech 
mkdir /home/meditech/ftp
sudo chown nobody:nogroup /home/meditech/ftp
sudo chmod a-w /home/meditech/ftp
sudo mkdir /home/meditech/ftp/files
sudo chown meditech:meditech /home/meditech/ftp/files
sudo echo "vsftpd test file" | sudo tee /home/meditech/ftp/files/test.txt
```

### Bước 2: Cấu hình
* Cấu hình FTP Access 

```sh
cat <<EOF > /etc/vsftpd.conf
user_sub_token=meditech
local_root=/home/meditech/ftp
pasv_min_port=40000
pasv_max_port=50000
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chown_uploads=YES
chown_username=meditech
ftpd_banner=Welcome to MediTech's FTP service.
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
EOF
```

* Tạo và thêm một user vào file

```sh
echo "meditech" | sudo tee -a /etc/vsftpd.userlist
```

* Khởi động lại service 

```sh
sudo systemctl restart vsftpd
```


### Bước 3: Test

* Mở kết nối và thực hiện điền đúng user đã cấu hình, sau đó nhập password

```sh
ftp -p 203.0.113.0
```

* Nếu mở được kết nối là ok, sau đó gõ `bye` để đóng kết nối.

* Một số các câu lệnh để push và get file

```sh
cd files
get test.txt

put test.txt upload.txt

bye
```

### Bước 4 đuổi port FTP server 

```sh
echo ""
listen_port=210
systemctl restart vsftpd
```

Trên client thực hiện ftp vào server như sau:


```sh
ftp 192.168.1.150 210
```

Ví dụ các thao tác thực hiện:

```sh
[root@controller1 ~(openstack)]$ ftp 192.168.1.150 210
Connected to 192.168.1.150 (192.168.1.150).
220 Welcome to MediTech's FTP service.
Name (192.168.1.150:root): meditech
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.

ftp> ls
227 Entering Passive Mode ().
150 Here comes the directory listing.
drwxr-xr-x    2 1000     1000         4096 Oct 11 10:36 files
226 Directory send OK.

ftp> cd files
250 Directory successfully changed.

ftp> ls
227 Entering Passive Mode ().
150 Here comes the directory listing.
-rw-r--r--    1 1000     1000           17 Oct 11 10:09 test.txt
-rw-------    1 1000     1000         7169 Oct 11 10:36 test2.txt
226 Directory send OK.

ftp>
