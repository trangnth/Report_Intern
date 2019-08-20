# Một số ghi chép về command logger

## Shell scripting: Write message to a syslog/log file

**syslog** là một giao thức cũng như một ứng dụng để send message tới hệ thống logfile của Linux thường được đặt tại `/var/log`

**Sysklogd** cung cấp hai hệ thống tiện ích hỗ trợ cho system logging và kernel message trapping.

Các chương trình và ứng dụng thường được sử dụng nhất đều sử dụng C hoặc syslog application / library để sử syslog message. Nhưng liệu có cách nào để gửi các message từ một shell prompt hoặc shell script được không? Câu trả lời là có thể sử dụng command `logger`


### Logger command

Sử dụng lệnh logger như một shell command interface cho syslog system log module. Nó làm hoặc viết một dòng trong system log file từ một command line.

* Log message System rebooted for hard disk upgrade

```sh
$ logger System rebooted for hard disk upgrade
```

* Lúc này một dòng log sẽ được tạo ra trong file `/var/log/message`

```sh
[root@trang-20-51 ~]# tailf -n 1 /var/log/messages
Aug 14 22:35:58 trang-20-51 root: System rebooted for hard disk upgrade
```

* Để log các message nằm trong một file `/var/log/myapp.log` (mỗi một dòng trong file `/var/log/myapp.log` sẽ tạo ra một dòng log trong `/var/log/message`)

```sh
$ logger -f /var/log/myapp.log
```

* Log the message sẽ được gửi đồng thời tới standard error (screen) và system log:

```sh
$ logger -s "Hard disk full"
```

### Using logger in scripts

```sh
$ grep logger /bin/runme
logger "$0 completed at `date`"
$ sudo runme
$ tail -1 /var/log/syslog
May 21 17:57:36 butterfly shs: ./runme completed at Mon May 21 17:57:36 EDT 2018
```

### Limiting the size of logger entries

* Nếu bạn quan tâm tới kích thước của một dòng log sẽ được thêm vào log file và muốn giới hạn nó (đặc biệt khi bạn thực hiện dumping content từ một file) bạn có thể sử dụng option `-size`.  Ví dụ:


```sh
$ logger --size 10 12345678901234567890123456789012345678901234567890
$ tail -1 /var/log/syslog
May 21 18:18:02 butterfly shs: 1234567890
```

* Lưu ý, tùy chọn này hơi khác với những gì bạn mong đợi ở chỗ, với các input bao gồm cả khoảng trống (blanks), nó sẽ bị ràng buộc bởi nội dung trên mỗi dòng thay vì trên toàn bộ chiều dài tổng thể. (nghĩa là nó sẽ tính cả khoảng trắng như một ký tự để tính kích thước giới hạn)

```sh
$ logger --size 5 `date`
$ tail -5 /var/log/syslog
May 22 08:35:51 butterfly shs: May
May 22 08:35:51 butterfly shs: 22
May 22 08:35:51 butterfly shs: 08:35
May 22 08:35:51 butterfly shs: EDT
May 22 08:35:51 butterfly shs: 2018

# Hoặc
[root@trang-20-51 ~]# logger --size 4 -f log

[root@trang-20-51 ~]# cat log
sddsdf qweqweqwe dd
fgssd qq asdsad

[root@trang-20-51 ~]# tail -n 15 /var/log/messages
Aug 14 22:40:44 trang-20-51 root: Hard disk full
Aug 14 22:56:38 trang-20-51 root: Hard disk full
Aug 14 22:57:04 trang-20-51 root: sdd
Aug 14 22:57:04 trang-20-51 root: sdf
Aug 14 22:57:04 trang-20-51 root: qw
Aug 14 22:57:04 trang-20-51 root: eqw
Aug 14 22:57:04 trang-20-51 root: eqw
Aug 14 22:57:04 trang-20-51 root: e d
Aug 14 22:57:04 trang-20-51 root: d
Aug 14 22:57:04 trang-20-51 root: fgs
Aug 14 22:57:04 trang-20-51 root: sd
Aug 14 22:57:04 trang-20-51 root: qq
Aug 14 22:57:04 trang-20-51 root: asd
Aug 14 22:57:04 trang-20-51 root: sad
Aug 14 22:57:04 trang-20-51 root: sad
```


### Ignoring blank lines

```sh
$ cat appts
Appts
                                              <=== file includes blank line
8 AM -- get to office
8:30 AM -- meet with boss
11:00 AM -- staff meeting
$ logger -e -f appts
May 22 08:17:31 butterfly shs: Appts          <=== log does not
May 22 08:17:31 butterfly shs: 8 AM -- get to office
May 22 08:17:31 butterfly shs: 8:30 AM -- meet with boss
May 22 08:17:31 butterfly shs: 11:00 AM -- staff meeting
May 22 08:17:33 butterfly kernel: [58833.758599] [UFW BLOCK] IN=enp0s25 OUT= MAC=01:00:5e:00:00:fb:ac:63:be:ca:10:cf:08:00 SRC=192.168.0.9 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF PROTO=2
```

### Một số tùy chọn khác

* *-p*, *--priority* priority

Đẩy message vào log với priority cụ thế, ví dụ `-p local3.info`, mặc định sẽ là `user.notice`

* Tùy chọn `-t` (tag) và `-i` (pid)

```sh
[root@trang-20-51 ~]#  logger --size 5 `date` -t logger -i
[root@trang-20-51 ~]# tail -n 15 /var/log/messages
Aug 14 23:01:11 trang-20-51 root: 23:01:11
Aug 14 23:01:11 trang-20-51 root: EDT
Aug 14 23:01:11 trang-20-51 root: 2019
Aug 14 23:23:28 trang-20-51 logger: Wed
Aug 14 23:23:28 trang-20-51 logger: Aug
Aug 14 23:23:28 trang-20-51 logger: 14
Aug 14 23:23:28 trang-20-51 logger: 23:23:28
Aug 14 23:23:28 trang-20-51 logger: EDT
Aug 14 23:23:28 trang-20-51 logger: 2019
Aug 14 23:24:00 trang-20-51 logger[27562]: Wed
Aug 14 23:24:00 trang-20-51 logger[27562]: Aug
Aug 14 23:24:00 trang-20-51 logger[27562]: 14
Aug 14 23:24:00 trang-20-51 logger[27562]: 23:24:00
Aug 14 23:24:00 trang-20-51 logger[27562]: EDT
Aug 14 23:24:00 trang-20-51 logger[27562]: 2019
```





## Tham khảo

[1] https://www.cyberciti.biz/tips/howto-linux-unix-write-to-syslog.html

[2] https://www.systutorials.com/docs/linux/man/1-logger/

[3] [101 system logging] https://developer.ibm.com/tutorials/l-lpic1-108-2/
