## Một số các ghi chú về git trong quá trình tìm hiểu và sử dụng

* Xóa commit gần nhất đã được commit từ máy local:

```sh
git reset --soft HEAD~1
```

* Xem nội dung commit gần nhất:

```sh
git commit --amend
```

### Cấu hình Git cho Linux

* Cấu hình các thông số cơ bản

```sh
git config --global user.name "trangnth"
git config --global user.email "nguyxxx@gmail.com"
git config --global core.editor vim

git config --list
```

* Tạo ssh key cho tài khoản Github 

```sh
ssh-keygen -t rsa -b 4096 -C "nguyenhuyentrang1996@gmail.com"
```

* Copy nội dung public key và paste lên github

```sh
[root@trang-40-75 ~]# cat /root/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDo5EUdkDUwC5EGSUIFXcyic+PEP4TT3+K5yM2iZL89uKxDig9VoNUqBPAtLtzI/GuQHLdtOtXhqPN/v9NpcQv2pIIifiiJSea3IFHsb9jyHhhLd9eZjjdNT2/xxx@gmail.com
```

* Trên server thực hiện 

```sh
ssh -T git@github.com
cd Upstream-OPS/
git remote set-url origin git@github.com:trangnth/Upstream-OPS.git
git push origin master
```



## Tham khảo

[1] https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account