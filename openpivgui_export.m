function varargout = openpivgui_export(varargin)
% OPENPIVGUI_EXPORT M-file for openpivgui_export.fig
%      OPENPIVGUI_EXPORT, by itself, creates a new OPENPIVGUI_EXPORT or raises the existing
%      singleton*.
%
%      H = OPENPIVGUI_EXPORT returns the handle to a new OPENPIVGUI_EXPORT or the handle to
%      the existing singleton*.
%
%      OPENPIVGUI_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPENPIVGUI_EXPORT.M with the given input arguments.
%
%      OPENPIVGUI_EXPORT('Property','Value',...) creates a new OPENPIVGUI_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before openpivgui_export_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to openpivgui_export_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help openpivgui_export

% Last Modified by GUIDE v2.5 29-May-2015 14:52:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @openpivgui_export_OpeningFcn, ...
    'gui_OutputFcn',  @openpivgui_export_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before openpivgui_export is made visible.
function openpivgui_export_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to openpivgui_export (see VARARGIN)

% Choose default command line output for openpivgui_export
handles.output = hObject;
movegui(hObject,'center');
set(hObject,'Toolbar','None');
% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using openpiv_gui.
if strcmp(get(hObject,'Visible'),'off')
    im = load('openpiv_logo.mat');
    imshow(im.im,'Parent',findobj(hObject,'type','axes')); %handles.axes_main);
    %     text(0.05,.1,'Matlab version of OpenPIV (originally URAPIV)','FontName','Times','Fontsize',20);
    %     text(0.05,.05,'http://www.openpiv.net','FontName','Verdana','Fontsize',16,'Color','blue');
end
axis off

% UIWAIT makes openpiv_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = openpivgui_export_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.files,handles.path] = readImDir;
% set(handles.edit_dir,'String',handles.path);
axes(handles.axes1);
set(handles.axes1,'visible','off');
set(handles.axes1,'Units','pixels');

% preprocess = get(handles.checkbox_preprocess,'Value');
% if preprocess
%     prepfun = str2func(handles.preprocess);
% else
%     prepfun = inline('imadjust(x)');
% end
% 
% try
%     % imshow(fullfile(handles.path,handles.files{1}));
%     tmp = imread(fullfile(handles.path,handles.files{1}));
%     if length(size(tmp)) == 3
%         tmp = rgb2gray(tmp);
%     end
%     imshow(prepfun(tmp));
% catch
%     tmp = tiffread2(fullfile(handles.path,handles.files{1}));
%     tmp = im2double(tmp.data);
%     imshow(prepfun(tmp));
% end

im = openpiv_imread(handles,1);
imshow(im);
set(handles.prev_image,'Visible','On');
set(handles.next_image,'Visible','On');
handles = ReadImageDirectory(handles);
% set(handles.edit_num,'string',sprintf('%d/%d',1,handles.amount));
guidata(handles.figure1, handles);


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_start,'UserData',1);

contents = get(handles.popupmenu_ittWidth,'String');
ittWidth = str2double(contents{get(handles.popupmenu_ittWidth,'Value')});

contents = get(handles.popupmenu_ittHeight,'String');
ittHeight = str2double(contents{get(handles.popupmenu_ittHeight,'Value')});

contents = get(handles.popupmenu_ovlpHor,'String');
ovlapHor = str2double(contents{get(handles.popupmenu_ovlpHor,'Value')});

contents = get(handles.popupmenu_ovlpVer,'String');
ovlapVer = str2double(contents{get(handles.popupmenu_ovlpVer,'Value')});

s2ntype = get(handles.popupmenu_s2ntype,'value');
s2nl = str2double(get(handles.edit_s2nl,'string'));
sclt = str2double(get(handles.edit_scale,'string'));
dt = str2double(get(handles.edit_dt,'string'));
outl = str2double(get(handles.edit_outl,'string'));

preprocess = get(handles.checkbox_preprocess,'Value');
if preprocess
    if ~isfield(handles,'preprocess')
        prepfun = inline('x');
    else
        prepfun = str2func(handles.preprocess);
    end
else
    prepfun = inline('x');
end

if isfield(handles,'rect') && ~isempty(handles.rect)
    cropvec = handles.rect;
else
    cropvec = [0 0 0 0];
end
jump = str2double(get(handles.edit_jump,'string'));
if jump == -1
    jump = 0;
