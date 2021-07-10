%-------------------------------------------------
%    copyright by zhangyuchen 201813050024
%
%    base dsp5gui.jpg
%    for  shiyan5
%    ȫ�ֱ�����tempΪ������
%      �ο�CSDN���£�MATLAB���������źŲ��ţ��˲���
%      ���ӣ�https://blog.csdn.net/Insulatorer/article/details/112662349
%-------------------------------------------------------------------
function varargout = dsp5gui(varargin)
% DSP5GUI MATLAB code for dsp5gui.fig
%      DSP5GUI, by itself, creates a new DSP5GUI or raises the existing
%      singleton*.
%      %201813050024 ���곽
%      H = DSP5GUI returns the handle to a new DSP5GUI or the handle to
%      the existing singleton*.
%
%      DSP5GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSP5GUI.M with the given input arguments.
%
%      DSP5GUI('Property','Value',...) creates a new DSP5GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dsp5gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dsp5gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dsp5gui

% Last Modified by GUIDE v2.5 19-Jun-2021 01:07:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dsp5gui_OpeningFcn, ...
                   'gui_OutputFcn',  @dsp5gui_OutputFcn, ...
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


% --- Executes just before dsp5gui is made visible.
function dsp5gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dsp5gui (see VARARGIN)
%201813050024
% Choose default command line output for dsp5gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
guidata(hObject, handles);
im = imread('logo.jpg');
axes(handles.axes6)
imshow(im)

% UIWAIT makes dsp5gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dsp5gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%201813050024
% Get default command line output from handles structure
varargout{1} = handles.output;

%��ťһ����ѡ����Ƶ�ļ�
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.wav','ALLFILES(*.*)'},'ѡ�������ļ�');
if isequal([filename pathname],[0,0])
    return;
end
str=[pathname filename];%ѡ��������ļ�·�����ļ���
global temp;
global Fs;

[temp,Fs]=audioread(str);%temp��ʾ�������� Fs��ʾƵ��
handles.y=temp;handles.Fs=Fs;

%��ť�������ţ���Ӧͼ��1������ԭʼͼ��
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp;
global Fs;
sound(temp,Fs);%������Ƶ�ļ�



%�������ź�����
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global temp;
global temp1;
global t;
global f;
n=length(temp);%��ȡ�����źŵĳ���
t=0:1/Fs:(n-1)/Fs;%����Ƶ��ͼ��Ƶ��
df=Fs/length(temp); %�������߼��
f=0:df:(Fs/2-df);
temp1=fft(temp,n);%����N+1��FFT�任

ts=0:1/Fs:(size(temp)-1)/Fs;%�����������źŵĵ�����������ԭʼ�ź���ͬ
s=temp(:,1)'+0.05*sin(2*pi*5000*ts);%������Ϊ5000Hz�������ź���������
S=fft(s,n+1);%�������������Ƶ��
%�����˲�
wp=2000/Fs*2*pi;%2000Ϊͨ����ֹƵ��
ws=3000/Fs*2*pi;%3000Ϊ������޽�ֹƵ��
Rp=4;%ͨ������
Rs=25;%�������
T=1/Fs;Fs=1/T;%����������
Wp=2/T*tan(wp/2);%�����Ӧ������Ƶ��
Ws=2/T*tan(ws/2);
plot(handles.axes2,s);%����ʱ��ͼ���ŵ���Ӧ��������
plot(handles.axes1,abs(fftshift(S)));%����ʱ��ͼ���ŵ���Ӧ��������
sound(s,Fs);%������Ƶ�ļ�




%�˳���������
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global temp;
global temp1;
global t;
global f;
global sf;
global Sf;

n=length(temp);%��ȡ�����źŵĳ���
t=0:1/Fs:(n-1)/Fs;%����Ƶ��ͼ��Ƶ��
df=Fs/length(temp); %�������߼��
f=0:df:(Fs/2-df);
temp1=fft(temp,n);%����N+1��FFT�任

