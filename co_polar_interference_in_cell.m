%点坐标（x，y）处的同频同极化干扰
function[interference]=co_polar_interference_in_cell(x,y)
global CS;
cell_radius=250/80;
position_id=0;
interference=0;
red=[1,3,5,13,15,17];%4色复用波束的同频波束
blue=[2,4,6,14,16,18];
black=[7,9,11,19,21,23];
yellow=[8,10,12,20,22,24];
%v=5*10*log10(0.0008);%x系数因子
%u=1;
v=5*10*log10(0.02);
u=0.4;
u1=1;
for i=1:24 %确定坐标所在波束ID
    a=sqrt((x-CS(i).xpos).^2+(y-CS(i).ypos).^2);
    if (a<=cell_radius)
        position_id=i;
    end
end
for i=1:6%red beams
    if (position_id==red(i));
       interference=-ant_gain_in_cell(x,y)+5*CS(i).gain_max-CS(position_id).power;%干扰初始化，减去该点的天线增益
        for j=1:6
           interference=interference+u*CS(red(j)).power+cell_vatalaro(abs(x-CS(red(j)).xpos),abs(y-CS(red(j)).ypos));
           %坐标点处在6个同频同极化波束的归一化天线增益强度
        end
        interference=u1*interference+v;%系数因子
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