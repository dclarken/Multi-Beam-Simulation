function gen_cell_geometry_senario_allcolor()
global CS;      %cell site
cell_radius=250/80;%cell radius (km) 半径转化为地图大小
ISD=sqrt(3)*cell_radius;%didistance between beams
xmin=93.4274;
ymin=29.1182;
            xcoor=zeros(1,24);
            ycoor=zeros(1,24);
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
            a=[0/180*pi:1/180*pi:360/180*pi];%圆形波束边界
            xbd_orig = cell_radius*sin(a);
            ybd_orig = cell_radius*cos(a);
            xfbd_orig = cell_radius*7/10*sin(a);
            yfbd_orig = cell_radius*7/10*cos(a);
            for i=1:24
                
                CS(i).x_border = CS(i).xpos + xbd_orig;
                CS(i).y_border = CS(i).ypos + ybd_orig;
            end
for i=1:24 %圈内小波束波束边界
                CS(i).xf_border = CS(i).xpos + xfbd_orig;
                CS(i).yf_border = CS(i).ypos + yfbd_orig;             
end
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);%显示中国陆地地图
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%显示重要城市
axis([90,130,15,50]);%限定经纬度
hold on;
for i=1:24 
    plot(CS(i).x_border,CS(i).y_border,'linewidth',2,'color','k');%波束覆盖边界位置
    hold on;
    plot(CS(i).xf_border,CS(i).yf_border,'linewidth',1,'color','k');%波束覆盖边界位置 大波束内的小波束
    hold on;
 
end
for i=1:24 %同频波束成像 
        plot(CS(i).xpos,CS(i).ypos,'linewidth',2,'color','b','marker','o');  
end
%cell traffic request波束容量需求建模%
Traffic_request_72=2*rand(1,72); %max 1Gpbs
for i=1:72
   CS(i).req_allcolor=Traffic_request_72(i);
end