end

% Main loop
set(handles.figure1,'pointer','watch')


image1 = fullfile(handles.path,handles.files{1});
image2 = fullfile(handles.path,handles.files{2});
[a,b,a1,b1] = read_pair_of_images_rect(image1,image2,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer);
if isempty(a) || isempty(b)
    errordlg('Something wrong with your images')
end

switch handles.filesType
    case{'sequence'}
        
        for fileind = 1:handles.amount-jump	% main loop, for whole file list
            %      while (get(handles.pushbutton_start,'UserData') ==1)
            
            %             set(handles.edit_num,'string',sprintf('%d/%d',fileind,handles.amount-jump));
            set(handles.edit_num,'string',sprintf('%d',fileind));
            
            image1 = fullfile(handles.path,handles.files{fileind});
            image2 = fullfile(handles.path,handles.files{fileind+jump});
            
            [a,b,a1,b1,origin] = read_pair_of_images_rect(image1,image2,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer);
            
            a1 = prepfun(a1);
            b1 = prepfun(b1);
            
            
            [verSize,horSize]= size(a1);
            
            % Prepare the results storage;
            numcols = floor((horSize-ittWidth)/ovlapHor+1);
            numrows = floor((verSize-ittHeight)/ovlapVer+1);
            res = zeros(numcols*numrows,5);
            resind = 0;
            
            a2 = zeros(ittHeight,ittWidth);
            b2 = zeros(ittHeight,ittWidth);
            NfftWidth = 2*ittWidth;
            NfftHeight = 2*ittHeight;
            
            %%%%%% Start the loop for each interrogation block %%%%%%%
            axes(handles.axes1);
            % imshow(imadjust(a),[]);
            imshow(prepfun(a),[]);
            hold on
                        
            for m = 1:ovlapVer:verSize - ittHeight + 1 % vertically
                for k = 1:ovlapHor:horSize-ittWidth+1 % horizontally
                    if (get(hObject,'UserData') == 1)
                        a2 = a1(m:m+ittHeight-1,k:k+ittWidth-1);
                        b2 = b1(m:m+ittHeight-1,k:k+ittWidth-1);
                        
                        %                         a2 = prepfun(a2);
                        %                         b2 = prepfun(b2);
                        
                        c = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth);
                        % c = cross_correlate_rect(a2,b2,Nfftx,Nffty);
                        if ~any(c(:)), % completely "black"
                            u = 0;
                            v = 0;
                            y = origin(2) + m + ittHeight/2 - 1;
                            x = origin(1) + k + ittWidth/2 -  1;
                            resind = resind + 1;
                            s2n = 0; 
                            res(resind,:) = [x y u v s2n];
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
                            %                             quiver(x,y,u,v,5,'y','Linewidth',1);
                            %                             drawnow;
                            plotarrow(x,y,u,v,'g',10);
                            % drawnow
                        end
                    end
                end
            end
            
            
            
            % NO_FILT_RES will be stored in '.._noflt.txt' file at the end of program
            no_filt_res = res;
            
            
            
            % Reshape U and V matrices in two-dimensional grid and produce
            % velocity vector in U + i*V form (real and imaginary parts):
            
            u = reshape(res(:,3), numrows,numcols);
            v = reshape(res(:,4), numrows,numcols);
            vector = u + sqrt(-1)*v;
            
            % Remove outlayers - GLOBAL FILTERING
            vector(abs(vector)>mean(abs(vector(vector~=0)))*outl) = 0;
            u = real(vector);
            v = imag(vector);
            
            % Adaptive Local Median filtering
            
            kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
            tmpv = abs(conv2(v,kernel,'same'));
            tmpu = abs(conv2(u,kernel,'same'));
            
            % WE HAVE TO DECIDE WHICH LIMIT TO USE:
            % 1. Mean + 3*STD for each one separately OR
            % 2. For velocity vector length (and angle)
            % 3. OR OTHER.
            
            lmtv = mean(tmpv(tmpv~=0)) + 3*std(tmpv(tmpv~=0));
            lmtu = mean(tmpu(tmpu~=0)) + 3*std(tmpu(tmpu~=0));
            
            u_out = find(tmpu>lmtu);
            v_out = find(tmpv>lmtv);
            
            % Let's throw the outlayers out:
            u(u_out) = 0; u(v_out) = 0;
            v(v_out) = 0; v(u_out) = 0;
            vector = u + sqrt(-1)*v;
            
            res(:,3) = reshape(real(vector),numrows*numcols,1);
            res(:,4) = reshape(imag(vector),numrows*numcols,1);
            
            % Filtered results will be stored in '.._flt.txt' file
            filt_res = res;
            
            vector = fill_holes(vector,numrows,numcols);
            res(:,3) = reshape(real(vector),numrows*numcols,1);
            res(:,4) = reshape(imag(vector),numrows*numcols,1);
            
            
            % scale the pixels and apply the dt
            
            if sclt ~= 1
                res = res * sclt; % pixels to meters
                no_filt_res = no_filt_res * sclt;
                filt_res = filt_res * sclt;
                xUnits = 'm';
                uUnits = 'm/dt';
            end
            
            if dt ~= 0
                res(:,3:4) = res(:,3:4)/dt;
                no_filt_res(:,3:4) = no_filt_res(:,3:4)/dt;
                filt_res(:,3:4) = filt_res(:,3:4) /dt;
                uUnits = 'm/s';
            end
                
            
            % Save results as ASCII (text) files:
            % Final (filtered, interpolated) results
            % fid = fopen([dirname,filesep,filenames(fileind,1:end-4),'.txt'],'w');
            
            basename = handles.files{fileind}(1:end-4);
            
            final = fullfile(handles.path,[basename,'.txt']);
            write_openpiv_txt(final,res);
            
            % Unfiltered, uninterpolated: (comment with % sign if you don't need it)
            nofilt = fullfile(handles.path,[basename,'_noflt.txt']);
            write_openpiv_txt(nofilt,no_filt_res);
            

            % Filtered, but not interpolated:
            filtered = fullfile(handles.path,[basename,'_flt.txt']);
            write_openpiv_txt(filtered,filt_res); 
            
            
            % Results visualization
            % Only for final, filtered and interpolated data
            %    imshow(a,[]);
            %    hold on
            %             quiverm(res,2,'g','LineWidth',1);
            %             drawnow
            %    F(:,fileind) = getframe;
            hold off;
        end
    case{'pairs'}
        for fileind = 1:2:handles.amount	% main loop, for whole file list
            %      while (get(handles.pushbutton_start,'UserData') ==1)
            
            %             set(handles.edit_num,'string',sprintf('%d/%d',fileind,handles.amount));
            set(handles.edit_num,'string',sprintf('%d',fileind));
            
            image1 = fullfile(handles.path,handles.files{fileind});
            image2 = fullfile(handles.path,handles.files{fileind+1});
            
            [a,b,a1,b1,origin] = read_pair_of_images_rect(image1,image2,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer);
            
            a1 = prepfun(a1);
            b1 = prepfun(b1);
            
            [verSize,horSize]= size(a1);
            
            % Prepare the results storage;
            numcols = floor((horSize-ittWidth)/ovlapHor+1);
            numrows = floor((verSize-ittHeight)/ovlapVer+1);
            res = zeros(numcols*numrows,5);
            resind = 0;
            
            a2 = zeros(ittHeight,ittWidth);
            b2 = zeros(ittHeight,ittWidth);
            NfftWidth = 2*ittWidth;
            NfftHeight = 2*ittHeight;
            
            axes(handles.axes1);
            % imshow(imadjust(a),[]);
            imshow(prepfun(a),[]);
            hold on
            
            for m = 1:ovlapVer:verSize - ittHeight + 1 % vertically
                for k = 1:ovlapHor:horSize-ittWidth+1 % horizontally
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
                        y = origin(1) + m + ittHeight/2 - 1;
                        x = origin(2) + k + ittWidth/2 -  1;
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
                        %                             quiver(x,y,u,v,5,'y','Linewidth',1);
                        %                             drawnow;
                        plotarrow(x,y,u,v,'g',10);
                        % draw_arrow([x,y],[x+u,y+v],20)
                        % drawnow
                    end
                end
            end
            
            
            
            % NO_FILT_RES will be stored in '.._noflt.txt' file at the end of program
            no_filt_res = res;
            
            % Reshape U and V matrices in two-dimensional grid and produce
            % velocity vector in U + i*V form (real and imaginary parts):
            
            u = reshape(res(:,3), numrows,numcols);
            v = reshape(res(:,4), numrows,numcols);
            vector = u + sqrt(-1)*v;
            
            % Remove outlayers - GLOBAL FILTERING
            ind = isfinite(abs(vector)) & abs(vector) ~= 0;
            limit = mean(abs(vector(ind)))*outl;
            outliers = abs(vector) > limit;
            vector(outliers) = 0;
            u = real(vector);
            v = imag(vector);
            
            % Adaptive Local Median filtering
            kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
            tmpv = abs(conv2(v,kernel,'same'));
            tmpu = abs(conv2(u,kernel,'same'));
            
            % WE HAVE TO DECIDE WHICH LIMIT TO USE:
            % 1. Mean + 3*STD for each one separately OR
            % 2. For velocity vector length (and angle)
            % 3. OR OTHER.
            ind = isfinite(abs(tmpv)) & abs(tmpv) ~= 0;
            lmtv = mean(tmpv(ind)) + 3*std(tmpv(ind));
            
            ind = isfinite(abs(tmpu)) & abs(tmpu) ~= 0;
            lmtu = mean(tmpu(ind)) + 3*std(tmpu(ind));
            
            u_out = find(tmpu>lmtu);
            v_out = find(tmpv>lmtv);
            
            % Let's throw the outlayers out:
            u(u_out) = 0; u(v_out) = 0;
            v(v_out) = 0; v(u_out) = 0;
            vector = u + sqrt(-1)*v;
            
            res(:,3) = reshape(real(vector),numrows*numcols,1);
            res(:,4) = reshape(imag(vector),numrows*numcols,1);
            
            % Filtered results will be stored in '.._flt.txt' file
            filt_res = res;
            
            vector = fill_holes(vector,numrows,numcols);
            res(:,3) = reshape(real(vector),numrows*numcols,1);
            res(:,4) = reshape(imag(vector),numrows*numcols,1);
            
            
            % Save results as ASCII (text) files:
            % Final (filtered, interpolated) results
            % fid = fopen([dirname,filesep,filenames(fileind,1:end-4),'.txt'],'w');
            
            fid = fopen(fullfile(handles.path,[handles.files{fileind}(1:end-4),'.txt']),'w');
            fprintf(fid,'%3d %3d %7.4f %7.4f %7.4f\n',res');
            fclose(fid);
            % Unfiltered, uninterpolated: (comment with % sign if you don't need it)
            % fid = fopen([dirname,filesep,filenames(fileind,1:end-4),'_noflt.txt'],'w');
            fid = fopen(fullfile(handles.path,[handles.files{fileind}(1:end-4),'_noflt.txt']),'w');
            fprintf(fid,'%3d %3d %7.4f %7.4f %7.4f\n',no_filt_res');
            fclose(fid);
            % Filtered, but not interpolated:
            % fid = fopen([dirname,filesep,filenames(fileind,1:end-4),'_flt.txt'],'w');
            fid = fopen(fullfile(handles.path,[handles.files{fileind}(1:end-4),'_flt.txt']),'w');
            fprintf(fid,'%3d %3d %7.4f %7.4f %7.4f\n',filt_res');
            fclose(fid);
            
            
            % Results visualization
            % Only for final, filtered and interpolated data
            %    imshow(a,[]);
            %    hold on
            %             quiverm(res,2,'g','LineWidth',1);
            %             drawnow
            %    F(:,fileind) = getframe;
            hold off;
        end
    otherwise
        ;
end
% end
set(handles.figure1,'pointer','arrow')
guidata(handles.figure1,handles);


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


function im = openpiv_imread(handles,filenum)
% openpiv_imread encapsulates all the image reading functions
% that can be imread for 'jpg','bmp', etc. or 'tiffread2' for TIFF
% images from Insight (tm) 
% Usage:
% >>  im = openpiv_imread(handles,file_number);
% >>  imshow(im);

try 
    im = imread(fullfile(handles.path,handles.files{filenum}));
catch
    tmp = tiffread2(fullfile(handles.path,handles.files{filenum}));
    im = im2double(tmp.data);
end

if length(size(im)) == 3
    im = rgb2gray(im);
end

% Custom pre-processing of images, default = 'imadjust'
preprocess = get(handles.checkbox_preprocess,'Value');
if preprocess
    prepfun = str2func(handles.preprocess);
else
    prepfun = inline('imadjust(x)'); % default is to stretch the image
end
im = prepfun(im);



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
