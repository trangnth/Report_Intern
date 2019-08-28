# The Fuck 

**The fuck** là một ứng dụng tuyệt vời, giúp thực hiện sửa lỗi các command trước đó bị sai.

**Link:** https://github.com/nvbn/thefuck?ref=HackerTabExtensionhttps://github.com/nvbn/thefuck?ref=HackerTabExtension


### Requirements

* python (3.4+)
* pip
* python-dev


### Installation

**Môi trường**: CentOS7

Cài đặt:

```sh
yum install -y python36-dev python36-pip python36-setuptools
pip3 install thefuck
```

Nếu gặp lỗi có thì chạy thêm như sau:

```sh
yum install libevent-devel python36-devel gcc -y
easy_install-3.6 gevent
pip3 install thefuck
```

Tạo một alias cho command:

```sh
cat <<EOF >> ~/.bashrc
eval $(thefuck --alias fuck)
EOF
source ~/.bashrc
```

Để chạy command mà không cần xác nhận lại thì sử dụng `--yeah` hoặc `-y`:

```sh
fuck --yeah
```

Để thực hiện sửa command một cách đệ quy cho tới khi thành công bằng việc sử dụng option `-r`, liên tục tự sửa command cho tới khi thành công

```sh
fuck -r
```

Update

```sh
pip3 install thefuck --upgrade
```

Ví dụ nhập sai một command và gõ `fuck` để sửa, sẽ cần gõ `enter` để xác nhận command, gõ phím mũi tên lên xuống để chọn các command bị lỗi trước đó khác. Nếu thêm option `--yeah` vào thì mặc định sẽ sửa luôn command sai gần nhất mà không cần xác nhận.

```sh
[root@trang-20-51 ~]# puthon --version
-bash: puthon: command not found
[root@trang-20-51 ~]# fuck
python --version [enter/↑/↓/ctrl+c]
Python 2.7.5

[root@trang-20-51 ~]# puthon
-bash: puthon: command not found
[root@trang-20-51 ~]# fuck --yeah
python
Python 2.7.5 (default, Jun 20 2019, 20:27:34)
[GCC 4.8.5 20150623 (Red Hat 4.8.5-36)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

