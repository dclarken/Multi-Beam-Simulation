function plot_n_f_cap_allo()
global CS;
%�����������������������Է���ʱ��n�ײ�ͻ��ڹ�ƽ�Եĺ��������ڵ㲨�����������ͼ�����
%Traffic_request_72=400*rand(1,72); 
        for i=1:72
            %CS(i).req_72=7*i;%ϵ��Ϊ7ʱ���ֺ���С�������������ϵ��Ϊ4�������Сʱ������С����Ҳ��Ӧһ����ϵͳ����
            CS(i).req_72=4*i;
        end
    fun_time_allo_72cell_4color_12timeslot;
for k=1:72 
    z_n(k)=CS(k).ans_n_72_cap;
    z_f(k)=CS(k).ans_f_72_cap;
    plot(k,z_n(k),'or');
    hold on;
    plot(k,z_f(k),'xb');
    xlabel('����'),ylabel('������/Mbps��');
    legend('N �� �� ��','�� ƽ ��');
    grid on;
end

