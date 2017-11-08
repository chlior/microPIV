function [cal] =Calibration(x_cal, xp_cal, y_cal,  yp_cal)

caly = yp_cal/y_cal;
if isempty(xp_cal)~=0
    calx= xp_cal/x_cal;
else
    calx = caly;
end
cal = struct('x',calx,'y',caly);