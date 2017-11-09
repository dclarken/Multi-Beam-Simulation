function []=plot_6timeslot_4color_24cell()
%clear all;
gen_cell_geometry_senario;
global CS; 
cell_radius=250/80;
ISD=sqrt(3)*cell_radius;
%��ɫ���ã�24�����������л����ԣ�6��ʱ϶����%
subplot(2,3,1);
title('timeslot1');
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%��ʾ��Ҫ����
hold on;
for i=1:24
    if(i==1||i==4||i==13||i==16)%4ɫ���ò�����������
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','r','marker','o');
      text((CS(i).xpos + 70/80),CS(i).ypos,'1','Fontsize',8,'Fontweight','bold');%�������ע������
    end
    plot(CS(i).x_border,CS(i).y_border,'linewidth',3,'color','k');%�������Ǳ߽�λ��
    hold on;
end
axis([90,130,15,50]);%��ͼ��γ���޶�
hold on;
subplot(2,3,2);
title('timeslot2');
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%��ʾ��Ҫ����
hold on;
for i=1:24
    if(i==2||i==5||i==14||i==17)%4ɫ���ò�����������
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','r','marker','o');
      text((CS(i).xpos + 70/80),CS(i).ypos,'1','Fontsize',8,'Fontweight','bold');%�������ע������
    end
    plot(CS(i).x_border,CS(i).y_border,'linewidth',3,'color','k');%�������Ǳ߽�λ��
    hold on;
end
axis([90,130,15,50]);%��ͼ��γ���޶�
hold on;
subplot(2,3,3);
title('timeslot3');
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%��ʾ��Ҫ����
hold on;
for i=1:24
    if(i==3||i==6||i==15||i==18)%4ɫ���ò�����������
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','r','marker','o');
      text((CS(i).xpos + 70/80),CS(i).ypos,'1','Fontsize',8,'Fontweight','bold');%�������ע������
    end
    plot(CS(i).x_border,CS(i).y_border,'linewidth',3,'color','k');%�������Ǳ߽�λ��
    hold on;
end
axis([90,130,15,50]);%��ͼ��γ���޶�
hold on;
subplot(2,3,4);
title('timeslot4');
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%��ʾ��Ҫ����
hold on;
for i=1:24
    if(i==10||i==7||i==22||i==19)%4ɫ���ò�����������
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','r','marker','o');
      text((CS(i).xpos + 70/80),CS(i).ypos,'1','Fontsize',8,'Fontweight','bold');%�������ע������
    end
    plot(CS(i).x_border,CS(i).y_border,'linewidth',3,'color','k');%�������Ǳ߽�λ��
    hold on;
end
axis([90,130,15,50]);%��ͼ��γ���޶�
hold on;
subplot(2,3,5);
title('timeslot5');
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%��ʾ��Ҫ����
hold on;
for i=1:24
    if(i==11||i==8||i==23||i==20)%4ɫ���ò�����������
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','r','marker','o');
      text((CS(i).xpos + 70/80),CS(i).ypos,'1','Fontsize',8,'Fontweight','bold');%�������ע������
    end
    plot(CS(i).x_border,CS(i).y_border,'linewidth',3,'color','k');%�������Ǳ߽�λ��
    hold on;
end
axis([90,130,15,50]);%��ͼ��γ���޶�
hold on;
subplot(2,3,6);
title('timeslot6');
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%��ʾ��Ҫ����
hold on;
for i=1:24
    if(i==9||i==12||i==21||i==24)%4ɫ���ò�����������
      plot(CS(i).xpos,CS(i).ypos,'linewidth',4,'color','r','marker','o');
      text((CS(i).xpos + 70/80),CS(i).ypos,'1','Fontsize',8,'Fontweight','bold');%�������ע������
    end
    plot(CS(i).x_border,CS(i).y_border,'linewidth',3,'color','k');%�������Ǳ߽�λ��
    hold on;
end
axis([90,130,15,50]);%��ͼ��γ���޶�
hold on;