function plot_cell_ci()
global CS;
    cell_radius=250/80;
    position_id=0;
    interference=0;
    red=[1,3,5,13,15,17];%4ɫ���ò�����ͬƵ����
    blue=[2,4,6,14,16,18];
    black=[7,9,11,19,21,23];
    yellow=[8,10,12,20,22,24];
for i=1:6%red beams
    a_contour=[0:0.1:2*pi];
    x=CS(i).xpos+cell_radius*cos(a_contour);
    y=CS(i).ypos+cell_radius*sin(a_contour);
    [X,Y] = meshgrid(x,y);
       interference=5*CS(i).gain_max;%���ų�ʼ������ȥ�õ����������
        for j=1:6
           interference=interference+CS(red(j)).power+cell_vatalaro(abs(X-CS(red(j)).xpos),abs(Y-CS(red(j)).ypos));
           %����㴦��6��ͬƵͬ���������Ĺ�һ����������ǿ��
        end
        interference=interference+5*10*log10(0.009);%ϵ������
    z=2*ant_gain_in_cell(X,Y)-interference;
    surf(X,Y,z);
    hold on;
end
for i=1:6%blue beams
    a_contour=[0:0.1:2*pi];
    x=CS(i).xpos+cell_radius*cos(a_contour);
    y=CS(i).ypos+cell_radius*sin(a_contour);
    [X,Y] = meshgrid(x,y);
    interference=5*CS(i).gain_max;
        for j=1:6
           interference=interference+CS(blue(j)).power+cell_vatalaro(abs(X-CS(blue(j)).xpos),abs(Y-CS(blue(j)).ypos));      
        end
        interference=interference+5*10*log10(0.009);
    z=2*ant_gain_in_cell(X,Y)-interference;
    surf(X,Y,z);
    hold on;
end
for i=1:6%black beams
    a_contour=[0:0.1:2*pi];
    x=CS(i).xpos+cell_radius*cos(a_contour);
    y=CS(i).ypos+cell_radius*sin(a_contour);
    [X,Y] = meshgrid(x,y);
       interference=5*CS(i).gain_max;
        for j=1:6
           interference=interference+CS(black(j)).power+cell_vatalaro(abs(X-CS(black(j)).xpos),abs(Y-CS(black(j)).ypos));
        end
        interference=interference+5*10*log10(0.009);
    z=2*ant_gain_in_cell(X,Y)-interference;
    surf(X,Y,z);
    hold on;
end
for i=1:6%yellow beams
    a_contour=[0:0.1:2*pi];
    x=CS(i).xpos+cell_radius*cos(a_contour);
    y=CS(i).ypos+cell_radius*sin(a_contour);
    [X,Y] = meshgrid(x,y);
       interference=5*CS(i).gain_max;
        for j=1:6
           interference=interference+CS(yellow(j)).power+cell_vatalaro(abs(X-CS(yellow(j)).xpos),abs(Y-CS(yellow(j)).ypos));
        end
        interference=interference+5*10*log10(0.009);
    z=2*ant_gain_in_cell(X,Y)-interference;
    surf(X,Y,z);
    hold on;
end
%axis([90,130,34,42,15,40]);%��ͼ��γ���޶