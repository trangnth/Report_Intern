## Command netstat

`netstat` là một công cụ command line để giám sát các kết nối mạng về cả incoming, outcoming 

## Một số lệnh thông dụng cần thiết

Lắng nghe tất cả các port (TCP và UDP) sử dụng `netstat -a`

Kiểm tra các port đang sử dụng phương thức TCP `netstat -at`

Kiểm tra các port đang sử dụng phương thức UDP `netstat -au`

Kiểm tra các port đang ở trạng thái listening `netstat -l`

Kiểm tra các port đang listen dùng phương thức TCP `netstat -lt`

Kiểm tra các port đang listen dùng phương thức UDP `netstat -lu`

Kiểm tra được port đang lắng nghe sử dụng dịch vụ gì `netstat -plnt`

Hiển thị bảng định tuyến `netstat -rn`

Kiểm tra những kết nối thông qua port 80 `netstat -an | grep :80 | sort`

Kiểm tra có bao nhiêu gói SYN_REC trên server. Đối với con số thì tùy thuộc vào server của bạn, ví dụ nếu mỏi ngày có tầm 20 đến 30 kết nối, bổng dưng một ngày lên cả 100 -> 1000 kết nối thì bạn hiểu rồi đó -> server bị ddos: `netstat -np | grep SYN_REC | wc -l`
