function[]=polt_cap_FR_SFR()
k= fun_cap_PR_SFR(0.1,0.1);
 for FR=0.2:0.02:0.9
    for PR=0.2:0.02:0.9%占频比固定时找到功率比系统容量中最大的
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
xlabel('主载波频宽/总频宽');
ylabel('capcity');
 end
