%每一个波束内的主瓣天线增益覆盖%
function [gain]=ant_gain_in_cell(x,y)
global CS;
cell_radius=250/80;
gain=0;
a=0;
%[x,y] = meshgrid(X,Y);
for i=1:24
    a=sqrt((x-CS(i).xpos).^2+(y-CS(i).ypos).^2);
    if (a<=cell_radius)
        gain=cell_vatalaro(abs(x-CS(i).xpos),abs(y-CS(i).ypos));
    end
end
gain=gain+CS(i).gain_max+CS(i).power;%gain_max=52.7674