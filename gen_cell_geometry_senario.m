%function gen_cell_geometry_senario()
%clear all
global system_consts;
global sim_consts;
global CS;      %cell site

%cell number 波束个数
Cnum=24;
% antenna parameters%
Am=52;
Freq=2.0e10;

% lengthe and width of the terrain(km)所有波束覆盖的区域%
cell_radius=250/80;%cell radius (km) 半径转化为地图大小
ISD=sqrt(3)*cell_radius;%didistance between beams
%xmin =-2.5*ISD;
%xmax =2.5*ISD;
%ymin =-2*cell_radius;
%ymax =2.5*cell_radius;
xmin=93.4274;
ymin=29.1182;

%24 cell position波束位置%
            xcoor=zeros(1,Cnum);
            ycoor=zeros(1,Cnum);
for i=1:6
        xcoor(i)=xmin+ISD*(i-1);
        ycoor(i)=ymin+3*cell_radius;
end
for i=7:12
         xcoor(i)=xmin+ISD/2+ISD*(i-7);  
         ycoor(i)=ymin+1.5*cell_radius;
end
for i=13:18
         xcoor(i)=xmin+ISD*(i-13);           
         ycoor(i)=ymin+0*cell_radius;
end
for i=19:24
         xcoor(i)=xmin+ISD/2+ISD*(i-19);
         ycoor(i)=ymin-1.5*cell_radius;
end
%beam border波束边界图像%
            %xbd_orig = [cell_radius:-cell_radius/50:cell_radius/2];%六边形波束
            %ybd_orig = -sqrt(3)*xbd_orig+sqrt(3)*cell_radius;
            a=[0/180*pi:1/180*pi:360/180*pi];%圆形波束边界
            xbd_orig = cell_radius*sin(a);
            ybd_orig = cell_radius*cos(a);
            
            cbd_orig = xbd_orig + sqrt(-1)*ybd_orig;
            x_border = xbd_orig;
            y_border = ybd_orig;
            %for theta =60:60:300
            %    x_border = [x_border real(cbd_orig*exp(sqrt(-1)*(theta)/180*pi))];
            %    y_border = [y_border imag(cbd_orig*exp(sqrt(-1)*(theta)/180*pi))];
            %end
            %    cbd_orig = x_border + sqrt(-1)* y_border;%波束覆盖图像翻转30度
            %    x_border = real(cbd_orig*exp(sqrt(-1)*30/180*pi));
            %    y_border = imag(cbd_orig*exp(sqrt(-1)*30/180*pi));
for i=1:24
                CS(i).xpos = xcoor(i);
                CS(i).ypos = ycoor(i);
                CS(i).x_border = CS(i).xpos + x_border;
                CS(i).y_border = CS(i).ypos + y_border;
end

%cell traffic request波束容量需求建模%
Traffic_request_24=2*rand(1,24); %max 1Gpbs
for i=1:24
   CS(i).req_24=Traffic_request_24(i);
end
Traffic_request_72=2000*rand(1,72); %max 1Gpbs
for i=1:72
   CS(i).req_72=Traffic_request_72(i);
end

%天线增益
D=2.8;          %2.8mt天线
f=20;           %20GHz频率
n=0.55;         %天线效率
G_max=20.4+20*log10(D*f)+10*log10(n);        %天线增益52.764dBi
P_T=10*log10(100);%放大器输出功率dB
L_FTX=4;%发射机与天线间的馈线损耗dB
EIRP_S=G_max+P_T-L_FTX;%卫星全向有效辐射功率
T=790;%
T_S=10*log10(T);%卫星接收系统噪声温度 29K
%下行链路传输损耗
d=35786;
L_F=92.45+20*log10(d*f);%自由空间传输损耗
L_A=0.5;%大气吸收损耗
L_O=0.5;%其他损耗
L_D=L_F+L_A+L_O;%下行链路传输损耗
for i=1:72;
    CS(i).gain_max=G_max;
    %CS(i).L_D=L_D;
end

%功率分配
%all beams' power =1  无功率分配模式%





