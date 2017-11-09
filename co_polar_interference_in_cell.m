%�����꣨x��y������ͬƵͬ��������
function[interference]=co_polar_interference_in_cell(x,y)
global CS;
cell_radius=250/80;
position_id=0;
interference=0;
red=[1,3,5,13,15,17];%4ɫ���ò�����ͬƵ����
blue=[2,4,6,14,16,18];
black=[7,9,11,19,21,23];
yellow=[8,10,12,20,22,24];
%v=5*10*log10(0.0008);%xϵ������
%u=1;
v=5*10*log10(0.02);
u=0.4;
u1=1;
for i=1:24 %ȷ���������ڲ���ID
    a=sqrt((x-CS(i).xpos).^2+(y-CS(i).ypos).^2);
    if (a<=cell_radius)
        position_id=i;
    end
end
for i=1:6%red beams
    if (position_id==red(i));
       interference=-ant_gain_in_cell(x,y)+5*CS(i).gain_max-CS(position_id).power;%���ų�ʼ������ȥ�õ����������
        for j=1:6
           interference=interference+u*CS(red(j)).power+cell_vatalaro(abs(x-CS(red(j)).xpos),abs(y-CS(red(j)).ypos));
           %����㴦��6��ͬƵͬ���������Ĺ�һ����������ǿ��
        end
        interference=u1*interference+v;%ϵ������
    end
end
for i=1:6%blue beams
    if (position_id==blue(i));
       interference=-ant_gain_in_cell(x,y)+5*CS(i).gain_max-CS(position_id).power;
        for j=1:6
           interference=interference+u*CS(blue(j)).power+cell_vatalaro(abs(x-CS(blue(j)).xpos),abs(y-CS(blue(j)).ypos));      
        end
        interference=u1*interference+v;
    end
end
for i=1:6%black beams
    if (position_id==black(i));
       interference=-ant_gain_in_cell(x,y)+5*CS(i).gain_max-CS(position_id).power;
        for j=1:6
           interference=interference+u*CS(black(j)).power+cell_vatalaro(abs(x-CS(black(j)).xpos),abs(y-CS(black(j)).ypos));
        end
        interference=u1*interference+v;
    end
end
for i=1:6%yellow beams
    if (position_id==yellow(i));
       interference=-ant_gain_in_cell(x,y)+5*CS(i).gain_max-CS(position_id).power;
        for j=1:6
           interference=interference+u*CS(yellow(j)).power+cell_vatalaro(abs(x-CS(yellow(j)).xpos),abs(y-CS(yellow(j)).ypos));
        end
        interference=u1*interference+v;
    end
end