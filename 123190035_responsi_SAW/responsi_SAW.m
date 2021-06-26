function varargout = responsi_SAW(varargin)
% RESPONSI_SAW MATLAB code for responsi_SAW.fig
%      RESPONSI_SAW, by itself, creates a new RESPONSI_SAW or raises the existing
%      singleton*.
%
%      H = RESPONSI_SAW returns the handle to a new RESPONSI_SAW or the handle to
%      the existing singleton*.
%
%      RESPONSI_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_SAW.M with the given input arguments.
%
%      RESPONSI_SAW('Property','Value',...) creates a new RESPONSI_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before responsi_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to responsi_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help responsi_SAW

% Last Modified by GUIDE v2.5 26-Jun-2021 13:20:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @responsi_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @responsi_SAW_OutputFcn, ...
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


% --- Executes just before responsi_SAW is made visible.
function responsi_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to responsi_SAW (see VARARGIN)

% Choose default command line output for responsi_SAW
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes responsi_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = responsi_SAW_OutputFcn(hObject, eventdata, handles) 
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

[filename, pathname]= uigetfile({'*.xlsx';},'openData'); %menggunakan fungsi uigetfile untuk mengambil file 
fullpathname = strcat(pathname, filename);
data1=xlsread(filename,'Sheet1','A:G');%membaca file halaman 1 kolom A smapi G
set(handles.uitable1,'Data',data1);%simpan/set data pada uitable1 - matriks data

x=xlsread(filename,'Sheet1','B:G'); %Membaca file hal1 komol B samapi G
k=[0,1,1,1,1,1]; %pengaturan atribut
w=[0.30,0.2,0.23,0.1,0.07,0.1]; %pengaturan bobot

[m n]=size (x);
R=zeros (m,n);
Y=zeros (m,n);
for j=1:n,
 if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
  R(:,j)=x(:,j)./max(x(:,j));
 else
  R(:,j)=min(x(:,j))./x(:,j); %Cost
 end;
end;

for i=1:m,
 V(i)= sum(w.*R(i,:));
end;

Y=reshape(1:1001,1001,1).';
hasill=[Y;V]; %menggabungkan matriks
hasilll=hasill'; %Transpose matriks
hasil=sortrows(hasilll,2, 'descend'); %sorting matriks berdasarkan pada nilai V
lasthasil=hasil(1:20,:); %rank 20 nilai paling atas
set(handles.uitable2,'Data',lasthasil); %simpan data pada tabel uitable2 
