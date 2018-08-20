function varargout = openpiv(varargin)

images_list = openpiv_imread(directory);
% imshow(im);


preprocess = 0;
if preprocess
    im = preprocess_function(im);
end

if crop_vec_flag
    cropvec = rect;
else
    cropvec = [0 0 0 0];
end

if jump_flag
    if jump == -1
        jump = 0;
    end

% Main loop
image1 = fullfile(images_path,images_list{1});
image2 = fullfile(images_path,images_list{1});

[a,b] = read_pair_of_images_rect(handles,1,1,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer);
if isempty(a) || isempty(b)
    errordlg('Something wrong with your images')
end

switch recording_type % sequence of pairs? 
    case{'sequence'}
        for fileind = 1:handles.amount-jump	% main loop, for whole file list
            openpiv_main_loop(handles, fileind, jump, cropvec,ittWidth,...
    ittHeight,ovlapHor,ovlapVer, prepfun, s2ntype, s2nl, outl, sclt, dt)
        end
    case{'pairs'}
        for fileind = 1:2:handles.amount	% main loop, for whole file list
            openpiv_main_loop(handles, fileind, 1, cropvec,ittWidth,...
    ittHeight,ovlapHor,ovlapVer, prepfun, s2ntype, s2nl, outl, sclt, dt)
        end
    otherwise
        
end


% --- Executes on selection change in popupmenu_ittWidth.
function popupmenu_ittWidth_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ittWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ittWidth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ittWidth

if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% contents = get(hObject,'String');
% handles.itt = str2double(contents{get(hObject,'Value')});
% guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_ittWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ittWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% contents = get(hObject,'String');
% handles.itt = str2double(contents{get(hObject,'Value')});
% guidata(hObject,handles);


% --- Executes on selection change in popupmenu_ovlpHor.
function popupmenu_ovlpHor_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ovlpHor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ovlpHor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ovlpHor

% contents = get(hObject,'String');
% handles.spc = str2double(contents{get(hObject,'Value')});
% guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_ovlpHor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ovlpHor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupmenu_s2ntype.
function popupmenu_s2ntype_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_s2ntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_s2ntype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_s2ntype

contents = get(hObject,'String');%  returns popupmenu_s2ntype contents as cell array
handles.s2ntype = str2double(contents{get(hObject,'Value')});% returns selected item from popupmenu_s2ntype
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_s2ntype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_s2ntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

contents = get(hObject,'String');%  returns popupmenu_s2ntype contents as cell array
handles.s2ntype = str2double(contents{get(hObject,'Value')});% returns selected item from popupmenu_s2ntype
guidata(hObject,handles);


function edit_s2nl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s2nl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s2nl as text
%        str2double(get(hObject,'String')) returns contents of edit_s2nl as a double


% --- Executes during object creation, after setting all properties.
function edit_s2nl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s2nl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.s2nl = str2double(get(hObject,'String')); % returns contents of edit_s2nl as a double
guidata(hObject,handles);


function edit_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_scale as a double

handles.scale = str2double(get(hObject,'String'));% returns contents of edit_scale as a double
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.scale = str2double(get(hObject,'String'));% returns contents of edit_scale as a double
guidata(hObject,handles);


function edit_outl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outl as text
%        str2double(get(hObject,'String')) returns contents of edit_outl as a double

handles.outl = str2double(get(hObject,'String')); % returns contents of edit_outl as a double
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_outl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.outl = str2double(get(hObject,'String')); % returns contents of edit_outl as a double
guidata(hObject,handles);


