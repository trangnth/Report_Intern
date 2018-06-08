## File Permissons

Trong Linux và Unix, mỗi file đều có một user sở hữu gọi là owner. Mỗi file cũng sẽ có một group sở hữu, những người trong group này có các permission nhất định: read, write và execute.

|Command|	Result|
|-------|---------|
|chown|	Thay đổi người sở hữu file và thư mục|
|chgrp|	Thay đổi group sở hữu|
|chmod|	Thay đổi permission trên file hoặc thư mục|

Files có 3 kiểu permission: read (r), write (w), execute (x). Chúng thường được biểu diễn theo  thứ tự `rwx`. Các permission này ảnh hưởng tới các nhóm của người sở hữu: user(u), group (g), và others (o). Kết quả là bạn có 3 nhóm như sau:

|-----|----|----|
|rwx: |rwx | rwx|
|u:|g:|o|



### Lệnh `chmod` 

```sh
chmod [option] [permission] [name file/directory]
```

Phần `permision` có 3 kiểu:

* Kiểu ký tự (rw-rw-r--)
* Kiểu ugo: Phân quyền cho từng đối tượng (u+x: user thêm quyền thực thi)
* Kiểu số: ví dụ rwxrw-r = 764

#### Một số quy ước cho kiểu ugo

|--|-----------|
| +| Thêm quyền|
|-| Bỏ quyền |
|=| Gán quyền|

|-|------|
|a| u+g+o|
|u| user owner|
|g| group owner|
|o| other user|

Một ví dụ:
```sh
chmod a=-,u+rwx,g+rwsx,u-w
```

Phân tích lệnh trên: đầu tiên bỏ toàn bộ quyền cho cả 3 nhóm(u, g, o), sau đó thêm quyền rwx cho user sở hữu, thêm quyền rwsx cho group sở hữu, sau đó lại bỏ quyền `w` cho user

Thêm một vài ví dụ:

* 

#### Kiểu dùng ký tự để phân quyền

|permission||Note|
|----------|-|----|
|r|read|owner có quyền đọc file|
|w|write|owner có quyền sửa và xóa file|
|x|execute|owner có quyền thực thi đối với file, với thư mục thì được phép sử dụng lệnh `cd` để truy cập|
|s|setuid hoặc setgid| Tất cả các file và thư mục con sẽ được kế thừa group owner|
|t| sticky bit| Chỉ có owners mới có thể rename và xóa file trong tất cả các file của directory| 
|-|Không set quyền|

Với quyền execute (x)

||Không có suid| Có suid|
|-|------------|--------|
|Không có execute| - | S|
|Có execute| x |s|

Ví dụ: `o+rws` cho phép user sở hữu có full quyền đồng thời set suid


#### Quy ước kiểu số:
|permision|binary|number|
|---------|------|------|
|---|000|0|
|--x|001|1|
|-w-|010|2|
|-wx|011|3|
|r--|100|4|
|r-x|101|5|
|rw-|110|6|
|rwx|111|7|

Ngoài ra người ta sử dụng thêm một bit thứ 4 để biểu diễn suid, sgid và sticky bit

|----|-----|
|suid| 4000|
|sgid|2000|
|sticky|1000|

Mặc định thì khi set permision cho thư mục thì sẽ có tính kế thư cho các file và các thư mục con

#### Default Permisions
umask

#### Group sudo

File cấu hình sudo nằm ở:

>/etc/sudoes

>/etc/sudoes.d/

Dòng `%sudo   ALL=(ALL:ALL) ALL` có nghĩa là group sudo có quyền thực thi tất cả các lệnh. Muốn user có quyền của nhóm sudo thì thêm vào nhóm này. Ví dụ thêm group uet để các thành viên đều có quyền thực thi tất cả các lệnh thì thêm dòng `%uet ALL=(ALL:ALL) ALL`


Lệnh tạo 1 group: `groupadd uet` sau đó thêm user trang vào group này: `usermod -G uet trang`

Kiểm tra lại xem mình đã trong group đó chưa: `groups trang`








