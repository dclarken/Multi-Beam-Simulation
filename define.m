function define()
global CS;
B_tot=500;%ÿ���������ܴ���
N_re_max=6;%����ͬʱ������һ��ʱ϶�Ĳ����� ����ֵ����n�ײ��ͼ���仯��������������
K=72;%��������Ϊ72
R=32;%���Է������ʱ϶
n=4;%n�ײ����
for i=1:72
    CI(1,i)=CS(i).CI_72cell_4color_12timeslot;
    cap_req(1,i)=CS(i).req_72;
end
cap(1,i)=B_tot*log2(1+CI(1,i));
N(1.i)=cap_req(1,i)./cap(1,i);