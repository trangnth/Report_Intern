## Command dd

`dd` dùng để:

* Sao lưu và phục hồi toàn bộ dữ liệu ổ cứng hoặc một partition
* Chuyển đổi định dạng dữ liệu từ ASCII sang EBCDIC hoặc ngược lại
* Sao lưu lại MBR trong máy (MBR là một file dữ liệu rất quan trong nó chứa các lệnh để LILO hoặc GRUB nạp hệ điều hanh)
* Chuyển đổi chữ thường sang chữ hoa và ngược lại
* Tạo một file với kích cơ cô định
* Tạo một file ISO


`dd` đọc theo từng block, theo mặc định là 512 bytes.

Dạng tổng quát như sau:

```
dd if="source" of="target" bs="byte size" conv="conversion"
```

### Các tùy chọn

|Tùy chọn	|Ý nghĩa|
|-----|---|
|bs=Bytes|	Quá trình đọc (ghi) bao nhiêu byte một lần đọc (ghi)|
|cbs=Bytes|	Chuyển đổi bao nhiêu byte một lần|
|count=Blocks|	thực hiện bao nhiêu Block trong quá trình thực thi câu lệnh|
|if|	Chỉ đường dẫn đọc đầu vào|
|of	|Chỉ đường dẫn ghi đầu ra|
|ibs=bytes|	Chỉ ra số byte một lần đọc|
|obs=bytes|	Chỉ ra số byte một lần ghi|
|skip=blocks|	Bỏ qua bao nhiêu block đầu vào|
|conv=Convs|	Chỉ ra tác vụ cụ thể của câu lệnh, các tùy chọn được ghi dưới bảng sau đây|

Khi bạn định dạng số lượng byte mỗi lần đọc. Mặc định nó được tính theo đơn vị là kb. Bạn có thể thêm một số trường sau để báo định dạng khác:

```sh
c = 1 byte
w = 2 byte
b = 512 byte
kB = 1000 byte
K = 1024 byte
MB = 1000000 byte
M = (1024 * 1024) byte
GB = (1000 * 1000 * 1000) byte
G = (1024 * 1024 * 1024) byte
```

|Tùy chọn|	Tác dụng|
|---|---|
|ascii	|Chuyển đôi từ mã EBCDIC sáng ASCII|
|ebcdic	|Chuyển đổi từ mã ASCII sang EBCDIC|
|lcase	|Chuyển đổi từ chữ thường lên hết thành chữ in hoa|
|ucase	|Chuyển đổi từ chữ in hoa sang chữ thường|
|nocreat|	Không tạo ra file đầu ra|
|noerror|	Tiếp tục sao chép dữ liệu khi đầu vào bị lỗi|
|sync|	Đồng bộ dữ liệu với ổ đang sao chép sang|


### Usecase

Sử dụng dd:

* Copy đĩa cứng:

		dd if=/dev/hda of=/dev/hdc bs=4096

* Backup:
		
		dd if=/dev/hda1 of=/home/root.img bs=4096 conv=notrunc,noerror

* Restore:

		dd if=/home/root.img of=/dev/hda1 bs=4096 conv=notrunc,noerror

* Backup + nén:

		dd bs=1M if=/dev/hda1 | gzip -c > root.gz

* Restore với bản nén:
		
		gunzip -dc root.gz | dd of=/dev/hda1 bs=1M
* Backup + nén tới remote host:

		dd bs=1M if=/dev/hda1 | gzip | ssh user@host 'dd of=root.gz'

* Kiểm tra bad blocks:
		
		dd if=/dev/hda of=/dev/null bs=1M

* Xoá toàn bộ ổ cứng:
		
		dd if=/dev/zero of=/dev/hda

* Backup MBR:

		dd if=/dev/hda of=/mbr_hda-old bs=512 count=1

* Xoá MBR và bảng phân vùng đĩa cứng:
	
		dd if=/dev/zero of=/dev/hda bs=512 count=1

* Chuyển chữ hoa thành chữ thường

		dd if=/root/test.doc of=/root/test1.doc conv=ucase

* Chuyển chữ thường thành chữ hoa

		dd if=/root/test1.doc of=/test2.doc conv=scase,sycn

		

