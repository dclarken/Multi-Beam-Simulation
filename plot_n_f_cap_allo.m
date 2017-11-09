function plot_n_f_cap_allo()
global CS;
%各个波束的容量需求按照线性分配时，n阶差方和基于公平性的函数，对于点波束容量分配的图像分析
%Traffic_request_72=400*rand(1,72); 
        for i=1:72
            %CS(i).req_72=7*i;%系数为7时出现忽略小容量波束情况，系数为4（需求更小时）出现小波束也供应一定的系统带宽
            CS(i).req_72=4*i;
        end
    fun_time_allo_72cell_4color_12timeslot;
for k=1:72 
    z_n(k)=CS(k).ans_n_72_cap;
    z_f(k)=CS(k).ans_f_72_cap;
    plot(k,z_n(k),'or');
    hold on;
    plot(k,z_f(k),'xb');
    xlabel('波束'),ylabel('容量（/Mbps）');
    legend('N 阶 差 方','公 平 性');
    grid on;
end

