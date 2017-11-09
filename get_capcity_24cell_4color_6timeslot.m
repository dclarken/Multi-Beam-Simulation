function[capcity]=get_capcity_24cell_4color_6timeslot
global CS;
set_sim_power_allocation('no');
gen_cell_geometry_senario;
%6个时隙的4色频率复用容量计算 每个时隙下 同频波束只有4个 信干比提升 实现容量增加 
%单个波束的CI信干比
interference=0;
red=[1,4,13,16];%4色复用波束的同频波束 6时隙 同一个时隙下的四个同频点波束位置等价，信干比相同。
%v=5*10*log10(0.0008);%x系数因子
%u=1;
v=5*10*log10(0.02);
u=0.4;
interference=3*57.7674-CS(1).power;
        for j=2:4
           interference=interference+u*CS(red(j)).power+cell_vatalaro(abs(CS(1).xpos-CS(red(j)).xpos),abs(CS(1).ypos-CS(red(j)).ypos));
           %坐标点处在6个同频同极化波束的归一化天线增益强度
        end
        interference=interference+v;%系数因子
for i=1:24
    ci=CS(i).gain_max+CS(i).power-interference;
end
for i=1:24
    CS(i).CI_24cell_4color_6timeslot=ci;
end
%计算容量
B_tot=0.5;%500MHz
%capcity=24*B_tot/6*6*log2(1+ci);%相容极限 一个波束帧分为6时隙 相容极限情况下的频带利用率 %63.9376
capcity=24*B_tot/6*6*fun_DVB_S2_spectral_efficiency(ci);%DVB_S2  46.80