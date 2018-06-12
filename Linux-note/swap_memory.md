## Linux swap memory

Linux chia RAM thành các vùng nhớ được gọi là pages. Swapping là quá trình trao đổi một page của memmory được sao chép vào một không gian đã được cấu hình sẵn trên hard disk, được gọi là swap space, để tự giải phóng chính nó khỏi memory, tiết iệm bộ nhớ cho RAM. Dung lượng RAM và các swap space là dung lượng bộ nhớ ảo có sẵn. Swap là cần thiết vì hai lý do sau: 

* Khi hệ thống cần nhiều RAM hơn so với các memory có sẵn thì kernel sẽ di chuyển các page ít được sử dụng và swap space, lấy đi bộ nhớ đã được giải phóng để cấp thêm cho tiến trình đang chạy.

* Một số lượng đáng kể các page được các application sử dụng trong quá trình khởi động sau đó sẽ không bao giờ sử dụng nữa

So với RAM thì SWAP space trên hard disk có tốc độ chậm hơn nhiều (khoảng 10000 lần) nên càng swapping nhiều thì càng làm các tiến trình bị chậm.

Có hai phương pháp swap space:
* Swap partition: là một phân vùng độc lập dành cho việc swap và không dữ liệu nào được lưu ở đó.
* Swap file: là một file đặc biệt được lưu trong filesystem ở một vị trí tạm thời trên disk, nó sẽ lưu thông tin và các file mà RAM không sử dụng để giải phóng RAM

Để thêm một swap file:

	sudo dd if=/dev/sda2 of=/var/swapfile bs=1M count=4194304

Kiểm tra số phân vùng swap trên hệ thống, dùng lệnh `swapon -s`:
```sh
$ swapon -s
Filename				Type		Size	Used	Priority
/dev/sda5                              	partition	1046524	0	-1
```