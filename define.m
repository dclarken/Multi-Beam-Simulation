function define()
global CS;
B_tot=500;%每个波束的总带宽
N_re_max=6;%最多可同时工作在一个时隙的波束数 该数值增加n阶差方的图像会变化饱和容量会增加
K=72;%波束个数为72
R=32;%可以分配的总时隙
n=4;%n阶差方阶数
for i=1:72
    CI(1,i)=CS(i).CI_72cell_4color_12timeslot;
    cap_req(1,i)=CS(i).req_72;
end
cap(1,i)=B_tot*log2(1+CI(1,i));
N(1.i)=cap_req(1,i)./cap(1,i);