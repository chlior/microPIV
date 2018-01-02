function doc = funDoc()

str_Open = sprintf('(0)Save Folder.\n(1)Load file. \n(2)Choose from list. \n(3)Run. \nNote: Default saving location is TEMP in the current folder otherwise location is given. \nRecommended sequence: Mask:Correlation:Filtering:Interpolate:Pix2Unit:...');
str_Correlation = sprintf('Pair corelation. \nInputs:  \nWins = 64 or 64 64;32 32 . \nMethod = ''single'',''multin'',''multinfft''. \nDeltaT = time gap. \nSizeFactor = Display vector size. \nOverlap: between subwindows');
str_Mask = sprintf('Ceate Mask (Polygon) over the image part you wan''t need.');
str_Filtering = sprintf('Correlation Filtering: \nChoose The type and order of the filter (max 3) and run. \nThis make gaps in the data, recommended running an interpolation.');
str_Interpolate = sprintf('Interpolation ''linear'', \nfiling the empty vector with interpolating vector.' );
str_Pixel2Unit = sprintf('Pixel2Unit Calibration. \nInput: channel width (y) in ''um'' and ''pixels'' \noutput: converting the data to real world unit [um] [um/s]; choose data to convert ''Correlation'' ''Filtering'' ''Interpolate''; \nIf empty X parameters, Y calibration will valid to X ');
str_ColorMap = sprintf(' Display>> \nmagnitude \ncontour fill \ngradient contour \ngradient contour fill \nvorticity. \nVelocity>> Magnitude: ''m'',\nComponent: ''u'', ''v'' ');
str_AvgVelocity = 'AvgVelocity. calculating by deafult the the average velocity of each lentgh line, the plot the avage velocity profile along the width. note: the raw data may be uneven along the image! ';
str_FlowRate = 'Flow Rate: Only in y direction';
str_Density = 'Density. averaging pixel intensity of sub-windows in the image. note: light issues and fluid formation may appear.';
str_Streamline = 'Streamline';
str_VelocityProfile = sprintf('Analysis: \nsection \nmulti scection\navg line. \nVelocity Profile at position 1- 100%');

doc =struct('Open', str_Open, 'Correlation' , str_Correlation,'Mask',str_Mask, 'Filtering' ,...
    str_Filtering , 'Interpolate' , str_Interpolate, 'Pixel2Unit' , str_Pixel2Unit, ...
    'ColorMap' , str_ColorMap, 'AvgVelocity' , str_AvgVelocity, 'FlowRate' , str_FlowRate,...
    'Density' , str_Density, 'Streamline' , str_Streamline,'VelocityProfile', str_VelocityProfile);
end
