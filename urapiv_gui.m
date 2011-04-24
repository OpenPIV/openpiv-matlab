function varargout = urapiv_gui(varargin)
% URAPIV_GUI M-file for urapiv_gui.fig
%      URAPIV_GUI, by itself, creates a new URAPIV_GUI or raises the existing
%      singleton*.
%
%      H = URAPIV_GUI returns the handle to a new URAPIV_GUI or the handle to
%      the existing singleton*.
%
%      URAPIV_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in URAPIV_GUI.M with the given input arguments.
%
%      URAPIV_GUI('Property','Value',...) creates a new URAPIV_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before urapiv_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to urapiv_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help urapiv_gui

% Last Modified by GUIDE v2.5 11-Aug-2009 23:11:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @urapiv_gui_OpeningFcn, ...
    'gui_OutputFcn',  @urapiv_gui_OutputFcn, ...
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

% --- Executes just before urapiv_gui is made visible.
function urapiv_gui_OpeningFcn(hObject, eventdata, handles, varargin)

% handles.lastexperiment = getappdata(handles.figure1,'lastexperiment');
% hObject    handle to pushbutton_getdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% directoryname = uigetdir(handles.dir, 'Pick a Directory');
% if ~isempty(directoryname)
%     handles.dir = directoryname;
% end
% set(handles.edit_dir,'String',handles.dir);


% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to urapiv_gui (see VARARGIN)

% Choose default command line output for urapiv_gui
handles.output = hObject;
movegui(hObject,'center');
set(hObject,'Toolbar','None');
% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using urapiv_gui.
if strcmp(get(hObject,'Visible'),'off')
    load('openpiv_logo.mat');
    imshow(im,'Parent',findobj(hObject,'type','axes')); %handles.axes_main);
    %     text(0.05,.1,'Matlab version of OpenPIV (originally URAPIV)','FontName','Times','Fontsize',20);
    %     text(0.05,.05,'http://www.openpiv.net','FontName','Verdana','Fontsize',16,'Color','blue');
end
axis off

