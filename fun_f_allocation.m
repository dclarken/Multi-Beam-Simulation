function[W_num] =fun_f_allocation (x,W_num,CI,req)
global CS;
if (x==24)
K=24;%波束个数
B_tot=2000;%每个波束的总带宽
N_re_max=6;%最多可同时工作在一个时隙的波束数 该数值增加n阶差方的图像会变化饱和容量会增加
Q=32;%可以分配的总时隙
elseif (x==72)
K=72;
B_tot=2000;%每个波束的总带宽
N_re_max=12;
Q=96;
else
    K=x;
    B_tot=2000;%每个波束的总带宽
    N_re_max=12;
    Q=96;
end

for i=1:K
    cap(i)=W_num(i)/Q*B_tot*log2(1+CI(i)); 
    %cap(i)=W_num(i)/Q*B_tot*fun_DVB_S2_spectral_efficiency(1+CI(i));
end
%cap=B_tot.*log2(1+CI); 
    sum3=0;
    for j=1:K
        sum3=sum3+req(j)/(W_num(j)/Q*B_tot*log2(1+CI(j)));
        %sum3=sum3+req(j)/W_num(j)/Q*B_tot*fun_DVB_S2_spectral_efficiency(1+CI(j));
    end
for i=1:K
    W_num(i)=req(i)/cap(i)*N_re_max/sum3*Q;
    %W(i)=round(W(i));%取整函数
end


