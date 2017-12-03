function infoData(hObject, eventdata, handles)

strCorrelation=  '';
strMask = '';
strFiltering = '';
strInterpolate = '';
strPixel2Unit ='';
strVelocityProfile ='';
strFlowrate = '';

if isfield(handles,'wins')
    wins = ['>>[Wins = ', sprintf('%d, ',handles.wins),']'];
    deltaT = sprintf('[DeltaT = %d]',handles.deltaT);
    overlap = sprintf('[Overlap = %.2f]',handles.overlap);
    method = sprintf('[Method = %s]',handles.method);
    sizeFactor = sprintf('[sizeFactor = %d]',handles.sizeFactor);
    strCorrelation = strcat(wins,{'   '},deltaT,{'   '},overlap,{'   '},method,{'   '},sizeFactor);
%     strCorrelation = strcat(wins,deltaT,overlap,method,sizeFactor);
end
if isfield(handles,'maskfile')
    if isempty(handles.maskfile)~=1
    strMask = sprintf('\n>>Mask = Yes');
    end
end
if isfield(handles,'filterChoose')
    filterChoose0 = sprintf('\n>>Filters Choosed = ');
    filterChoose1 = sprintf('%s   ',handles.filterChoose);
    filterChoose2 = sprintf('.');
    filterChoose = strcat(filterChoose0,filterChoose1,filterChoose2);
    globtrld = sprintf('\nGlobal Threshold = %.2f',handles.globtrld);
    loctrld = sprintf('\nLocal Threshold = %.2f',handles.loctrld);
    snrtrld = sprintf('\nSnr Threshold = %.2f',handles.snrtrld);
    strFiltering = strcat(filterChoose,globtrld,loctrld,snrtrld);
end
if isfield(handles,'mInterpolate')
    strInterpolate = sprintf('\n>>Interpolate = Yes');
end
if isfield(handles,'mphysical')
    strPixel2Unit = sprintf('\n>>mPhysical = Yes');
end
if isfield(handles,'vp')
    strVelocityProfile = sprintf('\n>>Vprofile = Yes');
end
if isfield(handles,'fr')
    strFlowrate = sprintf('\n>>Flowrate = Yes');
end
str = strcat(strCorrelation,strMask,strFiltering,strInterpolate,strPixel2Unit,strFlowrate)
set(handles.text_Data,'String',str);drawnow;   
end

% switch str
%     case 'Correlation'
%         wins = sprintf('Wins = %d __',handles.wins);
%         deltaT = sprintf('DeltaT = %d __',handles.deltaT);
%         overlap = sprintf('Overlap = %.2f __',handles.overlap);
%         method = sprintf('Method = %d __',handles.method);
%         sizeFactor = sprintf('sizeFactor = %d __',handles.sizeFactor);
%         strCorrelation = strcat(wins,deltaT,overlap,method,sizeFactor);
%         set(handles.text_Data,'String',strCorrelation);drawnow;        
%     case 'Mask'
%         strCorrelation0 = '';
%         if isfield(handles,'wins')
%             wins = sprintf('Wins = %d    ',handles.wins);
%             deltaT = sprintf('DeltaT = %d    ',handles.deltaT);
%             overlap = sprintf('Overlap = %.2f    ',handles.overlap);
%             method = sprintf('Method = %d    ',handles.method);
%             sizeFactor = sprintf('sizeFactor = %d    ',handles.sizeFactor);
%             strCorrelation0 = strcat(wins,deltaT,overlap,method,sizeFactor);
%         end
%         mask = sprintf('Mask = ready    ');
%         strCorrelation = strcat(mask,strCorrelation0);
%         set(handles.text_Data,'String',strCorrelation);drawnow; 
%     case 'Filtering'
%         
%     case 'Interpolate'
%         
% end

% 