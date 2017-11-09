function[]=plot_nandf_cap_allo()
global CS;
%72波束 4色复用 12以上的时隙个数 波束时隙分配方案
%基于n阶差方目标函数
B_tot=500;%每个波束的总带宽
B_voice=30;%固定话音业务
N_re_max=6;%最多可同时工作在一个时隙的波束数
K=72;%波束个数为72
R=12;%可以分配的总时隙
n=4;%n阶差方阶数 
%容量需求逐渐增加
Traffic_request_voice_72=rand(1,72); 
        for i=1:72
            CS(i).req_72=10*i;
            %CS(i).req_72_voice=0.5*Traffic_request_voice_72(i);
            CS(i).req_72_voice=0.25*i;%二十分之一的容量用于话音业务
        end
%分配一定容量用于基于n阶差方分配方式 用于话音业务
for i=1:72
    cap_n(i)=B_voice*log2(1+CS(i).CI_72cell_4color_12timeslot); 
    cap_f(i)=(B_tot-B_voice)*log2(1+CS(i).CI_72cell_4color_12timeslot);
end
movie=0;
voice=0;
for i=1:72
    movie=movie+40*CS(i).req_72; 
    voice=voice+40*CS(i).req_72_voice;
end
movie
voice
for i=1:72
    sum1=0;
    sum2=0;
    for k=1:72
        sum1=sum1+(log2(1+CS(i).CI_72cell_4color_12timeslot)/log2(1+CS(k).CI_72cell_4color_12timeslot) ).^(n/(n-1));   
    end
    for k=1:72
        sum2=sum2+CS(k).req_72_voice/(B_voice*log2(1+CS(k).CI_72cell_4color_12timeslot)); 
    end
    sum2=sum2-N_re_max;%由图像发现 当需求较小时 n阶差方的方法忽略容量需求较小的波束分配容量
    N_T(i)=CS(i).req_72_voice/cap_n(i)-sum2/sum1;%当需求量大于系统容量时，函数解有负值 
    N_T(i)=N_T(i)*R;
    %N_T(i)=round(N_T(i));%取整函数 round（四舍五入） ceil（向上取整）
    if (N_T(i)<0) %将函数的负数解归0 不满足实际条件的解 n阶乘差方的分配方法不适合于需求大于系统容量的情况
        N_T(i)=0;
    end
    CS(i).ans_n_72=N_T(i);
end
for i=1:72
    %CS(i).ans_n_72_cap=N_T(i)/R*12*B_voice*log2(1+CS(i).CI_72cell_4color_12timeslot);
    CS(i).ans_n_72_cap=N_T(i)/R*12*B_voice*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
sum_n_72_cap=0;
for i=1:72
    sum_n_72_cap=sum_n_72_cap+CS(i).ans_n_72_cap;
end
sum_n_72_cap;
%基于公平性函数 除了话音业务的其他容量需求
for i=1:72
    sum3=0;
    for k=1:72
        sum3=sum3+CS(k).req_72/((B_tot-B_voice)*log2(1+CS(k).CI_72cell_4color_12timeslot));
    end
    N_F(i)=CS(i).req_72/cap_f(i)*N_re_max/sum3*R;
    %N_F(i)=round(N_F(i));%取整函数
    CS(i).ans_f_72=N_F(i);
end
for i=1:72
    %CS(i).ans_f_72_cap=N_F(i)/R*12*(B_tot-B_voice)*log2(1+CS(i).CI_72cell_4color_12timeslot);
    CS(i).ans_f_72_cap=N_F(i)/R*12*(B_tot-B_voice)*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
sum_f_72_cap=0;
for i=1:72
    sum_f_72_cap=sum_f_72_cap+CS(i).ans_f_72_cap;
end
sum_f_72_cap;
for k=1:72 
    z_n(k)=CS(k).ans_n_72_cap;
    z_f(k)=CS(k).ans_f_72_cap;
    z(k)=CS(k).ans_n_72_cap+CS(k).ans_f_72_cap;
    subplot(1,3,1);%50M 语音业务线性需求 分配情况
%     plot(k,z_n(k),'or');
%     title('话音业务');
%     plot(k,CS(k).req_72_voice,'or');
%     hold on;
    plot(k,z_n(k),'oblack');
    ylabel('容量(/Mbps)');
%     legend('话音业务需求','话音业务分配');
        legend('话音业务分配');
    hold on;
    grid on;
    subplot(1,3,2)
%     plot(k,CS(k).req_72,'+g');
%     hold on;
    plot(k,z_f(k),'+black');
    ylabel('容量(/Mbps)');
%     legend('视频业务需求','视频业务分配')；
    legend('视频业务分配');
    hold on;
    grid on;
    subplot(1,3,3)
    plot(k,z_n(k),'or');
    ylabel('容量(/Mbps)');
    hold on;    
    plot(k,z_f(k),'+g');
    hold on;    
    plot(k,z(k),'xb');% 各个波束的容量分配情况
    hold on;
    legend('话音业务分配','视频业务分配','总业务分配');
    %plot(k,10.5*k,'y.');
    grid on;
end