function[]=polt_cap_FR_SFR()
k= fun_cap_PR_SFR(0.1,0.1);
 for FR=0.2:0.02:0.9
    for PR=0.2:0.02:0.9%ռƵ�ȹ̶�ʱ�ҵ����ʱ�ϵͳ����������
        a=fun_cap_PR_SFR_1(PR,FR);
        if k<=a
            k=a;
        else
            k=k;
        end
    end
    plot(FR,k,'.r');
hold on;
grid on
xlabel('���ز�Ƶ��/��Ƶ��');
ylabel('capcity');
 end