% --- Executes on button press in pushbutton_stop.
function pushbutton_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection = questdlg(['Stop ' get(handles.figure1,'Name') '?'],...
    ['Close ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
elseif strcmp(selection,'Yes')
    set(handles.pushbutton_start,'UserData',0);
    set(handles.figure1,'pointer','arrow');
end
% delete(handles.figure1)
guidata(hObject,handles);


function edit_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num as text
%        str2double(get(hObject,'String')) returns contents of edit_num as a double


% --- Executes during object creation, after setting all properties.
function edit_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_jump_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jump as text
%        str2double(get(hObject,'String')) returns contents of edit_jump as a double
handles.jump = str2double(get(hObject,'String')); % returns contents of edit_jump as a double
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_jump_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.jump = str2double(get(hObject,'String')); % returns contents of edit_jump as a double
guidata(hObject,handles);

% --- Executes on button press in button_select.
function button_select_Callback(hObject, eventdata, handles)
% hObject    handle to button_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
handles.rect = getrect;
rectangle('position',handles.rect,'Curvature',[0 0],'Edgecolor','yellow','Linestyle',':');
guidata(handles.figure1,handles);


% --- Executes on button press in button_reset_ROI.
function button_reset_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to button_reset_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield(handles,'rect')
    handles.rect = [];
    delete(findobj(handles.axes1,'type','rectangle'))
end
guidata(handles.figure1,handles);


% --- Executes on selection change in popupmenu_ittHeight.
function popupmenu_ittHeight_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ittHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ittHeight contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ittHeight


% --- Executes during object creation, after setting all properties.
function popupmenu_ittHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ittHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_ovlpVer.
function popupmenu_ovlpVer_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ovlpVer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ovlpVer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ovlpVer


% --- Executes during object creation, after setting all properties.
function popupmenu_ovlpVer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ovlpVer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_preprocess.
function checkbox_preprocess_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_preprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_preprocess

if get(hObject,'Value')
    % if checked
    set(handles.pushbutton_select_preprocessor,'Enable','on');
else
    set(handles.pushbutton_select_preprocessor,'Enable','off');
end


% --- Executes on button press in pushbutton_select_preprocessor.
function pushbutton_select_preprocessor_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_preprocessor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
preprocess_mfile = uigetfile('*.m','Pick an M-file');
handles.preprocess = preprocess_mfile(1:end-2);
guidata(handles.figure1,handles);


% --- Executes on button press in prev_image.
function prev_image_Callback(hObject, eventdata, handles)
% hObject    handle to prev_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
filenum = str2num(get(handles.edit_num,'String'));
filenum = max(1,filenum - 1);
set(handles.edit_num,'String',int2str(filenum));
% imshow(fullfile(handles.path,handles.files{1}));
imshow(openpiv_imread(handles,filenum));
guidata(hObject, handles);



% --- Executes on button press in next_image.
function next_image_Callback(hObject, eventdata, handles)
% hObject    handle to next_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
filenum = str2num(get(handles.edit_num,'String'));
filenum = min(filenum + 1,length(handles.files));
set(handles.edit_num,'String',int2str(filenum));
imshow(openpiv_imread(handles,filenum));
guidata(hObject, handles);


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
    ['Close ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function pushbutton_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'UserData',1);
guidata(hObject,handles);


% --------------------------------------------------------------------
%

% --------------------------------------------------------------------
function handles = ReadImageDirectory(handles)
firstDif = find(handles.files{2}-handles.files{1},1,'first'); % how the first two files are different?
handles.filebase = handles.files{1}(1:firstDif-1); % base file name, e.g. bird_b00100
fileType = handles.files{1}(firstDif:end-4); % without extension
switch lower(fileType)
    case{'a','_a','b','_b'}
        handles.amount = length(handles.files); % pairs
        handles.filesType = 'pairs';
        handles.step = 2;
        set(handles.edit_jump,'Enable','Off');
        set(handles.edit_jump,'String','-1');
    otherwise
        handles.amount = length(handles.files);
        handles.filesType = 'sequence';
        handles.step = 1;
        set(handles.edit_jump,'Enable','On');
end

% handles.filebase = handles.files{1}(1:max(findstr(handles.files{1},'_'))-1);
guidata(handles.figure1,handles);

% --------------------------------------------------------------------



% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function github_Callback(hObject, eventdata, handles)
% hObject    handle to github (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.openpiv.net/openpiv-matlab/', '-new');


% --------------------------------------------------------------------
function wiki_Callback(hObject, eventdata, handles)
% hObject    handle to wiki (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.openpiv.net/faq.html', '-new');






function edit_dt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dt as text
%        str2double(get(hObject,'String')) returns contents of edit_dt as a double


% --- Executes during object creation, after setting all properties.
function edit_dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% -- Main loop --- %
function openpiv_main_loop(handles, fileind, jump, cropvec,ittWidth,...
    ittHeight,ovlapHor,ovlapVer, prepfun, s2ntype, s2nl, outl, sclt, dt)
% OPENPIV_MAIN_LOOP is the main PIV processing, post-processing and
% plotting subroutines calls

set(handles.edit_num,'string',sprintf('%d',fileind));



[a,~,a1,b1,origin] = read_pair_of_images_rect(handles,fileind,jump,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer);

% a1 = prepfun(a1);
% b1 = prepfun(b1);

[verSize,horSize]= size(a1);

% Prepare the results storage;

rows = 1:ovlapVer:verSize - ittHeight + 1;
cols =  1:ovlapHor:horSize - ittWidth + 1;

numcols = length(rows);
numrows = length(cols);

res = zeros(numcols*numrows,5);
resind = 0;

% a2 = zeros(ittHeight,ittWidth);
% b2 = zeros(ittHeight,ittWidth);
NfftWidth = 2*ittWidth;
NfftHeight = 2*ittHeight;

axes(handles.axes1);
% imshow(imadjust(a),[]);
imshow(a,[]);
hold on
h1 = animatedline('Color','y');
h2 = animatedline('Color','y');

for m = rows % vertically
    for k = cols % horizontally
        % if Stop button pressed:
        if (get(handles.pushbutton_start,'UserData') == 0)
            return;
        end
        
        a2 = a1(m:m+ittHeight-1,k:k+ittWidth-1);
        b2 = b1(m:m+ittHeight-1,k:k+ittWidth-1);
        
        
        c = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth);
        % c = cross_correlate_rect(a2,b2,Nfftx,Nffty);
        if ~any(c(:)), % completely "black"
            u = 0;
            v = 0;
            y = origin(2) + m + ittHeight/2 - 1;
            x = origin(1) + k + ittWidth/2 -  1;
            continue
        end
        
        [peak1,peak2,pixi,pixj] = find_displacement_rect(c,s2ntype);
        
        [peakVer,peakHor,s2n] = sub_pixel_velocity_rect(c,pixi,pixj,peak1,peak2,s2nl,ittWidth,ittHeight);
        
        % Scale the pixel displacement to the velocity
        u = (ittWidth-peakHor);
        v = (ittHeight-peakVer);
        y = origin(2) + m + ittHeight/2-1;
        x = origin(1) + k + ittWidth/2-1;
        
        resind = resind + 1;
        res(resind,:) = [x y u v s2n];
        % quiver(x+cropvec(1),y+cropvec(2),u,v,'y');
        if u ~= 0 || v ~= 0
            plotarrow(h1,h2,x,y,u,v,10);
        end
    end
end

no_filt_res = res;

[res, filt_res] = openpiv_filter(res,numcols,numrows,outl);

% imshow(prepfun(a),[]);
imshow(a,[]);
hold on
clearpoints(h1);
clearpoints(h2);
% for i = 1:length(res)
%     plotarrow(h1,h2,res(i,1),res(i,2),res(i,3),res(i,4));
% end
quiverm(res,'color','g','AutoScaleFactor',2);
ind = (filt_res(:,3) ~= no_filt_res(:,3) | filt_res(:,4) ~= no_filt_res(:,4));
if ~any(ind)
    quiverm(no_filt_res(ind,:),'color','r','AutoScaleFactor',1.25);
end
% for i = 1:length(res)
%     plotarrow(h1,h2,res(i,1),res(i,2),res(i,3),res(i,4));
% end
% drawnow

basename = handles.files{fileind}(1:end-4);
baseext = '.vec';

openpiv_output(res,no_filt_res,filt_res,dt,sclt,numrows, numcols, ...
    handles.path,basename,baseext);

hold off