% UIWAIT makes urapiv_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = urapiv_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
    ['Close ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ovlpHor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'comet(cos(1:.01:10))', 'bar(1:10)', 'plot(membrane)', 'surf(peaks)'});

% --- Executes on selection change in popupmenu_ovlpHor.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ovlpHor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_ovlpHor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ovlpHor



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
outl = str2double(get(handles.edit_outl,'string'));

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
            imshow(imadjust(a),[]);
            hold on

            for m = 1:ovlapVer:verSize - ittHeight + 1 % vertically
                for k = 1:ovlapHor:horSize-ittWidth+1 % horizontally
                    if (get(hObject,'UserData') == 1)
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

                        [peakVer,peakHor,s2n] = sub_pixel_velocity_rect(c,pixi,pixj,peak1,peak2,s2nl,sclt,ittWidth,ittHeight);

                        % Scale the pixel displacement to the velocity
                        u = (ittWidth-peakHor)*sclt;
                        v = (ittHeight-peakVer)*sclt;
                        y = origin(2) + m + ittHeight/2-1;
                        x = origin(1) + k + ittWidth/2-1;

                        resind = resind + 1;
                        res(resind,:) = [x y u v s2n];
                        % quiver(x+cropvec(1),y+cropvec(2),u,v,'y');
                        if u ~= 0 || v ~= 0
                            %                             quiver(x,y,u,v,5,'y','Linewidth',1);
                            %                             drawnow;
                            plotarrow(x,y,u,v,'y',10);
                            drawnow
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
            vector(abs(vector)>mean(abs(vector(find(vector))))*outl) = 0;
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

            lmtv = mean(tmpv(find(tmpv))) + 3*std(tmpv(find(tmpv)));
            lmtu = mean(tmpu(find(tmpu))) + 3*std(tmpu(find(tmpu)));
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
            quiverm(res,2,'g','LineWidth',1);
            drawnow
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
            imshow(imadjust(a),[]);
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

                    [peakVer,peakHor,s2n] = sub_pixel_velocity_rect(c,pixi,pixj,peak1,peak2,s2nl,sclt,ittWidth,ittHeight);

                    % Scale the pixel displacement to the velocity
                    u = (ittWidth-peakHor)*sclt;
                    v = (ittHeight-peakVer)*sclt;
                    y = origin(2) + m + ittHeight/2-1;
                    x = origin(1) + k + ittWidth/2-1;

                    resind = resind + 1;
                    res(resind,:) = [x y u v s2n];
                    % quiver(x+cropvec(1),y+cropvec(2),u,v,'y');
                    if u ~= 0 || v ~= 0
                        %                             quiver(x,y,u,v,5,'y','Linewidth',1);
                        %                             drawnow;
                        plotarrow(x,y,u,v,'y',10);
                        % draw_arrow([x,y],[x+u,y+v],20) 
                       drawnow
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
            vector(abs(vector)>mean(abs(vector(find(vector))))*outl) = 0;
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

            lmtv = mean(tmpv(find(tmpv))) + 3*std(tmpv(find(tmpv)));
            lmtu = mean(tmpu(find(tmpu))) + 3*std(tmpu(find(tmpu)));
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
            quiverm(res,2,'g','LineWidth',1);
            drawnow
            %    F(:,fileind) = getframe;
            hold off;
        end
    otherwise
        ;
end
% end
set(handles.figure1,'pointer','arrow')
guidata(handles.figure1,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_ittWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ittWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
contents = get(hObject,'String');
handles.itt = str2double(contents{get(hObject,'Value')});
guidata(hObject,handles);


% --- Executes on selection change in popupmenu_ittWidth.
function popupmenu_ittWidth_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ittWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_ittWidth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ittWidth
contents = get(hObject,'String');
handles.itt = str2double(contents{get(hObject,'Value')});
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.

% --- Executes on selection change in popupmenu_ovlpHor.
function popupmenu_ovlpHor_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ovlpHor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_ovlpHor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ovlpHor
contents = get(hObject,'String');
handles.spc = str2double(contents{get(hObject,'Value')});
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_s2ntype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_s2ntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
contents = get(hObject,'String');%  returns popupmenu_s2ntype contents as cell array
handles.s2ntype = str2double(contents{get(hObject,'Value')});% returns selected item from popupmenu_s2ntype
guidata(hObject,handles);


% --- Executes on selection change in popupmenu_s2ntype.
function popupmenu_s2ntype_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_s2ntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = get(hObject,'String');%  returns popupmenu_s2ntype contents as cell array
handles.s2ntype = str2double(contents{get(hObject,'Value')});% returns selected item from popupmenu_s2ntype
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_s2nl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s2nl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
handles.s2nl = str2double(get(hObject,'String')); % returns contents of edit_s2nl as a double
guidata(hObject,handles);



function edit_s2nl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s2nl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get(hObject,'String');% returns contents of edit_s2nl as text
handles.s2nl = str2double(get(hObject,'String')); % returns contents of edit_s2nl as a double
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
handles.scale = str2double(get(hObject,'String'));% returns contents of edit_scale as a double
guidata(hObject,handles);



function edit_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get(hObject,'String')% Hints:  returns contents of edit_scale as text
handles.scale = str2double(get(hObject,'String'));% returns contents of edit_scale as a double
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_outl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
handles.outl = str2double(get(hObject,'String')); % returns contents of edit_outl as a double
guidata(hObject,handles);



function edit_outl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outl as text
handles.outl = str2double(get(hObject,'String')); % returns contents of edit_outl as a double
guidata(hObject,handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                    EXTERNAL FUNCTIONS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function vector = fill_holes(vector,reslenx,resleny)

% new approach. use inpaint_nans, thanks to John D'Errico
% Aug 11, 2009
% Alex Liberzon (alex.liberzon@gmail.com)
% See also INPAINT_NANS
%

vector(abs(vector)==0) = NaN;
vector = inpaint_nans(real(vector)) + i*inpaint_nans(imag(vector));

% [indx,indy] = find(~abs(vector));
%
% while ~isempty(indx)
%     for z=1:length(indx)
%         k = [max(3,indx(z))-2:min(resleny-2,indx(z))+2];
%         m = [max(3,indy(z))-2:min(reslenx-2,indy(z))+2];
%         try
%             tmpvec = vector(k,m);
%             tmpvec = tmpvec(find(tmpvec));
%             vector(indx(z),indy(z)) = mean(real(tmpvec))+ sqrt(-1)*mean(imag(tmpvec));
%         catch
%             indx = [];
%         end
%         try
%             [indx,indy] = find(~abs(vector));
%         catch
%             indx = [];
%         end
%     end
% end
return


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


% --- Executes during object creation, after setting all properties.
function edit_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num as text
%        str2double(get(hObject,'String')) returns contents of edit_num as a double

function handles = ReadImageDirectoryOld(handles)

handles.amount = length(handles.files);
handles.filebase = handles.files{1}(1:max(findstr(handles.files{1},'_'))-1);
guidata(handles.figure1,handles);

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



% %READIMDIR Reads one after another image pairs (base+cross) and returns
% % as matrices.
% %
% %   [filenames,amount,filebase] = ReadImDir(directory,ext)
% %
% %   inputs:
% %      directory  - Name of the directory, containing set of experiments in pairs of
% %                   images
% %
% %   outputs:
% %      filenames  - Array of the file names, e.g. imp_03_001_b.bmp, imp_03_001_c.bmp, ...
% %      amount     - Number of files, according to the last found file (e.g. im_03_123_b.bmp means
% %                   123 files: .._001 - .._123).
% %      filebase   - Name of the experiment, e.g. im_03_001_b.bmp -> filebase = 'im_03'.
% %
% %
% %   example: [names,num,basis] = ReadImDir('C:\images\test01-01-200','bmp');
% %
% %
% %   Notes: User is responsible to prepare the directory with right number of well named pairs of
% %          files. OSF VidPIV software allowed us to do it session by session.
% %
% %Created: 05-May-1999
% %Authors: Alex Liberzon & Roi Gurka
% %E-mail : liberzon@ihw.baug.ethz.ch
% %Phone  : +41-44-633-3754
% % % Copyright: (C) 1999, Technion - IIT
% %Copyright: (C) 2005, ETH Zurich
%
% % 8 June 2005, no extension input is required. All, TIFF and BMP are readable
% % direc=dir([directory,filesep,'*.bmp']);
% % direc = cat(1,direc,dir([directory,filesep,'*.jpg']))
% % direc = cat(1,direc,dir([directory,filesep,'*.jpeg']))
% % direc = cat(1,direc,dir([directory,filesep,'*.tif']))
% % direc = cat(1,direc,dir([directory,filesep,'*.tiff']))
%
%
% % [gui_files,gui_path] = readImDir;
%
%
%
% % filenames={};
% % [filenames{1:length(direc),1}] = deal(direc(1:end).name);
% % filenames=sortrows(char(filenames{:}));
%
% % amount = max(str2num(filenames(:,end-9:end-4)));
% % modified 30.05.05 to use all kind of names, the only constraint is '_'
% % before the last counter.
% %
% % amount = max(str2num(filenames(:,findstr(filenames(1,:),'_')+1:end-4)));






% --- Executes on selection change in listbox_ext.
function listbox_ext_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_ext contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ext
% contents = get(hObject,'String');
% contents{get(hObject,'Value')};


% --- Executes during object creation, after setting all properties.
function listbox_ext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edit_jump_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jump as text
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

function quiverm(x,varargin)
% QUIVERM - plots quiver plot of matrix,
% assuming first column as X, second as Y
% third as U, and forth as V.
%
% QUIVERM(A,'r') - plots quiver plot
% of matrix A.
% Used by QUIVERTXT function.
%
%
%
% Author: Alex Liberzon
% Modified at 23.06.05, to show only 'normal' vectors,
% without outliers.
% on IHW_Video

if isstr(x)
    x = eval(x);
end

x(abs(x(:,3)) > prctile(abs(x(:,3)),90),3) = NaN;
x(abs(x(:,4)) > prctile(abs(x(:,4)),90),4) = NaN;
quiver(x(:,1),x(:,2),x(:,3),x(:,4),varargin{1:end});

% quiver(x(:,1),x(:,2),x(:,3),x(:,4),varargin{:});
return


% --- Executes on button press in prev_image.
function prev_image_Callback(hObject, eventdata, handles)
% hObject    handle to prev_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1)
filenum = str2num(get(handles.edit_num,'String'));
filenum = max(1,filenum - 1);
set(handles.edit_num,'String',int2str(filenum));
% imshow(fullfile(handles.path,handles.files{1}));
tmp = imread(fullfile(handles.path,handles.files{filenum}));
if length(size(tmp)) == 3
    tmp = rgb2gray(tmp);
end
imshow(imadjust(tmp));
guidata(hObject, handles);


% --- Executes on button press in image_next.
function image_next_Callback(hObject, eventdata, handles)
% hObject    handle to image_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
filenum = str2num(get(handles.edit_num,'String'));
filenum = min(filenum + 1,length(handles.files));
set(handles.edit_num,'String',int2str(filenum));
% imshow(fullfile(handles.path,handles.files{1}));
tmp = imread(fullfile(handles.path,handles.files{filenum}));
if length(size(tmp)) == 3
    tmp = rgb2gray(tmp);
end
imshow(imadjust(tmp));
guidata(hObject, handles);






% --- Executes during object creation, after setting all properties.
function pushbutton_getdir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_getdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




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
contents = get(hObject,'String');
handles.spc = str2double(contents{get(hObject,'Value')});
guidata(hObject,handles);




% --- Executes during object creation, after setting all properties.
function pushbutton_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'UserData',1);
guidata(hObject,handles);




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
try
    % imshow(fullfile(handles.path,handles.files{1}));
    tmp = imread(fullfile(handles.path,handles.files{1}));
    if length(size(tmp)) == 3
        tmp = rgb2gray(tmp);
    end
    imshow(imadjust(tmp));
catch
    tmp = tiffread2(fullfile(handles.path,handles.files{1}));
    imshow(imadjust(im2double(tmp.data)));
end
set(handles.prev_image,'Visible','On');
set(handles.image_next,'Visible','On');
handles = ReadImageDirectory(handles);
% set(handles.edit_num,'string',sprintf('%d/%d',1,handles.amount));
guidata(handles.figure1, handles);


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)







% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://sourceforge.net/apps/trac/openpiv/wiki', '-new');




% --- Executes on selection change in popupmenu_ittHeight.
function popupmenu_ittHeight_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ittHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_ittHeight contents as cell array
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

% Hints: contents = get(hObject,'String') returns popupmenu_ovlpVer contents as cell array
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


function [A,B,A1,B1,origin] = read_pair_of_images_rect(image1,image2,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer)
% READ_PAIR_OF_IMAGES - reads two images (image1,image2) as BMP files
% and crops them according to 'cropvec'
% Inputs:
%         image1,image2 - BMP file names (string)
%         cropvec - 4 x 1 vector of follwoing values:
%         [left,top,right,bottom] - each value is a number of lines
%                                   of interrogation areas (ittWidthITT pixels)
%                                   which should be removed before the analysis.
%         itt - interrogation area size in pixels
%         spc - grid spacing (overlapping) size in pixels
%
% Authors: Alex Liberzon & Roi Gurka
% Date: 20-Jul-99
% Last modified:
% Copyright(c) 1999, Alex Liberzon

% A = double(imread(image1,'bmp'))/255;
% B = double(imread(image2,'bmp'))/255;
origin = [0,0];

try
    A = imread(image1); % ,'tif'); 8 June 2005, no extension is necessary
    B = imread(image2); % ,'tif'); % more flexibility for different image formats
