function[SF]=fun_satisfaction_factor(select)
global CS;
gen_cell_geometry_senario;
get_capcity_72cell_4color_12timeslot;
fun_time_allo_72cell_4color_12timeslot;
%求用户需求满足因子
if (select=='72cell_n')%求n阶差方的满足因子
    for i=1:72
        C(i)= CS(i).ans_n_72_cap;
        %C(i)=x(i);
    end
elseif (select=='72cell_f')%求公平性目标函数的满足因子
    for i=1:72
        C(i)= CS(i).ans_f_72_cap;
        %C(i)=x(i);
    end
end
C_tot_req=0;
for i=1:72
    C_tot_req=C_tot_req+CS(i).req_72;
end
C_tot_useful_off=0;
for i=1:72
    C_useful_off(i)=min(C(i),CS(i).req_72);
    C_tot_useful_off=C_tot_useful_off+C_useful_off(i);
end
SF= C_tot_useful_off/C_tot_req;
