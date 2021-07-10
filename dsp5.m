%------------------------------------------------
%张雨辰 电信一班 201813050024
%------------------------------------------------
%直接对fftshift版本的频谱
% [x,fs]=audioread('chirp.wav');%原信号    
% N=length(y);    
% y1=fft(x,N);%快速傅里叶变换  
% figure(1)  
% subplot(2,1,1);  
% plot(x);  
% xlabel('时间');  
% ylabel('幅度');  
% title('初始信号波形'); %绘出时域波  
% grid on;  
% subplot(2,1,2);%绘出频域频谱  
% plot(abs(fftshift(y1)));  
% title('初始信号频谱');  
% xlabel('频率');  
% ylabel('幅度');  
% grid on; 

% %原信号频谱分析
% [x,fs]=audioread('chirp.wav');%原信号
% n=size(x,1);%提取采样信号的长度
% f=fs*(0:(n+1)/2-1)/n+1;%计算频域图的频率
% X=fft(x,n+1);%进行N+1点FFT变换
% figure(1);
% subplot(2,1,1);
% plot(x);
% title('原信号时域');
% xlabel('时间（s）');
% ylabel('幅度');
% subplot(2,1,2);
% plot(abs(fftshift(X)));
% title('原信号频域');
% xlabel('频率(Hz)');
% ylabel('幅度');
% sound(x);
% 
% 
% ts=0:1/fs:(size(x)-1)/fs;%将所加噪声信号的点数调整到与原始信号相同
% s=x(:,1)'+0.05*sin(2*pi*5000*ts);%加噪声为5000Hz的正弦信号正弦噪声
% S=fft(s,n+1);%加正弦噪声后的频域
% %正弦滤波
% wp=2000/fs*2*pi;%2000为通带截止频率
% ws=3000/fs*2*pi;%3000为阻带下限截止频率
% Rp=4;%通带波纹
% Rs=25;%阻带波纹
% T=1/fs;Fs=1/T;%定义采样间隔
% Wp=2/T*tan(wp/2);%计算对应的数字频率
% Ws=2/T*tan(ws/2);
% % 
% % % %绘图部分
% % 
% % %正弦信号的显示
% figure(2);
% subplot(2,1,1);
% plot(s);title('加正弦信号后的时域');xlabel('时间(s)');
% ylabel('幅度');
% subplot(2,1,2);
% plot(abs(fftshift(S)));
% title('加正弦信号后的频域图');xlabel('频率(Hz)');
% ylabel('幅度');
% sound(s);
% % 
% % %正弦信号的滤波
% [N,wn]=buttord(Wp,Ws,Rp,Rs,'s');%计算滤波器介数和截止频率
% [c,d]=butter(N,wn,'s');%计算滤波器系统函数分子分母系数
% [B,A]=bilinear(c,d,Fs);%双线性变换得到数字滤波器系统函数分子分母系数
% [Hb,Wc]=freqz(B,A);
% sf=filter(B,A,s);%对加噪信号进行滤波
% Sf=fft(sf,n+1);%对滤波后进行N+1点FFT变换

% figure(3);
% subplot(2,1,1);
% plot(sf);title('滤波后的时域图');xlabel('时间(s)');
% ylabel('幅度');
% subplot(2,1,2);
% plot(abs(fftshift(Sf))); title('滤波后的频域图');xlabel('频率(Hz)');
% ylabel('幅度');sound(x);sound(s);sound(sf);
% sound(sf);
% figure(4);
% plot(fs*Wc/(2*pi),20*log10(abs(Hb)));
% title('巴斯低通滤波器频域响应图');
% xlabel('频率(Hz)');
% ylabel('幅度');
% sound(x);
% sound(s);


%加入高斯白噪声
[x,fs]=audioread('d.mp3');%原信号
N=size(x,1);%提取采样信号的长度
t=(0:length(x)-1)/fs;%计算样本时刻
f=fs*(0:(N+1)/2-1)/N+1;%计算频域图的频率
X=fft(x,N+1);%进行N+1点FFT变换
%加白噪声
z=awgn(x,20);%对信号加信噪比10的高斯白噪声
N1=size(z,1);
t=(0:length(z)-1)/fs;
f=fs*(0:(N1+1)/2-1)/N1+1;
Z=fft(z,N1+1);
Wp=2500/fs*2*pi;
Ws=3000/fs*2*pi;
%显示加了高斯白噪声后的图像
figure(1);
subplot(2,1,1);
plot(z);title('加白噪声后时域图');
subplot(2,1,2);
plot(abs(fftshift(Z)));title('滤波前信号频谱图');
sound(z);

B=Ws-Wp;
n=ceil(1*pi/B);
wc=(Wp+Ws)/2;
b=fir1(n-1,wc/pi,'stop',blackman(n));%oblackman窗函数滤波
[H,w]=freqz(b,1);
y=fftfilt(b,z);
t1=(0:length(y)-1)/fs;
Y=fft(y,N1+1);

figure(2);
subplot(2,1,1);plot(y);
title('滤波后信号时域图');xlabel('时间(s)');
ylabel('幅度');subplot(2,1,2);
plot(abs(fftshift(Y)));title('滤波后信号频谱图');
xlabel('频率(Hz）');ylabel('幅度');
figure(3);
plot(fs*w/(2*pi),20*log10(abs(H)));
title('频率响应')
xlabel('频率（Hz）');ylabel('幅度');
sound(y,fs);
