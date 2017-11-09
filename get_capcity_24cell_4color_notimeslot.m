function[capcity]=get_capcity_24cell_4color_notimeslot();
global CS;
set_sim_power_allocation('no');
gen_cell_geometry_senario;
%24波束覆盖 4色复用 无跳波束 容量计算
for i=1:24
    CS(i).CI_24cell_4color_notimeslot=ci_co_polar_in_cell(CS(i).xpos+0.0001,CS(i).ypos+0.0001);
end
B_tot=0.5;
capcity=0;
for i=1:24
   % capcity=capcity+B_tot*log2(1+CS(i).CI_24cell_4color_notimeslot);%相容极限%56.5547 Gbps
   capcity=capcity+B_tot*fun_DVB_S2_spectral_efficiency(CS(i).CI_24cell_4color_notimeslot);%DVB_S2  45.1832Gbps
end