function [bol] = fieldCheck(hObject, eventdata, handles , caseIndex)
    
    bol = 0; image = 0; correlation = 0;
    
    if isfield(handles,'image')==1  image = 1; end
    if isfield(handles,'mCorrelation')==1  correlation = 1; end
%     if isfield(handles,'mCorrelation')==0 uiwait(msgbox('Run Correlation First!')); bol = bol+1; end

    switch caseIndex
        case 1
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
        case 2
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
        case 3
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end
        case 4
            if image==0 bol=1; uiwait(msgbox('Load Image First!')); return; end
            if image==1 & correlation==0 bol = 1; uiwait(msgbox('Run Correlation First!')); return; end
    end
end