function[]=fun_time_allo_72cell_4color_12timeslot()
global CS;
%72波束 4色复用 12以上的时隙个数 波束时隙分配方案
%基于n阶差方目标函数
B_tot=500;%每个波束的总带宽
N_re_max=6;%最多可同时工作在一个时隙的波束数 该数值增加n阶差方的图像会变化饱和容量会增加
K=72;%波束个数为72
R=32;%可以分配的总时隙
n=4;%n阶差方阶数
set_sim_power_allocation('no');%功率分配方式
get_capcity_72cell_4color_12timeslot;%72个点波束的信噪比
%确定容量需求
%Traffic_request_72=200*rand(1,72); 
        %for i=1:72
          %  CS(i).req_72=Traffic_request_72(i);
        %end
%基于n阶差方

%线性容量需求
%         for i=1:72
%             %CS(i).req_72=7*i;%系数为7时出现忽略小容量波束情况，系数为4（需求更小时）出现小波束也供应一定的系统带宽
%             CS(i).req_72=4*i;
%         end
%
for i=1:72
    cap(i)=B_tot*log2(1+CS(i).CI_72cell_4color_12timeslot); 
    %cap(i)=B_tot*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
for i=1:72
    sum1=0;
    sum2=0;
    for k=1:72
        sum1=sum1+(log2(1+CS(i).CI_72cell_4color_12timeslot)/log2(1+CS(k).CI_72cell_4color_12timeslot)).^(n/(n-1)); %相容极限
    end
    for k=1:72
        sum2=sum2+CS(k).req_72./(B_tot*log2(1+CS(k).CI_72cell_4color_12timeslot)); 
    end
    sum2=sum2-N_re_max;%由图像发现 当需求较小时 n阶差方的方法忽略容量需求较小的波束分配容量
    N_T(i)=CS(i).req_72/cap(i)-sum2/sum1;%当需求量大于系统容量时，函数解有负值 
    N_T(i)=N_T(i)*R;
    %N_T(i)=round(N_T(i));%取整函数 round（四舍五入） ceil（向上取整）
    if (N_T(i)<0) %将函数的负数解归0 不满足实际条件的解 n阶乘差方的分配方法不适合于需求大于系统容量的情况
        N_T(i)=0;
    end
    CS(i).ans_n_72=N_T(i);
end
for i=1:72
    %CS(i).ans_n_72_cap=N_T(i)/R*12*B_tot*log2(1+CS(i).CI_72cell_4color_12timeslot);
    CS(i).ans_n_72_cap=N_T(i)/R*12*B_tot*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
sum_n_72_cap=0;
for i=1:72
    sum_n_72_cap=sum_n_72_cap+CS(i).ans_n_72_cap;
end
sum_n_72_cap;
%基于公平性函数
for i=1:72
    sum3=0;
    for k=1:72
        sum3=sum3+CS(k).req_72/(B_tot*log2(1+CS(k).CI_72cell_4color_12timeslot));
    end
    N_F(i)=CS(i).req_72/cap(i)*N_re_max/sum3*R;
    %N_F(i)=round(N_F(i));%取整函数
    CS(i).ans_f_72=N_F(i);
end
for i=1:72
    %CS(i).ans_f_72_cap=N_F(i)/R*12*B_tot*log2(1+CS(i).CI_72cell_4color_12timeslot);%R为时隙个数 在12个波束之间轮换 12*B_tot
    CS(i).ans_f_72_cap=N_F(i)/R*12*B_tot*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
sum_f_72_cap=0;
for i=1:72
    sum_f_72_cap=sum_f_72_cap+CS(i).ans_f_72_cap;
end
sum_f_72_cap;