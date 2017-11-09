function plot_cell_senario_geo()
global CS;      %cell site
%gen_cell_geometry_senario;
numstr={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24'};
frqstr={'A','B','A','B','A','B','C','D','C','D','C','D','A','B','A','B','A','B','C','D','C','D','C','D'};%4色复用ABCD
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%显示重要城市
hold on;
for i=1:24
    if(i==1||i==3||i==5||i==13||i==15||i==17)%4色复用波束中心区分
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','r','marker','o');  
      elseif(i==2||i==4||i==6||i==14||i==16||i==18)
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','blue','marker','o'); 
      elseif(i==7||i==9||i==21||i==11||i==19||i==23)
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','black','marker','o'); 
      elseif(i==8||i==10||i==12||i==20||i==22||i==24)
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','y','marker','o'); 
    end
    text((CS(i).xpos + 70/80),CS(i).ypos,numstr(i),'Fontsize',8,'Fontweight','bold');%波束点标注波束号
    text((CS(i).xpos - 120/80),CS(i).ypos,frqstr(i),'Fontsize',8,'Fontweight','bold');%4色复用标注
    hold on
    plot(CS(i).x_border,CS(i).y_border,'linewidth',3,'color','k');%波束覆盖边界位置
    hold on;
    xlabel('经度'),ylabel('纬度');
end
axis([90,130,15,50]);%地图经纬度限定
hold on;


