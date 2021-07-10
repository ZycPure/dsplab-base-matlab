function varargout = dspgui(varargin)
% DSPGUI MATLAB code for dspgui.fig
%      by 张雨辰201813050024 电信一班
%       低通高通带通部分采用双线性变换法
%       全局变量中temp为采样量
%        修改前端文件指令：guide
%      参考CSDN文章：MATLAB处理语音信号播放，滤波等
%      链接：https://blog.csdn.net/Insulatorer/article/details/112662349
%      
%      DSPGUI, by itself, creates a new DSPGUI or raises the existing
%      singleton*.
%
%      H = DSPGUI returns the handle to a new DSPGUI or the handle to
%      the existing singleton*.
%
%      DSPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSPGUI.M with the given input arguments.
%
%      DSPGUI('Property','Value',...) creates a new DSPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dspgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dspgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dspgui

% Last Modified by GUIDE v2.5 08-Jun-2021 01:09:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dspgui_OpeningFcn, ...
                   'gui_OutputFcn',  @dspgui_OutputFcn, ...
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


% --- Executes just before dspgui is made visible.
function dspgui_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% by zhangyuchen 201813050024
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dspgui (see VARARGIN)

% Choose default command line output for dspgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
im = imread('logo.jpg');
axes(handles.axes10)
imshow(im)

% UIWAIT makes dspgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dspgui_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.   选择音频文件
function pushbutton1_Callback(~, ~, handles)
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


% --- Executes on button press in pushbutton2.   播放
function pushbutton2_Callback(~, ~, ~)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp;
global Fs;
sound(temp,Fs);%播放音频文件


% --- Executes on button press in pushbutton3.      低通
function pushbutton3_Callback(~, ~, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global temp;

wp=2*pi*1000/Fs;
ws=2*pi*1200/Fs;
wdelta=ws-wp;
N=ceil(8* pi/wdelta);  %取整
wn=(wp+ws)/2;
[b,a]=fir1(N,wn/pi,hamming(N+1));  %选择窗函数，并归一化截止频率

f2=filter(b,a,temp);

plot(handles.axes3,f2);
%title(handles.axes3,'低通滤波器滤波后的时域波形');

F0=fft(f2,1024);
f=Fs*(0:511)/1024;

plot(handles.axes5,f,abs(F0(1:512)));
%title(handles.axes5,'低通滤波器滤波后的频谱')

sound(f2,Fs);  %播放滤波后的语音信号sound



% --- Executes on button press in pushbutton4.   高通
function pushbutton4_Callback(~, ~, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
%by graypuppy xuehao:201813050024 www.graypuppy.cn
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global temp;

% Ts=1/Fs;R1=50;
% Wp=2*pi*4400/Fs;
% Ws=2* pi*4000/Fs;
% Rp=1;
% Rl=100;
% Wp1=2/Ts*tan(Wp/2);  %将模拟指标转换成数字指标
% Ws1=2/Ts*tan(Ws/2);
% 
% [N,Wn]=cheb2ord(Wp1,Ws1,Rp,R1,'s'); %选择滤波器的最小阶数
% [Z,P,K]=cheb2ap(N,Rl);  %创建切比雪夫模拟滤波器
% [Bap,Aap]=zp2tf(Z,P,K);
% [b,a]=lp2hp(Bap,Aap,Wn);
% [bz,az ]=bilinear(b,a,Fs);  %用双线性变换法实现模拟滤波器到数字滤波器的转换
% 
% f1=filter(bz,az,temp);
temp=temp(:,1);
Y=fft(temp);
Fp=4500;Fs=5000;Ft=8000;
As=100;Ap=1;
wp=2*pi*Fp/Ft;
ws=2*pi*Fs/Ft;
[n,wn]=ellipord(wp,ws,Ap,As,'s');
[b,a]=ellip(n,Ap,As,wn,'high','s');
[B,A]=bilinear(b,a,1);
%[h,w]=freqz(B,A);
y=filter(B,A,temp);
Y1=fft(y);
n=0:length(temp)-1;
%t=(0:FS-1)/fs;

plot(handles.axes6,y);  %画出滤波后的时域图
%title(handles.axes6,'高通滤波器滤波后的时域波形');
% 
% F0=fft(f1,1024);
% f=Fs*(0:511)/1024;

plot(handles.axes7,n,abs(Y1));  %画出滤波后的频谱图
%title(handles.axes7,'高通滤波器滤波后的频谱')
%本部分注释部分代码可以用作参考，真实使用部分参考第四小题中的高通部分
sound(y,Fs);  %播放滤波后的语音信号



% --- Executes on button press in pushbutton5.   带通
function pushbutton5_Callback(~, ~, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global temp;

Ts= 1/Fs;R1=30;
fb1=1200;fb2=5000;fc1=1000;fc2=32000;fs=23000;
W1=2*fb1 *pi/fs;W2=2*fc1*pi/fs;
W3=2*fb2*pi/fs;W4=2*fc2* pi/fs;
Wp=[W1,W3];
Ws=[W2,W4];
Rp=1;
Rl=100;
Wp1=2/Ts*tan(Wp/2);  %将模拟指标转换成数字指标
Ws1 =2/Ts*tan(Ws/2);

[N,Wn]=cheb2ord(Wp1,Ws1,Rp,R1,'s'); %选择滤波器的最小阶数
[Z,P,K]=cheb2ap(N,Rl);   %创建切比雪夫模拟滤波器;
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2bp(Bap,Aap,2100*2*pi,1800*2*pi);
[bz,az]=bilinear(b,a,Fs);  %用双线性变换法实现模拟滤波器到数字滤波器的转换

f1 =filter(bz,az,temp);

plot(handles.axes8,f1);   %画出滤波后的时域图
%title(handles.axes8,'带通滤波器滤波后的时域波形');

F0=fft(f1,1024);
f=Fs*(0:511)/1024;

plot(handles.axes9,f,abs(F0(1:512)));  %画出滤波后的频谱图
%title(handles.axes9,'带通滤波器滤波后的频谱')

sound(f1,Fs);  %播放滤波后的语音信号



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(~, ~, handles)
% hObject    handle to pushbutton6 (see GCBO)
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

plot(handles.axes1,temp);%画出时域图，放到对应坐标轴中
%title(handles.axes1,'初始信号波形');   %绘出时域波

plot(handles.axes2,abs(fftshift(temp1)));
%title(handles.axes2,'初始信号频谱');      %绘出频域波
