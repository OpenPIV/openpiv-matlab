function varargout = readImDir(varargin)



gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @readImDir_OpeningFcn, ...
    'gui_OutputFcn',  @readImDir_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})%#ok<AND2>
    %     str2func(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% --- Executes just before readImDir is made visible.
function readImDir_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to readImDir (see VARARGIN)

% Choose default command line output for readImDir

handles = guihandles;
handles.output = hObject;

if exist('lastpath.mat','file')
    load('lastpath.mat');
    if exist('lastpath','var') && exist(lastpath,'dir')
        handles.path = lastpath;
    else
        handles.path = pwd;
    end
else
    handles.path = pwd;
end

handles.state3d = 0;

% Update handles structure
guidata(hObject, handles);
update_gui(hObject,[],handles);
% %
% % % UIWAIT makes readImDir wait for user response (see %uiresume)
uiwait(handles.fig);


% --- Outputs from this function are returned to the command line.
function varargout = readImDir_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% if nargout
if isfield(handles,'filenames')
    varargout{1} = handles.filenames;
    varargout{2} = handles.path;
    %     varargout{3} = handles.dT*handles.step;
    %     varargout{4} = handles.scale;
    %     varargout{5} = handles.state3d;
    
else
    varargout{1} = {};
    varargout{2} = {};
end
close(handles.fig);


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Returns the names of the selected files
handles.list_entries = get(handles.listbox_files,'String');
handles.index_selected = get(handles.listbox_files,'Value');
% jump = int32(str2num(get(handles.jump,'String')));
jump = 1;
if isempty(handles.index_selected) | min(handles.index_selected) < 3
    errordlg('Wrong selection','Incorrect Selection','modal')
else
    
    switch length(handles.index_selected)
        case {1}                        % only the first file is selected,
            index = handles.index_selected;
            handles.filenames = handles.list_entries(index(1:jump:end));
        case {2}
            index = handles.index_selected; %
            handles.filenames = handles.list_entries(index(1:jump:end));
            
        otherwise
            handles.filenames = handles.list_entries(handles.index_selected(1:jump:end));
            
    end
    
    try
        lastpath = handles.path;
        
        save('lastpath.mat','lastpath');
    catch
        ;
    end
    
    guidata(hObject,handles);
    uiresume(handles.fig);
end




% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.fig);


% --- Executes during object creation, after setting all properties.
function listbox_files_CreateFcn(hObject, eventdata, handles)


% --- Executes on selection change in listbox_files.
function listbox_files_Callback(hObject, eventdata, handles)

if strcmp(get(handles.fig,'SelectionType'),'open') % If double click
    index_selected = get(handles.listbox_files,'Value');
    file_list = get(handles.listbox_files,'String');
    filename = file_list{index_selected};       % Item selected in list box
    %     keyboard
    if  isdir([handles.path,filesep,filename]) % If directory
        if index_selected == 2
            handles.path = handles.path(1:max(findstr(handles.path,filesep)-1));
        elseif index_selected > 2
            handles.path = [handles.path,filesep,filename];
        end
        guidata(handles.fig,handles);
        update_gui(handles.fig,[],handles);
    end
end




% --- Executes during object creation, after setting all properties.
function edit_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
handles = guihandles;
if ~isfield(handles,'path')
    handles.path = cd;
end
set(hObject,'String',handles.path);
guidata(hObject,handles);



function edit_path_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path as text
%        str2double(get(hObject,'String')) returns contents of edit_path as a double

tmp = get(hObject,'String');
if isdir(tmp)
    handles.path = tmp;
else
    set(hObject,'String',handles.path);
end
guidata(hObject,handles);
update_gui(hObject, [], handles);

% --- Executes on button press in pushbutton_cd.
function pushbutton_cd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmp = uigetdir(handles.path);
if tmp > 0 & isdir(tmp), handles.path = tmp; end
set(handles.edit_path,'String',handles.path);
guidata(hObject, handles);
update_gui(hObject, [], handles);


function edit_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO) eventdata  reserved - to be
% defined in a future version of MATLAB handles    structure with handles
% and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_scale
%        as a double
if isnan(str2double(get(hObject,'String')))
    set(hObject,'String','1');
end
handles.scale = str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function fig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles = guihandles(hObject);
movegui(hObject,'northwest')


% --- Executes on button press in pushbutton_updir.
function pushbutton_updir_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_updir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

s = handles.path;
s = s(1:max(3,max(findstr(s,filesep))-1));
if exist(s,'dir')
    handles.path = s;
end
guidata(hObject,handles);
update_gui(hObject,[],handles);

function update_gui(hObject, eventdata, handles)
% Self made UPDATE GUI function
image_files = {'jpg','bmp','jpeg','tif','tiff','png'};
if ~isdir(handles.path)
    handles.path = cd;
end

set(handles.edit_path,'String',handles.path);
list = dir(handles.path);
handles.files = {};
for i = 1:length(list)
    if ismember(lower(getext(list(i).name)),image_files)
        handles.files = cat(1,handles.files,list(i).name);
    end
end
%     handles.files = dir(fullfile(handles.path,'*.bmp'));
%     handles.files = cat(1,handles.files,dir(fullfile(handles.path,'*.jpg')));
%     handles.files = cat(1,handles.files,dir(fullfile(handles.path,'*.jpeg')));
%     handles.files = cat(1,handles.files,dir(fullfile(handles.path,'*.tif')));
%     handles.files = cat(1,handles.files,dir(fullfile(handles.path,'*.tiff')));
%     handles.files = cat(1,handles.files,dir(fullfile(handles.path,'*.png')));

% list = dir(handles.path);
ind = find(cat(1,list.isdir));
set(handles.fig,'SelectionType','normal');
set(handles.listbox_files,'String',{list(ind).name,handles.files{:}},'Value',1);
guidata(handles.fig, handles);




function jump_Callback(hObject, eventdata, handles)
% hObject    handle to jump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jump as text
%        str2double(get(hObject,'String')) returns contents of jump as a double


% --- Executes during object creation, after setting all properties.
function jump_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


