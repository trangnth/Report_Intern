### Modify the Command Line Prompt

Biến `PS1` là chuỗi ký tự được hiển thị như lời nhắc của command line. hầu hết các bản distro đều set PS1 là các giá trị mặc định đã biết, ví dụ ubuntu là user và hostname:

	root@ip-172-31-22-1:~#

Ta có thể thay đổi nó:

```sh 
root@ip-172-31-22-1:~# echo $PS1
\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$
root@ip-172-31-22-1:~# export PS1='[\u@\h \W(customt)]# '
[root@ip-172-31-22-1 ~(customt)]# echo $PS1
[\u@\h \W(customt)]#
[root@ip-172-31-22-1 ~(customt)]# export PS1='[\u@\h \W]# '
[root@ip-172-31-22-1 ~]# 
```