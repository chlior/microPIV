function [cal] =Calibration(x_cal, xp_cal, y_cal,  yp_cal)

calx = xp_cal/x_cal;
if isempty(yp_cal)~=0
    caly= yp_cal/y_cal;
else
    caly = calx;
end
cal = struct('x',calx,'y',caly);