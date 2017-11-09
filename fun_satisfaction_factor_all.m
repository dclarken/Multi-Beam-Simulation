function[SF]=fun_satisfaction_factor_all(K,req,cap)
global CS;
C_tot_req=0;
C_tot_req=req*ones(1,K)';
C_tot_useful_off=0;
for i=1:K
    C_useful_off(i)=min(cap(i),req(i));
end
C_tot_useful_off= C_useful_off*ones(1,K)';
SF= C_tot_useful_off./C_tot_req;