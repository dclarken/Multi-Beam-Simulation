function[]=polt_cap_PR_FFR()
 x=linspace(0,1,10);
for x=0.1:0.01:1
plot(x,fun_cap_PR_FFR(x,1/5),'.r');
hold on
end
grid on
hold on