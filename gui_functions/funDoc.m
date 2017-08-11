function doc = funDoc()
    
str_Correlation = 'Inputs:  Wins = 64 or 64,64;64;64 . Method = ''single'',''multin''.  ';
str_Mask = 'Polygon...';
str_Filtering = 'Correlation Filtering';
str_Interpolate = 'Interpolation ''linear';

doc =struct('Correlation' , str_Correlation,'Mask',str_Mask, 'Filtering' , str_Filtering , 'Interpolate' , str_Interpolate);
end
