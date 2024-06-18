Hello I'm Yukino :))
Đây là note cho đống file ở dưới

Phần 1 Dựng cluster với các file SET

- Đầu tiên là Các file SET_01:05
  - SET_01 , SET_02 chạy trên cả master và worker
  - SET_03 , SET_04 , SET_05 chạy trên master (chỉ con master đầu tiên mới phải chạy SET_04)
- Sau khi thực hiện xong từ 01 -> 05 thì master-node đã được xác định cũng như thiết lập

- Sử dụng các lệnh sudo kubeadm token create --print-join-command để in ra lệnh gia nhập vào
  cluster < lúc mới tạo cluster thì cũng có > , có mả lệnh cho master trong mô hình nhiều master nữa

---

Phần 2 Bảo trì Cluster - Khi nào cần bảo trì Cluster ? - Khi mà một số node vì lý do chủ quan / khách quan mà bị tắt đi , bật lại , rejoin - Khi xảy ra bug (ít nhất là chỗ mà tôi hay gặp)
phần này sẽ note lại cách giải quyết các vấn đề đó cũng như hướng dẫn sử dụng 1 số file để có thể fix chúng
nhanh hơn , ko cần nhớ về nó nữa

Đầu tiên thì kể tới STOP_K8s.sh
Tại sao lại cần file này, khi muốn thoát node ra khỏi cluster . Để tránh cho việc thoát hiện tại ảnh hưởng tới phiên
làm việc sau ( thường không còn nhớ or không biết phiên trước có những ảnh hưởng gì ) thì phải xóa bỏ gọn gàng để
phiên tới làm việc trơn tru chứ ko cần phải build lại từ đầu ( or maybe vẫn phải làm )

    -> file này làm gì ? reset kubeadm và xóa các file cấu hình // Ừ vậy thôi

Tiếp theo là RESET_WORKER.sh
file này tạm thời t chỉ sử dụng trên con WORKER khi nó bị tắt đi bật lại thôi ( master thì chưa thử nhưng có vẻ là không bị ảnh hưởng gì)
lỗi nặng thì t cài lại luôn cụm .

    Thường thì sau khi t reboot thì con worker sẽ bị out khỏi cluster nó ở trạng thái NotReady ( t không nhớ là con master reboot hay con worker reboot thì gặp lỗi này ) nhưng tạm thời thì khắc phục bằng cách rejoin em nó lại

    thế nên là chạy cái file này sẽ làm 2 việc:

    - reset kubeadm / xóa file cấu hình phiên trước / reset lại một số service

    - Yêu cầu nhập join command ( có gợi ý về việc chạy sang master để xin joincommand )

Thực hiện tới đây là gặp lỗi về CNI này và t đã tra mạng , thử 1 vài cách sau và nó hoạt động lại:
tuy nhiên t chưa biết là do cái nào hay thứ tự ra sao thì thành công đâu nên t cứ ghi hết lại đây:

    - xóa đi 2 coredns pod cho chúng nó tạo lại
    - sudo systemctl restart kubelet
    - tắt đi bật lại interface mạng enp3s0 : đừng có nhầm vào dải 192.168.101.0/24 đấy :D
    - sudo systemctl restart containerd / docker
    - sudo systemctl restart kubelet
    - xóa đi 2 coredns pod cho chúng nó tạo lại
    - redeploy :))

ờ hình như là nó thành công từ bước nào ở trên rồi ấy nhưng mà cái pod cũ nó đc schedular với config cũ nên phải redeploy thì nó mới chạy .
Biết thế đã ;?

làm xong thì lặp lại các bước để rejoin worker to cluster