ts=0:1/Fs:(size(temp)-1)/Fs;%�����������źŵĵ�����������ԭʼ�ź���ͬ
s=temp(:,1)'+0.05*sin(2*pi*5000*ts);%������Ϊ5000Hz�������ź���������
S=fft(s,n+1);%�������������Ƶ��
%�����˲�
wp=2000/Fs*2*pi;%2000Ϊͨ����ֹƵ��
ws=3000/Fs*2*pi;%3000Ϊ������޽�ֹƵ��
Rp=4;%ͨ������
Rs=25;%�������
T=1/Fs;Fs=1/T;%����������
Wp=2/T*tan(wp/2);%�����Ӧ������Ƶ��
Ws=2/T*tan(ws/2);
[N,wn]=buttord(Wp,Ws,Rp,Rs,'s');%�����˲��������ͽ�ֹƵ��
[c,d]=butter(N,wn,'s');%�����˲���ϵͳ�������ӷ�ĸϵ��
[B,A]=bilinear(c,d,Fs);%˫���Ա任�õ������˲���ϵͳ�������ӷ�ĸϵ��
% [Hb,Wc]=freqz(B,A);
sf=filter(B,A,s);%�Լ����źŽ����˲�
Sf=fft(sf,n+1);%���˲������N+1��FFT�任
plot(handles.axes3,sf);%����ʱ��ͼ���ŵ���Ӧ��������
plot(handles.axes4,abs(fftshift(Sf)));%����ʱ��ͼ���ŵ���Ӧ��������
sound(sf,Fs);










% --- Executes on button press in pushbutton5.

%�Ӹ�˹������
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handlen=length(temp);%��ȡ�����źŵĳ���
global Fs;
global temp;
global temp1;
global t;
global f;
global z;
global Z

df=Fs/length(temp); %�������߼��
t=0:1/Fs:(df-1)/Fs;%����Ƶ��ͼ��Ƶ��
f=0:df:(Fs/2-df);
temp1=fft(temp,df);%����N+1��FFT�任
z=awgn(temp,20);%���źż������10�ĸ�˹������
N1=size(z,1);
ts=0:1/Fs:(size(temp)-1)/Fs;%�����������źŵĵ�����������ԭʼ�ź���ͬ
% s=temp(:,1)'+0.05*sin(2*pi*5000*ts);%������Ϊ5000Hz�������ź���������
f=Fs*(0:(N1+1)/2-1)/N1+1;
Z=fft(z,N1+1);%�������������Ƶ��
%�����˲�
% Wp=2500/fs*2*pi;
% Ws=3000/fs*2*pi;
% Rp=4;%ͨ������
% Rs=25;%�������
% T=1/Fs;Fs=1/T;%����������
% Wp=2/T*tan(wp/2);%�����Ӧ������Ƶ��
% Ws=2/T*tan(ws/2);
plot(handles.axes5,z);%����ʱ��ͼ���ŵ���Ӧ��������
plot(handles.axes7,abs(fftshift(Z)));%����ʱ��ͼ���ŵ���Ӧ��������s and user data (see GUIDATA)
sound(z,Fs);%������Ƶ�ļ�

%�˳���˹������
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global temp;
global temp1;
global t;
global f;
global z;
global Z;
global y;
global Y;

df=Fs/length(temp); %�������߼��
t=0:1/Fs:(df-1)/Fs;%����Ƶ��ͼ��Ƶ��
f=0:df:(Fs/2-df);
temp1=fft(temp,df);%����N+1��FFT�任
z=awgn(temp,20);%���źż������10�ĸ�˹������
N1=size(z,1);
ts=0:1/Fs:(size(temp)-1)/Fs;%�����������źŵĵ�����������ԭʼ�ź���ͬ
% s=temp(:,1)'+0.05*sin(2*pi*5000*ts);
f=Fs*(0:(N1+1)/2-1)/N1+1;
Z=fft(z,N1+1);

Wp=2500/Fs*2*pi;
Ws=3000/Fs*2*pi;

T=1/Fs;Fs=1/T;%����������
% Wp=2/T*tan(wp/2);%�����Ӧ������Ƶ��
% Ws=2/T*tan(ws/2);
B=Ws-Wp;
n=ceil(1*pi/B);
wc=(Wp+Ws)/2;
b=fir1(n-1,wc/pi,'stop',blackman(n));%oblackman�������˲�
[H,w]=freqz(b,1);
y=fftfilt(b,z);

Y=fft(y,N1+1);
plot(handles.axes8,y);%����ʱ��ͼ���ŵ���Ӧ��������
plot(handles.axes9,abs(fftshift(Y)));
sound(y,Fs);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp;
global temp1;
global Fs;
global t;
global f;

n=length(temp);
t=0:1/Fs:(n-1)/Fs;
df=Fs/length(temp1); %�������߼��
f=0:df:(Fs/2-df); %Ƶ�׷�Χ����ȡǰ��Σ�����Ƶ�ʸ������Ƶ�ʵ�2����
temp1=fft(temp,n);   %���ٸ���Ҷ�任

plot(handles.axes10,temp);%����ʱ��ͼ���ŵ���Ӧ��������
%title(handles.axes1,'��ʼ�źŲ���');   %���ʱ��

plot(handles.axes11,abs(fftshift(temp1)));
%title(handles.axes2,'��ʼ�ź�Ƶ��');      %���Ƶ��
