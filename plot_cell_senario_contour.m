function plot_cell_senario_contour()
global CS;
gen_cell_geometry_senario;
cell_radius=250/80;
axis([90,130,15,50]);%地图经纬度限定
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);%中国陆地地图背景
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%显示重要城市   for i=1:24
hold on;
z=0;
for i=1:24
     plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','b','marker','o');
     x=linspace(CS(i).xpos-0.8*cell_radius,CS(i).xpos+0.8*cell_radius);
     y=linspace(CS(i).ypos-0.8*cell_radius,CS(i).ypos+0.8*cell_radius);
%      a_contour=[0:2*pi];%边框为圆形的等高线
%      x=CS(i).xpos+cell_radius*cos(a_contour);
%      y=CS(i).ypos+cell_radius*sin(a_contour);
     [X,Y] = meshgrid(x,y);
    % z=vatalaro(X-CS(i).xpos,Y-CS(i).ypos);
     z=cell_vatalaro(X-CS(i).xpos,Y-CS(i).ypos);
     contour(x,y,z,10,'showtext','on');
     hold on;
  axis([90,130,15,50]);%地图经纬度限定
end