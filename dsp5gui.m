%-------------------------------------------------
%    copyright by zhangyuchen 201813050024
%
%    base dsp5gui.jpg
%    for  shiyan5
%    全局变量中temp为采样量
%      参考CSDN文章：MATLAB处理语音信号播放，滤波等
%      链接：https://blog.csdn.net/Insulatorer/article/details/112662349
%-------------------------------------------------------------------
function varargout = dsp5gui(varargin)
% DSP5GUI MATLAB code for dsp5gui.fig
%      DSP5GUI, by itself, creates a new DSP5GUI or raises the existing
%      singleton*.
%      %201813050024 张雨辰
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

%按钮一——选择音频文件
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.wav','ALLFILES(*.*)'},'选择声音文件');
if isequal([filename pathname],[0,0])
    return;
end
str=[pathname filename];%选择的声音文件路径和文件名
global temp;
global Fs;

[temp,Fs]=audioread(str);%temp表示声音数据 Fs表示频率
handles.y=temp;handles.Fs=Fs;

%按钮二：播放，对应图像1，播放原始图像
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp;
global Fs;
sound(temp,Fs);%播放音频文件



%加正弦信号噪声
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
n=length(temp);%提取采样信号的长度
t=0:1/Fs:(n-1)/Fs;%计算频域图的频率
df=Fs/length(temp); %计算谱线间隔
f=0:df:(Fs/2-df);
temp1=fft(temp,n);%进行N+1点FFT变换

ts=0:1/Fs:(size(temp)-1)/Fs;%将所加噪声信号的点数调整到与原始信号相同
s=temp(:,1)'+0.05*sin(2*pi*5000*ts);%加噪声为5000Hz的正弦信号正弦噪声
S=fft(s,n+1);%加正弦噪声后的频域
%正弦滤波
wp=2000/Fs*2*pi;%2000为通带截止频率
ws=3000/Fs*2*pi;%3000为阻带下限截止频率
Rp=4;%通带波纹
Rs=25;%阻带波纹
T=1/Fs;Fs=1/T;%定义采样间隔
Wp=2/T*tan(wp/2);%计算对应的数字频率
Ws=2/T*tan(ws/2);
plot(handles.axes2,s);%画出时域图，放到对应坐标轴中
plot(handles.axes1,abs(fftshift(S)));%画出时域图，放到对应坐标轴中
sound(s,Fs);%播放音频文件




%滤除正弦噪声
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

n=length(temp);%提取采样信号的长度
t=0:1/Fs:(n-1)/Fs;%计算频域图的频率
df=Fs/length(temp); %计算谱线间隔
f=0:df:(Fs/2-df);
temp1=fft(temp,n);%进行N+1点FFT变换

ts=0:1/Fs:(size(temp)-1)/Fs;%将所加噪声信号的点数调整到与原始信号相同
s=temp(:,1)'+0.05*sin(2*pi*5000*ts);%加噪声为5000Hz的正弦信号正弦噪声
S=fft(s,n+1);%加正弦噪声后的频域
%正弦滤波
wp=2000/Fs*2*pi;%2000为通带截止频率
ws=3000/Fs*2*pi;%3000为阻带下限截止频率
Rp=4;%通带波纹
Rs=25;%阻带波纹
T=1/Fs;Fs=1/T;%定义采样间隔
Wp=2/T*tan(wp/2);%计算对应的数字频率
Ws=2/T*tan(ws/2);
[N,wn]=buttord(Wp,Ws,Rp,Rs,'s');%计算滤波器介数和截止频率
[c,d]=butter(N,wn,'s');%计算滤波器系统函数分子分母系数
[B,A]=bilinear(c,d,Fs);%双线性变换得到数字滤波器系统函数分子分母系数
% [Hb,Wc]=freqz(B,A);
sf=filter(B,A,s);%对加噪信号进行滤波
Sf=fft(sf,n+1);%对滤波后进行N+1点FFT变换
plot(handles.axes3,sf);%画出时域图，放到对应坐标轴中
plot(handles.axes4,abs(fftshift(Sf)));%画出时域图，放到对应坐标轴中
sound(sf,Fs);










% --- Executes on button press in pushbutton5.

%加高斯白噪声
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handlen=length(temp);%提取采样信号的长度
global Fs;
global temp;
global temp1;
global t;
global f;
global z;
global Z

df=Fs/length(temp); %计算谱线间隔
t=0:1/Fs:(df-1)/Fs;%计算频域图的频率
f=0:df:(Fs/2-df);
temp1=fft(temp,df);%进行N+1点FFT变换
z=awgn(temp,20);%对信号加信噪比10的高斯白噪声
N1=size(z,1);
ts=0:1/Fs:(size(temp)-1)/Fs;%将所加噪声信号的点数调整到与原始信号相同
% s=temp(:,1)'+0.05*sin(2*pi*5000*ts);%加噪声为5000Hz的正弦信号正弦噪声
f=Fs*(0:(N1+1)/2-1)/N1+1;
Z=fft(z,N1+1);%加正弦噪声后的频域
%正弦滤波
% Wp=2500/fs*2*pi;
% Ws=3000/fs*2*pi;
% Rp=4;%通带波纹
% Rs=25;%阻带波纹
% T=1/Fs;Fs=1/T;%定义采样间隔
% Wp=2/T*tan(wp/2);%计算对应的数字频率
% Ws=2/T*tan(ws/2);
plot(handles.axes5,z);%画出时域图，放到对应坐标轴中
plot(handles.axes7,abs(fftshift(Z)));%画出时域图，放到对应坐标轴中s and user data (see GUIDATA)
sound(z,Fs);%播放音频文件

%滤除高斯白噪声
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

df=Fs/length(temp); %计算谱线间隔
t=0:1/Fs:(df-1)/Fs;%计算频域图的频率
f=0:df:(Fs/2-df);
temp1=fft(temp,df);%进行N+1点FFT变换
z=awgn(temp,20);%对信号加信噪比10的高斯白噪声
N1=size(z,1);
ts=0:1/Fs:(size(temp)-1)/Fs;%将所加噪声信号的点数调整到与原始信号相同
% s=temp(:,1)'+0.05*sin(2*pi*5000*ts);
f=Fs*(0:(N1+1)/2-1)/N1+1;
Z=fft(z,N1+1);

Wp=2500/Fs*2*pi;
Ws=3000/Fs*2*pi;

T=1/Fs;Fs=1/T;%定义采样间隔
% Wp=2/T*tan(wp/2);%计算对应的数字频率
% Ws=2/T*tan(ws/2);
B=Ws-Wp;
n=ceil(1*pi/B);
wc=(Wp+Ws)/2;
b=fir1(n-1,wc/pi,'stop',blackman(n));%oblackman窗函数滤波
[H,w]=freqz(b,1);
y=fftfilt(b,z);

Y=fft(y,N1+1);
plot(handles.axes8,y);%画出时域图，放到对应坐标轴中
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
df=Fs/length(temp1); %计算谱线间隔
f=0:df:(Fs/2-df); %频谱范围，截取前半段（抽样频率高于最大频率的2倍）
temp1=fft(temp,n);   %快速傅里叶变换

plot(handles.axes10,temp);%画出时域图，放到对应坐标轴中
%title(handles.axes1,'初始信号波形');   %绘出时域波

plot(handles.axes11,abs(fftshift(temp1)));
%title(handles.axes2,'初始信号频谱');      %绘出频域波