catch
    warning off
    tmp = tiffread2(image1);
    A = im2double(tmp.data);
    tmp = tiffread2(image2);
    B = im2double(tmp.data);
end
if ndims(A) == 3
    A = rgb2gray(A);
    B = rgb2gray(B);
elseif ndims(A) == 2
    A = double(A)/255;
    B = double(B)/255;
end



% Crop the images to the desired size and
% cut the last couple of pixels, so we'll get the
% integer number of interrogation areas
%
%       ---- t ---
%      |          |
%      |          |
%      l          r
%      |          |
%      |          |
%       --- b ----
%
%

[verSizeA,horSizeA] = size(A);
[verSizeB,horSizeB]=size(B);
% A & B matrices HAVE to be of the same size, we take smallest:
verSize = min(verSizeA,verSizeB); horSize = min(horSizeA,horSizeB);
if any(cropvec)
    %     A = imcrop(A,cropvec);
    %     B = imcrop(B,cropvec);
    top = max([0,round(cropvec(2)/ittHeight)]); % top side of the image
    left = max([0,round(cropvec(1)/ittWidth)]); % left side of the image
    bottom = max([0,floor((verSize - cropvec(2) - cropvec(4))/ittHeight)]); % bottom side of the image
    right = max([0,floor((horSize - cropvec(1) - cropvec(3))/ittWidth)]); % right of the image

    A1 = A(1 + top*ittHeight:ovlapVer*floor(verSize/ovlapVer) - bottom*ittHeight,...
        1+left*ittWidth:ovlapHor*floor(horSize/ovlapHor) - right*ittWidth);
    B1 = B(1 + top*ittHeight:ovlapVer*floor(verSize/ovlapVer) - bottom*ittHeight, ...
        1+left*ittWidth:ovlapHor*floor(horSize/ovlapHor) - right*ittWidth);
