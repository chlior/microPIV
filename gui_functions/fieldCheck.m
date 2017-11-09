 function [bol] = fieldCheck(hObject, eventdata, handles , caseIndex)
    
    bol = 0; image = 0; correlation = 0; filtering = 0; physical = 0; 
    
    if isfield(handles,'image')==1  image = 1; end
    if isfield(handles,'mCorrelation')==1  correlation = 1; end
    if isfield(handles,'mFiltering')==1  filtering = 1; end
    if isfield(handles,'mphysical')==1  physical = 1; end


    switch caseIndex
        case 'Correlation'
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
        case 'Mask'
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
        case 'Filtering'
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end
        case 'Interpolate'
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end
            if image==1 & correlation==1 & filtering==0 bol = 1; uiwait(msgbox('Run Filtering First!')); return; end
        case 'Pixel2Unit' 
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end
        case 'Magnitude' 
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end 
            if image==1 & correlation==1 & physical==0 bol = 1;  uiwait(msgbox('Run Pixel2Unit First!')); return; end 
        case 'AvgVelocity' 
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end 
            if image==1 & correlation==1 & physical==0 bol = 1;  uiwait(msgbox('Run Pixel2Unit First!')); return; end 
        case 'FlowRate' %FlowRate
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end 
            if image==1 & correlation==1 & physical==0 bol = 1;  uiwait(msgbox('Run Pixel2Unit First!')); return; end 
        case 'Density' %Density
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
        case 'Streamline' %Streamline
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end 
        case 'Velocity_Profile' %Velocity_Profile
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end 
            if image==1 & correlation==1 & physical==0 bol = 1;  uiwait(msgbox('Run Pixel2Unit First!')); return; end 
            
    end
end