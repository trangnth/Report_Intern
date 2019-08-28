## Command top

Lệnh `top` 

```sh
top - 19:57:34 up 47 min,  2 users,  load average: 0.00, 0.01, 0.05
Tasks: 192 total,   1 running, 191 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.7 sy,  0.0 ni, 99.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :   283732 total,    14552 free,    77204 used,   191976 buff/cache
KiB Swap:  1046524 total,  1043444 free,     3080 used.   172428 avail Mem 

   PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                    
     1 root      20   0   37828   5432   3900 S  0.0  1.9   0:02.20 systemd                    
     2 root      20   0       0      0      0 S  0.0  0.0   0:00.00 kthreadd                   
     3 root      20   0       0      0      0 S  0.0  0.0   0:00.05 ksoftirqd/0                
     5 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 kworker/0:0H               
     7 root      20   0       0      0      0 S  0.0  0.0   0:00.14 rcu_sched                  
     8 root      20   0       0      0      0 S  0.0  0.0   0:00.00 rcu_bh                     
     9 root      rt   0       0      0      0 S  0.0  0.0   0:00.00 migration/0                
    10 root      rt   0       0      0      0 S  0.0  0.0   0:00.01 watchdog/0                 
    11 root      20   0       0      0      0 S  0.0  0.0   0:00.00 kdevtmpfs                  
    12 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 netns                      
    13 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 perf                       
    14 root      20   0       0      0      0 S  0.0  0.0   0:00.00 khungtaskd                 
    15 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 writeback                  
    16 root      25   5       0      0      0 S  0.0  0.0   0:00.00 ksmd                       
    17 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 crypto                     
    18 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 kintegrityd                
    19 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 bioset                     
    20 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 kblockd                    
    21 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 ata_sff 
```

Dòng đầu tiên: thể hiện thời gian máy uptime, số user đang đăng nhập, tải trung bình của hệ thống. Ba thông số của load average lần lượt chỉ khối lượng trung bình hệ thống phải xử lý trong khoảng thời gian 1p, 5p và 15p.

Dòng 2: thể hiện tổng số tiến trình, số tiến trình đang chạy, số tiến trình đang chờ, số tiến trình đã dừng, số tiến trình đang chờ dừng (zombie)

Dòng 3: Phần trăm CPU sử dụng cho người dùng (%us), Phần trăm CPU sử dụng cho hệ thống (%sy), Phần trăm CPU sử dụng cho tiến trình update (%ni), Phần trăm CPU không sử dụng (%id), Phần trăm CPU đợi các tiến trình I/O của hệ thống (wa%), Phần trăm CPU sử dụng giao tiếp với phần cứng (%hi), Phần trăm CPU sử dụng giao tiếp với phần mềm (%si)

Dòng 4,5 thể hiện mức độ sử dụng RAM và swap

Bên dưới là bảng các tiến trình với các thông số:

* PID: ID của tiến trình
* USER: User sử dụng tiến trình đó
* PR: Mức đăng quyền của tiến trình
* NI: Giá trị tốt của tiến trình
* VIRT: Bộ nhớ ảo dùng cho tiến trình
* RES: Bộ nhớ vật lý dùng cho tiến trình
* SHR
* S
* %CPU: Phần trăm CPU sử dụng cho tiến trình
* %MEM: Phần trăm bộ nhớ sử dụng cho tiến trình
* TIME: Tổng thời gian hoạt động của tiến trình
* COMMAND: Tên của tiến trình



## Tham khảo

Để hiểu rõ hơn về loadavg:

https://tech.vccloud.vn/loadavg-phan-tong-quan-loadavg-442.htm

https://tech.vccloud.vn/loadavg-phan-ii-cac-yeu-anh-huong-toi-loadavg-431.htm