else
    A1 = A;
    B1 = B;
    left = 0;
    top = 0;
end

% [rows,cols]=size(A);

if min(size(A1)) < 1
    error('Zero image');
end
origin = [left*ittWidth,top*ittHeight];

return


function [c] = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth)

% temprorary solution
disp('fix it')
a2 = a2 - mean2(a2);
b2 = b2 - mean2(b2);
a2(a2<0) = 0;
b2(b2<0) = 0;

b2 = b2(end:-1:1,end:-1:1);

ffta=fft2(single(a2),NfftHeight,NfftWidth);
fftb=fft2(single(b2),NfftHeight,NfftWidth);
c = real(ifft2(ffta.*fftb));
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [peakx,peaky,s2n] = sub_pixel_velocity_rect(c,pixi,pixj,peak1,peak2,s2nl,sclt,ittWidth,ittHeight)
% SUB_PIXEL_VELOCITY - Calculates Signal-To-Noise Ratio, fits Gaussian
% bell, find sub-pixel displacement and scales it to the real velocity
% according the the time interval and real-world-to-image-scale.
%
% Authors: Alex Liberzon & Roi Gurka
% Date: Jul-20-99
% Last Modified:

% If peak2 equals to zero, it means that nothing was found,
% and we'll divide by zero:
if ~peak2
    s2n = Inf;		% Just to protect from zero dividing.
else
    s2n = peak1/peak2;
end

if any(c(:)<0), keyboard, end

% If Signal-To-Noise ratio is lower than the limit, "mark" it:
if s2n < s2nl
    peakx = ittHeight;
    peaky = ittWidth;
else            % otherwise, calculate the velocity

    % Sub-pixel displacement definition by means of
    % Gaussian bell.

    if pixi < 2 || pixi > size(c,1) - 2 || pixj < 2 || pixj > size(c,2) - 2
        peakx = ittHeight;
        peaky = ittWidth;
        return
    end

    try
        f0 = log(c(pixi,pixj));
        f1 = log(c(pixi-1,pixj));
        f2 = log(c(pixi+1,pixj));
        peakx = pixi + (f1-f2)/(2*f1-4*f0+2*f2);
        f0 = log(c(pixi,pixj));
        f1 = log(c(pixi,pixj-1));
        f2 = log(c(pixi,pixj+1));
        peaky = pixj+ (f1-f2)/(2*f1-4*f0+2*f2);
    catch
        peakx = ittHeight;
        peaky = ittWidth;
    end

    if ~isreal(peakx) || ~isreal(peaky)
        peakx = ittHeight;
        peaky = ittWidth;
    end

