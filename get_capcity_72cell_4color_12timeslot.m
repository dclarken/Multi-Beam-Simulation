function[capcity]=get_capcity_72cell_4color_12timeslot();
global CS;
set_sim_power_allocation('no');
gen_cell_geometry_senario;
%72�������� 4ɫ���� 12ʱ϶������ ��������
%���ݲ�������Ч��ͼ ͬƵ�������������24����4��ɫ������������������ͬ �������ȼ��㷽����ͬ �㲨����������3�� ͨ����������3��
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
B_tot=0.5;%ÿ���������ܴ���
capcity=0;
for i=1:24
    %capcity=capcity+B_tot*log2(1+CS(i).CI_72cell_4color_12timeslot);%���ݼ��� %56.5547*3=169.6641 Gbps
    capcity=capcity+B_tot*fun_DVB_S2_spectral_efficiency(CS(i).CI_72cell_4color_12timeslot);%DVB_S2  135.5497
end
capcity=capcity*3;
