function[]=polt_cap_PR_SFR()
 x=linspace(0,1,10);
for x=0.1:0.01:1
plot(x,fun_cap_PR_SFR_1(x,2/3),'.r');
hold on
end
grid on
hold on
for x=0.1:0.01:1
plot(x,fun_cap_PR_SFR_1(x,3/5),'+b');
grid on
hold on
end
% xlabel('内、外层波束功率比');
xlabel('PR');
ylabel('capcity /Gbps');
hold on
% legend('FR=2/1','FR=3/2');
% legend('FR=3/5');
% maxy=max(fun_cap_PR_SFR)