end


return


function [peak1,peak2,pixi,pixj] = find_displacement_rect(c,s2ntype)
% FIND_DISPLACEMENT - Finds the highest peak in cross-correlation
% matrix and the second peak (or mean value) for signal-to-noise
% ratio calculation.
% Inputs:
%         c - cross-correlation matrix
%         s2ntype - method (1 or 2) of S2N ratio calculation
% Outputs:
%         peak1 = highest peak
%         peak2 = second highest peak (or mean value)
%         pixi,pixj = row,column indeces of the peak1
%
% Authors: Alex Liberzon & Roi Gurka
% Date: 20-Jul-99
% Last modified:
%

% Find your majour peak = mean pixel displacement between
% two interrogation areas:

[NfftHeight,NfftWidth] = size(c);

[tmp,tmpi] = max(c);
[peak1, pixj] = max(tmp);
pixi = tmpi(pixj);


% Temproraly matrix without the maximum peak:
tmp = c;
tmp(pixi,pixj) = 0;
% If the peak is found on the border, we should not accept it:
if pixi==1 || pixj==1 || pixi == NfftHeight || pixj == NfftWidth
    peak2 = peak1; % we'll not accept this peak later, by means of SNR
else
    % Look for the Signal-To-Noise ratio by
    % 1. Peak detectability method: First-to-second peak ratio
    % 2. Peak-to-mean ratio - Signal-to-noise estimation

    if s2ntype == 1		% First-to-second peak ratio
        % Remove 3x3 pixels neighbourhood around the peak
        tmp(pixi-1:pixi+1,pixj-1:pixj+1) = NaN;
        % Look for the second highest peak
        peak2 = max(tmp(:));
        [x2,y2] = find(tmp==peak2);
        tmp(x2,y2) = NaN;
        % Only if second peak is within the borders
        if x2 > 1 && y2 > 1 && x2 < NfftHeight && y2 < NfftWidth

            % Look for the clear (global) peak, not for a local maximum:
            while peak2 < max(max(c(x2-1:x2+1,y2-1:y2+1)))
                peak2 = max(tmp(:));
                [x2,y2] = find(tmp==peak2);
                if x2 == 1 || y2==1 || x2 == NfftHeight || y2 == NfftWidth
                    peak2 = peak1;	% will throw this one out later
                    break;
                end
                tmp(x2,y2) = NaN;
            end		% end of while
        else			% second peak on the border means "second peak doesn't exist"
            peak2 = peak1;
        end    % if x2 >1 ......end
        % PEAK-TO-MEAN VALUE RATIO:
    elseif s2ntype == 2
        peak2 = mean2(abs(tmp));
    end		% end of second peak search, both methods.
end				% end of if highest peak on the border
return

% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection = questdlg(['Exit ' get(handles.figure1,'Name') '?'],...
    ['Exit ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
elseif strcmp(selection,'Yes')
    delete(handles.figure1);
end

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


function plotarrow(x,y,u,v,color,scale)

alpha = 0.33; % Size of arrow head relative to the length of the vector
beta = 0.33;  % Width of the base of the arrow head relative to the length

u = u*scale;
v = v*scale;
uu = [x;x+u;NaN];
vv = [y;y+v;NaN];
h1 = plot(uu(:),vv(:),'Color',color,'EraseMode','none');
hu = [x+u-alpha*(u+beta*(v+eps));x+u; ...
    x+u-alpha*(u-beta*(v+eps));NaN];
hv = [y+v-alpha*(v-beta*(u+eps));y+v; ...
    y+v-alpha*(v+beta*(u+eps));NaN];
h2 = plot(hu(:),hv(:),'Color',color,'EraseMode','none');
