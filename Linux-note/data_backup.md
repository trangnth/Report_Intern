## Data Backup

### Backup the data 

Lệnh `rsync` được sử dụng để đồng bộ hóa toàn bộ cây thư mục.

Chi tiết hơn về [Rsync](https://github.com/trangnth/Report_Intern/blob/master/Rsync/Rsync.md)

### Compress the data

File dữ liệu thường được nén để tiết kiệm không gian ổ đĩa và giảm thời gian cần thiết khi truyền qua mạng.

Một số các command để nén: gzip, bzip2, xz, zip

### Archiving data

Lệnh `tar` cho phép bạn khởi tạo hoặc giải nén file, thường được gọi là tarball. 

### Copying disks

Lệnh `dd` rất hữu ích cho việc tạo bản copies của raw disk space. Ví dụ, để back up Master Boot Record (MBR) (512 byte sector đầu tiên trên ổ đĩa bao gồm bảng miêu tả partitions trên disk)

	dd if=/dev/sda of=sda.mbr bs=512 count=1

