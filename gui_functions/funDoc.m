function doc = funDoc()
    
str_Correlation = 'Inputs:  Wins = 64 or 64,64;64;64 . Method = ''single'',''multin''.  ';
str_Mask = 'Polygon...';
str_Filtering = 'Correlation Filtering';
str_Interpolate = 'Interpolation ''linear';
str_Pixel2Unit = 'Pixel2Unit Calibration...';
str_Magnitude = 'Magnitude';
str_AvgVelocity = 'AvgVelocity';
str_FlowRate = 'Flow Rate';
doc =struct('Correlation' , str_Correlation,'Mask',str_Mask, 'Filtering' ,...
    str_Filtering , 'Interpolate' , str_Interpolate, 'Pixel2Unit' , str_Pixel2Unit, ...
    'Magnitude' , str_Magnitude, 'AvgVelocity' , str_AvgVelocity, 'FlowRate' , str_FlowRate);
end
