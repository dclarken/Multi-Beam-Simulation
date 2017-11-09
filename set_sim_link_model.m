function set_sim_link_model()
global CS;
%%下行链路分析
%天线增益
D=2.8;          %2.8mt天线
f=20;           %20GHz频率
n=0.55;         %天线效率
G_max=20.4+20*log10(D*f)+10*log10(n);        %天线增益52.764dBi
P_T=10*log10(100);%放大器输出功率dB
L_FTX=4;%发射机与天线间的馈线损耗dB
EIRP_S=G_max+P_T-L_FTX;%卫星全向有效辐射功率
T=790;%
T_S=10*log10(T);%卫星接收系统噪声温度 29K
%下行链路传输损耗
d=35786;
L_F=92.45+20*log10(d*f);%自由空间传输损耗
L_A=0.5;%大气吸收损耗
L_O=0.5;%其他损耗
L_D=L_F+L_A+L_O;%下行链路传输损耗

for i=1:24;
    CS(i).gain_max=G_max;
    CS(i).L_D=L_D;
end