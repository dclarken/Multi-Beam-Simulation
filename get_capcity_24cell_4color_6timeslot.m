function[capcity]=get_capcity_24cell_4color_6timeslot
global CS;
set_sim_power_allocation('no');
gen_cell_geometry_senario;
%6��ʱ϶��4ɫƵ�ʸ����������� ÿ��ʱ϶�� ͬƵ����ֻ��4�� �Ÿɱ����� ʵ���������� 
%����������CI�Ÿɱ�
interference=0;
red=[1,4,13,16];%4ɫ���ò�����ͬƵ���� 6ʱ϶ ͬһ��ʱ϶�µ��ĸ�ͬƵ�㲨��λ�õȼۣ��Ÿɱ���ͬ��
%v=5*10*log10(0.0008);%xϵ������
%u=1;
v=5*10*log10(0.02);
u=0.4;
interference=3*57.7674-CS(1).power;
        for j=2:4
           interference=interference+u*CS(red(j)).power+cell_vatalaro(abs(CS(1).xpos-CS(red(j)).xpos),abs(CS(1).ypos-CS(red(j)).ypos));
           %����㴦��6��ͬƵͬ���������Ĺ�һ����������ǿ��
        end
        interference=interference+v;%ϵ������
for i=1:24
    ci=CS(i).gain_max+CS(i).power-interference;
end
for i=1:24
    CS(i).CI_24cell_4color_6timeslot=ci;
end
%��������
B_tot=0.5;%500MHz
%capcity=24*B_tot/6*6*log2(1+ci);%���ݼ��� һ������֡��Ϊ6ʱ϶ ���ݼ�������µ�Ƶ�������� %63.9376
capcity=24*B_tot/6*6*fun_DVB_S2_spectral_efficiency(ci);%DVB_S2  46.80