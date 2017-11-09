function[color,wcolor,w_]=fun_color_reuse_72()
global CS;
    color=zeros(4,18);
    wcolor=zeros(4,72);
    w_=zeros(72,72);
    color(1,:)=[1,3,5,13,15,17,25,27,29,37,39,41,49,51,53,61,63,65];
    color(2,:)=[2,4,6,14,16,18,26,28,30,38,40,42,50,52,54,62,64,66];
    color(3,:)=[7,9,11,19,21,23,31,33,35,43,45,47,55,57,59,67,69,71];  
    color(4,:)=[8,10,12,20,22,24,32,34,36,44,46,48,56,58,60,68,70,72];
    for j=1:24
        for i=1:24
            w_(j,i)=1;
        end
    end
    for j=25:48
        for i=25:48
            w_(j,i)=1;
        end
    end
    for j=49:72
        for i=49:72
            w_(j,i)=1;
        end
    end
  
for i=1:4
    for j=1:18
        wcolor(i,color(i,j))=1;
    end            
end