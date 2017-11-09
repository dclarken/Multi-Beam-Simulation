function[capcity]=get_capcity_72cell_4color_12timeslot();
global CS;
set_sim_power_allocation('no');
gen_cell_geometry_senario;
%72波束覆盖 4色复用 12时隙跳波束 容量计算
%根据波束覆盖效果图 同频波束覆盖情况与24波束4四色复用无跳波束方案相同 因而信噪比计算方法相同 点波束个数扩大3倍 通信容量扩大3倍
%capcity=3*get_capcity_24cell_4color_notimeslot
for i=1:24
    CS(i).CI_72cell_4color_12timeslot=ci_co_polar_in_cell(CS(i).xpos+0.001,CS(i).ypos+0.001);
end
for i=25:48
    CS(i).CI_72cell_4color_12timeslot=ci_co_polar_in_cell(CS(i-24).xpos+0.001,CS(i-24).ypos+0.001);
end
for i=49:72
    CS(i).CI_72cell_4color_12timeslot=ci_co_polar_in_cell(CS(i-48).xpos+0.001,CS(i-48).ypos+0.001);
end
B_tot=0.5;%每个波束的总带宽
capcity=0;
for i=1:24
    %capcity=capcity+B_tot*log2(1+CS(i).CI_72cell_4color_12timeslot);%相容极限 %56.5547*3=169.6641 Gbps
    capcity=capcity+B_tot*fun_DVB_S2_spectral_efficiency(CS(i).CI_72cell_4color_12timeslot);%DVB_S2  135.5497
end
capcity=capcity*3;
