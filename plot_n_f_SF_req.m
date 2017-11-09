function plot_n_f_SF_req()
global CS;
%作图 n阶差方与公平性目标函数随容量需求增加的函数图像
Traffic_request_72=10*rand(1,72); 
for k=1:100 %容量需求逐渐增加
        for i=1:72
            CS(i).req_72=k*10*Traffic_request_72(i);
        end
    fun_time_allo_72cell_4color_12timeslot;
    z_n(k)=fun_satisfaction_factor('72cell_n');%n阶差方的算法不适用与需求大于系统供给的情况
    z_f(k)=fun_satisfaction_factor('72cell_f');
    %plot(k,z_n(k),'linewidth',8,'color','r');
    %hold on;
    %plot(k,z_f(k),'linewidth',8,'color','b');
    %grid on;
end
x=linspace(1,100);
plot(x,z_n(x),'linewidth',2,'color','r');
hold on;
plot(x,z_f(x),'linewidth',2,'color','b');
grid on;
