## Command history

Bash sẽ lưu trữ tất cả các lệnh đã gõ trong bộ đệm history, bạn có thể gọi lại các lệnh trước đó bằng cách sử dụng phím `up` và `down`. Để xem tất cả các lệnh đó, bạn có thể sử dụng command `history`. Danh sách các lệnh được hiển thị với lệnh gần đây nhất sẽ xuất hiện từ cuối lên. Thông tin này được lưu trữ trong file `~/.bash_history`. Một số biến môi trường có thể sử dụng để lấy thông tin này:

|Variable	|Usage|
|---|--|
|HISTFILE	|stores the location of the history file|
|HISTFILESIZE	|stores the maximum number of lines in the history file|
|HISTSIZE	|stores the maximum number of lines in the history file for the current session|

Một số cú pháp được sử dụng để sử dụng các lệnh trước đó:

|Syntax	|Usage|
|--|--|
|!!	|Execute the previous command|
|!	|Start a history substitution|
|!$	|Refer to the last argument in a line|
|!n	|Refer to the n-th command line|
|!string	|Refer to the most recent command starting with string|

Để hiển thị cả ngày tháng gõ lệnh đó thì sử dụng

	HISTTIMEFORMAT="%d/%m/%y %T "

Hoặc làm thay đổi cho user hiện tại

	echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bashrc
	source ~/.bashrc

Xóa history file 

	history -c

Xóa dòng theo số dòng

	history -d 121

Hiển thị 5 dòng thôi

	 history 5

Để lưu cả các lệnh lặp nhau liên tiếp sử dụng:

	export HISTCONTROL=dups

Nếu muốn bỏ các lệnh lặp đó thì đổi lại là:

	export HISTCONTROL=ignoredups

Với quyền root, có thể xem lịch sử của các user khác

	grep -e "$pattern" /home/*/.bash_history


## Quit Bash Shell Without Saving Bash History

### Cach 1: Xóa history của session hiện tại mà không ảnh hưởng tới history cũ trước đó

* Unset HISTFILE

```sh
unset HISTFILE && exit
```

* Kill Console

```sh
kill -9 $$
```

### Cách 2: Xóa toàn bộ Bash History mà không lưu lại dấu vết

* Clear History Option

```sh 
history -c && exit
```

* Set HISTSIZE = 0 

```sh
HISTSIZE=0 && exit 
```

* Delete HISTFILE và Unset HISTFILE

```sh
rm -f $HISTFILE && unset HISTFILE && exit
```






