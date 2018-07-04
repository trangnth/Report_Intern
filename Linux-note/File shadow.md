## File shadow note

Cấu trúc file /etc/shadow

	Username:Password-encode:last_pass_change:maxday:maximum:warn:inactive:expire

Trong đó:

1. Username : Tên người dùng.

2. Password-encode : Mật khẩu người sử dụng được mã hóa bởi các thuật toán khác nhau tùy từng distro.
         $1$i.c8pVks$KGiRzVYjr8uRZUYzwQxcL1
* Được phân cách thành 3 trường bởi $.
    * Trường 1: Cho biết thuật tóan mã hóa.

            $1 : MD5
            $2 : blowfish
            $2a : eksblowfish
            $5 : sha256
            $6 : sha512
    
    * Trường 2: Là một chuỗi dữ liệu ngẫu nhiên (salt) kết hợp với pass người dùng, tăng tính bảo mật trong hàm băm.
    * Trường 3: Giá trị băm của salt với password

* Nếu tại password-encode mà :
           * `rỗng`, nghĩa là không có mật khẩu.
           * `!` , nghĩa là mật khẩu người dùng bị chặn, nhưng có thể sử dụng phương thức khác để connect, như ssh key.
           * `*`, nghĩa là mật khẩu bị chặn, vẫn có thể connect bằng phương thức khác.

3. last_pass_change : Thời gian từ ngày 1/1/1970 tới lần thay đổi mật khẩu gần nhất (tính bằng ngày).

4. maxday : Thời gian tối đa để thay đôi mật khẩu. 0 là thay đổi bất kỳ lúc nào ( tính bằng ngày ).

5. maximum : Thời gian mật khẩu còn thời hạn ( tính bằng ngày ).

6. warn : Thời gian cảnh báo mật khẩu sắp hết hạn ( tính bằng ngày)

7. inactive : Thời gian mà mật khẩu người dùng hết hạn (tính bằng ngày )

8. expire : Thời gian mà người dùng bị vô hiêu hóa, tính từ ngày 1/1/1970 ( tính bằng ngày ).