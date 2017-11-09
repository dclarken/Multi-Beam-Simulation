function[z]=z_test()%测试同频干扰的衰减因子u、v
global CS;
    for i=1:24
        CS(i).power=10*log10(100);
    end
    z1=co_polar_interference_in_cell(93,29);
    z3=ci_co_polar_in_cell(93,29);
    for i=1:24
        CS(i).power=10*log10(90);
    end
    z2=co_polar_interference_in_cell(93,29);
    z4=ci_co_polar_in_cell(93,29);
    z=10*log10(100)-10*log10(90)-(z1-z2);
    z5=z3-z4