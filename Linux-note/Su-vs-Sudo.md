## Một chút về Su và Sudo

* `su` là một commad được sử dụng để chuyển đổi user (**s**witch **u**ser), sử dụng `su` command không có tham số thì sẽ được chuyển tới user root. `su` sẽ hỏi password của user muốn switch tới, sau khi nhập password bạn sẽ được chuyển tới môi trường của user đó

* `sudo` dùng để chạy một command với quyền của root. Nhưng không giống như `su`, `sudo` sẽ hỏi password của user hiện tại. Và muốn thực hiện được thì user này cần nằm trong sudoers file (hoặc thuộc về một group nằm trong sudoers file). Mặc định, với Ubuntu thì sau 15p sẽ không bị hỏi lại mật khẩu khi sử dụng command `sudo`

* `bash` là một giao diện dòng lệnh để tước tác với máy tính

Types of shells:

* `login shell`: A login shell logs you into the system as a specified user, necessary for this is a username and password. When you hit ctrl+alt+F1 to login into a virtual terminal you get after successful login a login shell.
* `non-login shell`: A shell that is executed without logging in, necessary for this is a currently logged-in user. When you open a graphic terminal in gnome it is a non-login shell.
* `interactive shell`: A shell (login or non-login) where you can interactively type or interrupt commands. For example a gnome terminal.
* `non-interactive shell`: A (sub)shell that is probably run from an automated process. You will see neither input nor output.


Có một số các case như sau:

* `sudo su`: thực hiện xin quyền root với `sudo` cho command `su`. Bash sẽ thuộc loại interactive non-login shell. Khi đó bash sẽ chỉ thực thi file `.bashrc`. Sau khi thực hiện lệnh bạn có thể thấy bạn vẫn nằm ở thư mục hiện tại.

```sh
[trangnth@trang8 ~]$ sudo su
[sudo] password for trangnth:
[root@trang8 trangnth]#
```

* `sudo su -`: lần này là login shell, vì vậy các file như `/etc/profile`, `.profile`, `.bashrc` sẽ được thực thi, và nó chuyển tới thư mục home của root với môi trường của root sau khi thực hiện lệnh thành công.

* `sudo -i`: cái này cũng gần tương tự như `sudo su -`. Tùy chọn `-i` (simulate initial login) chạy một shell đặc biệt bằng password database entry của target user như một login shell. Điều này nghĩa là các file như `.profile`, `.bashrc` or `.login` sẽ được đọc và thực thi bởi shell




## Tham khảo

[1] https://askubuntu.com/questions/376199/sudo-su-vs-sudo-i-vs-sudo-bin-bash-when-does-it-matter-which-is-used

[2] https://www.maketecheasier.com/differences-between-su-sudo-su-sudo-s-sudo-i/
