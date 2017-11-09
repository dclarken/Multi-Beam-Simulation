function plot_cell_gain()
global CS;
    %cell_radius=0.9*250/80;
    cell_radius=250/80;
    for i=1:24
    a_contour=[0:0.1:2*pi];
    x=CS(i).xpos+cell_radius*cos(a_contour);
    y=CS(i).ypos+cell_radius*sin(a_contour);
    [X,Y] = meshgrid(x,y);
    z=cell_vatalaro(abs(X-CS(i).xpos),abs(Y-CS(i).ypos))+CS(i).gain_max+CS(i).power;
    surf(x,y,z);
    %contour(x,y,z,4,'showtext','on');
    hold on;
    end
   % axis([90,130,20,50,40,60]);%地图经纬度限定
