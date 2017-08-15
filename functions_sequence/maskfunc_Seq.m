function [maske]=maskfunc(hObject, eventdata, handles)  %,x,y,u,v
% hObject    handle to PB_Load_Create_Mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% based on mask()
if isfield(handles,'image')==0
uiwait(msgbox('Load pair of images first!'));
return
end

ima=handles.image{1};

if ischar(ima)
  [A,p1]=imread(ima);
  if isrgb(A), A=rgb2gray(A); end
  if ~isempty(p1), A=ind2gray(A,p1); end
  
  if nargin==1
      wocofile='';
  end
else
    A=ima;
end
  inp=1;
  tel=1;
  while inp~=0,      
 
      [maske(tel).msk,maske(tel).idx,maske(tel).idy]=roipoly(A);  

      hold on
      %in=inpolygon(A,double(idx),double(idy));
      [py,px]=find(maske(tel).msk==1);
      h1=plot(px(1:4:end),py(1:4:end),'.r');
      
      choice = questdlg('Do you whish to add another field to mask?', ...
	'More polygons','Yes','No', 'Yes');
        % Handle response
        switch choice
            case 'Yes'
               inp=1; 
            case 'No'
               inp=0; 
        end

%       inp=input('Do you whish to add another field to mask? (1 = yes, 0 = no) >> ');
      tel=tel+1;
  end
imshow(A), hold on  % clf, 31.7.2017 

  for i=1:length(maske)
      [py,px]=find(maske(i).msk==1);
      h1=plot(px(1:6:end),py(1:6:end),'.r');
  end
  
[filename, pathname] = uiputfile( 'polymask.mat',  'Save Maskfile name');
 if filename==0; filename='empty'; end
  
fullname = fullfile(pathname,filename);

[maske(:).idxw] = maske.idx;
[maske(:).idyw] = maske.idy;
   save(fullname, 'maske')
% save polymask.mat maske
