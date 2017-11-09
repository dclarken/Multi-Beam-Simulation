function gen_cell_geometry_senario_72()
global CS;      %cell site
gen_cell_geometry_senario;
cell_radius=250/80;%cell radius (km) �뾶ת��Ϊ��ͼ��С
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
            a=[0/180*pi:1/180*pi:360/180*pi];%Բ�β����߽�
            xbd_orig = cell_radius*sin(a);
            ybd_orig = cell_radius*cos(a);
            xfbd_orig = cell_radius/2*sin(a);
            yfbd_orig = cell_radius/2*cos(a);
            for i=1:24
                CS(i).xf1pos= xcoor(i)+cell_radius/2*cos(pi/3);%С������������λ��ȷ��
                CS(i).yf1pos= ycoor(i)+cell_radius/2*sin(pi/3);
                CS(i).xf2pos= xcoor(i)+cell_radius/2*cos(pi/3+1*2*pi/3);
                CS(i).yf2pos= ycoor(i)+cell_radius/2*sin(pi/3+1*2*pi/3);
                CS(i).xf3pos= xcoor(i)+cell_radius/2*cos(pi/3+2*2*pi/3);
                CS(i).yf3pos= ycoor(i)+cell_radius/2*sin(pi/3+2*2*pi/3);
                
                CS(i).x_border = CS(i).xpos + xbd_orig;
                CS(i).y_border = CS(i).ypos + ybd_orig;
            end
%ȷ��72���㲨������λ��
for i=1:24
    CS(i).xfpos=CS(i).xf1pos;
    CS(i).yfpos=CS(i).yf1pos;
end
for i=25:48
    CS(i).xfpos=CS(i-24).xf2pos;
    CS(i).yfpos=CS(i-24).yf2pos;
end
for i=49:72
    CS(i).xfpos=CS(i-48).xf3pos;
    CS(i).yfpos=CS(i-48).yf3pos;
end

for i=1:24 %Ȧ��С���������߽�
                CS(i).xf1_border = CS(i).xf1pos + xfbd_orig;
                CS(i).yf1_border = CS(i).yf1pos + yfbd_orig;
                CS(i).xf2_border = CS(i).xf2pos + xfbd_orig;
                CS(i).yf2_border = CS(i).yf2pos + yfbd_orig;
                CS(i).xf3_border = CS(i).xf3pos + xfbd_orig;
                CS(i).yf3_border = CS(i).yf3pos + yfbd_orig;              
end
geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);%��ʾ�й�½�ص�ͼ
cities=shaperead('worldcities','UseGeoCoords',true);
geoshow(cities,'Marker','.','Color','red');%��ʾ��Ҫ����
axis([90,130,15,50]);%�޶���γ��
hold on;
for i=1:24 
   % plot(CS(i).x_border,CS(i).y_border,'linewidth',2,'color','k');%�������Ǳ߽�λ��
    hold on;
    plot(CS(i).xf1_border,CS(i).yf1_border,'linewidth',1,'color','k');%�������Ǳ߽�λ�� �����ڵ�����С����
    hold on;
    plot(CS(i).xf2_border,CS(i).yf2_border,'linewidth',1,'color','k');
    hold on;
    plot(CS(i).xf3_border,CS(i).yf3_border,'linewidth',1,'color','k');
    hold on;  
end
numstr={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68','69','70','71','72',};
for i=1:72
     plot(CS(i).xfpos,CS(i).yfpos,'linewidth',2,'color','r','marker','o');
     text((CS(i).xfpos + 70/80),CS(i).yfpos,numstr(i),'Fontsize',8,'Fontweight','bold')
end
for i=1:2:24 %12ʱ϶��ÿ��ʱ϶��ͬƵ��������
    if (i==1||i==3||i==5||i==13||i==15||i==17)
        plot(CS(i).xf1pos,CS(i).yf1pos,'linewidth',2,'color','b','marker','o');  
    end
end
%cell traffic request������������ģ%
Traffic_request_72=2*rand(1,72); %max 1Gpbs
for i=1:72
   CS(i).req_72=Traffic_request_72(i);
end