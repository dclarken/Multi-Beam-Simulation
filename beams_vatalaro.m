function[f]=beams_vatalaro(x,y)
global CS;
f=0;
        for i=1:24
            f=f+vatalaro(x-CS(i).xpos,y-CS(i).ypos);
         end
