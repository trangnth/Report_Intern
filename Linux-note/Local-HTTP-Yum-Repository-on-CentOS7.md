# Setup Local HTTP Yum Repository on CentOS 7

Server: CentOS 7
Client: CentOS 7

## 1. Install Nginx Web Server 

Cài đặt vào khởi động dịch vụ:
```sh
yum install epel-release -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx
systemctl status nginx
```

Nếu firewall đang bật:

```sh
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload
```

Kiểm tra lại bằng cách truy cập vào đường dẫn `http://<ip-server>`

## 2. Create Yum Local Repository

Cài đặt gói cần thiết:
```sh
yum install createrepo  yum-utils -y
mkdir -p /var/www/html/repos/{base,centosplus,extras,updates}
```

Sử dụng `reposync` để đồng bộ Centos Yum repositories vào thư mục ở local:
```sh
reposync -g -l -d -m --repoid=base --newest-only --download-metadata --download_path=/var/www/html/repos/
reposync -g -l -d -m --repoid=centosplus --newest-only --download-metadata --download_path=/var/www/html/repos/
reposync -g -l -d -m --repoid=extras --newest-only --download-metadata --download_path=/var/www/html/repos/
reposync -g -l -d -m --repoid=updates --newest-only --download-metadata --download_path=/var/www/html/repos/
```

Kiểm tra trên các thư mục local xem đã đồng bộ đc chưa:
```sh
ls -l /var/www/html/repos/base/
ls -l /var/www/html/repos/base/Packages/
ls -l /var/www/html/repos/centosplus/
ls -l /var/www/html/repos/centosplus/Packages/
ls -l /var/www/html/repos/extras/
ls -l /var/www/html/repos/extras/Packages/
ls -l /var/www/html/repos/updates/
ls -l /var/www/html/repos/updates/Packages/
```

Tạo mới repodata cho local repositories bằng cách chạy command sau:

```sh
createrepo -g comps.xml /var/www/html/repos/base/  
createrepo -g comps.xml /var/www/html/repos/centosplus/ 
createrepo -g comps.xml /var/www/html/repos/extras/  
createrepo -g comps.xml /var/www/html/repos/updates/  
```

Có thể bỏ tùy chọn `-g`

Cấu hình Nginx
```sh
$ vim /etc/nginx/conf.d/repos.conf 

server {
        listen   8008;
        server_name  trang-40-92;   #change  trang-40-92 to your real domain 
        root   /var/www/html/repos;
        location / {
                index  index.php index.html index.htm;
                autoindex on;   #enable listing of directory index
        }
}
```

Lưu và thoát file. Sau đó khởi động lại nginx và truy cập vào trang web theo địa chỉ của server `http://192.168.40.92:8008`sẽ thấy các packages ở đó.

## 3. Tạo một repo custom

```sh
mkdir /var/www/html/repos/base/
createrepo /var/www/html/repos/base/
mkdir /var/www/html/repos/base/Packages
yumdownloader --resolve --destdir= /var/www/html/repos/base/Packages httpd
```
    
Trên client định nghĩa:

```sh 
$ cat /etc/yum.repos.d/local-repos.repo
[local-base]
name=CentOS Base
baseurl=http://192.168.40.92:8008/base/
gpgcheck=0
enabled=1
```

Kiểm tra lại:

```sh
yum repolist all
yum list
yum search httpd
yum install -y httpd
```

Mỗi lần thêm gói mới hoặc có thay đổi trên repo thì cần chạy lệnh update lại trên client và server 

* Trên controller:

```sh
createrepo --update /var/www/html/repos/base

* Trên client:

```sh       
yum update
yum install -y <package name>
```



## Tham khảo

[1] https://www.tecmint.com/setup-local-http-yum-repository-on-centos-7/
