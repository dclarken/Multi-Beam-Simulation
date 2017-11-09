%ci 载噪比 该坐标处的天线增益减去同频干扰
function[ci]=ci_co_polar_in_cell(x,y)
global CS;
ci=ant_gain_in_cell(x,y)-co_polar_interference_in_cell(x,y);
%function[CI]=ci_co_polar(a,b,c,d,e,f)%24个波束 4色频率复用 6个簇 考虑一个波束与五个同频波束间的干扰%
%global CS;
%cell_radius=250;%cell radius (km)
%ISD=sqrt(3)*cell_radius;%didistance between beams
%I(1)=vatalaro(CS(a).xpos-CS(b).xpos,CS(a).ypos-CS(b).ypos);
%I(2)=vatalaro(CS(a).xpos-CS(c).xpos,CS(a).ypos-CS(c).ypos);
%I(3)=vatalaro(CS(a).xpos-CS(d).xpos,CS(a).ypos-CS(d).ypos);
%I(4)=vatalaro(CS(a).xpos-CS(e).xpos,CS(a).ypos-CS(e).ypos);
%I(5)=vatalaro(CS(a).xpos-CS(f).xpos,CS(a).ypos-CS(f).ypos);
%CI=10*log(0.08*(CS(b).power*I(1)+CS(c).power*I(2)+CS(d).power*I(3)+CS(e).power*I(4)+CS(f).power*I(5)));
%CI=0.08*(CS(b).power*I(1)+CS(c).power*I(2)+CS(d).power*I(3)+CS(e).power*I(4)+CS(f).power*I(5));
%CI=CS(a).power-CI;


