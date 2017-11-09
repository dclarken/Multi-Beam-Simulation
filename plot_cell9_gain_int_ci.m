function plot_cell9_gain_int_ci()
global CS;
cell_radius=250/80;
interference=0;
interference1=0;
%24波束覆盖，9号点波束同频干扰分析 9号点波束的同频干扰现象最为严重%
%gain
subplot(1,3,1);
    title('gain');
    %hold on;
    a_contour=[0:0.1:2*pi];
    x=CS(9).xpos+0.7*cell_radius*cos(a_contour);
    y=CS(9).ypos+0.7*cell_radius*sin(a_contour);
    [X,Y] = meshgrid(x,y);
    z_gain=cell_vatalaro(abs(X-CS(9).xpos),abs(Y-CS(9).ypos))+CS(9).gain_max+CS(9).power;
    mesh(x,y,z_gain);
    
%interference    
subplot(1,3,2);
    black=[7,9,11,19,21,23];
    title('interfence');
    %hold on;
    a_contour=[0:0.1:2*pi];
    x=CS(9).xpos+0.7*cell_radius*cos(a_contour);
    y=CS(9).ypos+0.7*cell_radius*sin(a_contour);
    [X,Y] = meshgrid(x,y);
    interference=-ant_gain_in_cell(X,Y)+5*CS(9).gain_max;
    for j=1:6
       interference=interference+CS(black(j)).power+cell_vatalaro(abs(X-CS(black(j)).xpos),abs(Y-CS(black(j)).ypos));
    end
    interference=interference+5*10*log10(0.009);
    z_intference=interference;
    mesh(X,Y,z_intference);
    
    %ci
subplot(1,3,3);
    black=[7,9,11,19,21,23];
    title('ci');
    %hold on;
    a_contour=[0:0.1:2*pi];
    x=CS(9).xpos+0.7*cell_radius*cos(a_contour);
    y=CS(9).ypos+0.7*cell_radius*sin(a_contour);
    [X,Y] = meshgrid(x,y);
    interference1=5*CS(9).gain_max;
    for j=1:6
       interference1=interference1+CS(black(j)).power+cell_vatalaro(abs(X-CS(black(j)).xpos),abs(Y-CS(black(j)).ypos));
    end
    interference1=interference1+5*10*log10(0.009);
    z_ci=2*ant_gain_in_cell(X,Y)-interference1;
    mesh(X,Y,z_ci);
    Zmax=min(min(min(z_ci)))
    