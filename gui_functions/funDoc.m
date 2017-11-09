function doc = funDoc()

str_Open = '(1)Load file. (2)Choose function from the list. (3)Run. Note: for new anslys press ''Reset''. Default saving location is TEMP in the current folder otherwise location is given. Recommended sequence: Mask:Correlation:Filtering:Interpolate:Pix2Unit:...'
str_Correlation = 'Pair corelation. Inputs:  Wins = 64 or 64 64;32 32 . Method = ''single'',''multin'',''multinfft''. DeltaT = time gap. SizeFactor = Only change the apperent vector size.';
str_Mask = 'Ceate Mask (Polygon) over the image part you wan''t need.';
str_Filtering = 'Correlation Filtering: Choose The type and order of the filter (max 3) and run. This make gaps in the data, recommended running an interpolation.';
str_Interpolate = 'Interpolation ''linear';
str_Pixel2Unit = 'Pixel2Unit Calibration...';
str_Magnitude = 'Velocity Magnitude; ''m'' sqrt(u^2+v^2), ''u'' u componnent , ''v'' v component';
str_AvgVelocity = 'AvgVelocity';
str_FlowRate = 'Flow Rate: Only in y direction';
str_Density = 'Density';
str_Streamline = 'Streamline';
str_VelocityProfile = 'Velocity Profile at position 1- 100%';

doc =struct('Open', str_Open, 'Correlation' , str_Correlation,'Mask',str_Mask, 'Filtering' ,...
    str_Filtering , 'Interpolate' , str_Interpolate, 'Pixel2Unit' , str_Pixel2Unit, ...
    'Magnitude' , str_Magnitude, 'AvgVelocity' , str_AvgVelocity, 'FlowRate' , str_FlowRate,...
    'Density' , str_Density, 'Streamline' , str_Streamline,'VelocityProfile', str_VelocityProfile);
end
