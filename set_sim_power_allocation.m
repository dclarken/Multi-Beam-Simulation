%power allocation 单位dB%
function set_sim_power_allocation(x)
%clear all;
global CS;
%all beams' power =20dBW  无功率分配模式 归一化%
if (x=='no');
    for i=1:24
        CS(i).power=10*log10(100);
    end
%power allocation plan%
elseif(x=='ac');
    for i=1:24
        CS(i).power=10*log10(10);
    end
end
