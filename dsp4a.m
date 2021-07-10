clear;
%调用xtg产生具有加性噪声的信号x(t)
%x(t)长度N=1000,并显示x(t)信号波形及其频谱
N=2000;xt=xtg(N);Fs=1000;T=1/Fs;Tp=N*T;
k=0:N-1;f1=k/Tp; 
 
%初始化指标
%通带截止频率fp 阻带截止频率fs 通带最大衰减 阻带最小衰减 采样频率Fs=1000Hz
fp=120;fs=150;Rp=0.2;As=70;Fs=1000;  
 
%用窗函数法设计滤波器
wc=(fp+fs)/Fs;      %理想低通滤波器截止频率(关于pi归一化）
B=2*pi*(fs-fp)/Fs;  %过渡带宽度指标
Nw=ceil(11*pi/B);   %blackman窗的长度N
hn=fir1(Nw-1,wc,blackman(Nw)); %阻带最小衰减为60dB 可以用blackman窗
disp(Nw-1);             %窗函数法设计滤波器 滤波器长度-1=阶数
Hw=abs(fft(hn,1024));   %求设计的滤波器频率特性
ywt=fftfilt(hn,xt,N);   %调用函数fftfilt对xt滤波
 
%窗函数法设计法的绘图部分（滤波器损耗函数, 滤波器输出信号波形）
f=(0:1023)*Fs/1024;
figure(2);subplot(3,1,1);
plot(f,20*log10(Hw/max(Hw)));grid;title('窗函数法低通滤波器幅频特性')
axis([0,Fs/2,-120,20]);
xlabel('f/Hz');ylabel('幅度')
t=(0:N-1)/Fs;Tp=N/Fs; 
subplot(3,1,2);
plot(t,ywt);grid on;
axis([0,Tp/2,-1,1]);xlabel('t/s');ylabel('y_w(t)');
title('滤除噪声后的信号波形');
 
subplot(3,1,3);
fxt=fftshift(fft(ywt,2000));
stem(f1-500,abs(fxt)/max(abs(fxt)));grid;title('滤除噪声后的信号频谱');
axis([0,500,0,1]);      %设置刻度  右边
 
% %调用xtg产生具有加性噪声的信号x(t)
% %x(t)长度N=1000,并显示x(t)信号波形及其频谱
% N=2000;xt=xtg(N);Fs=1000;T=1/Fs;Tp=N*T;
% k=0:N-1;f1=k/Tp; 
%  
% %初始化指标
% %通带截止频率fp 阻带截止频率fs 通带最大衰减 阻带最小衰减 采样频率Fs=1000Hz
% fp=120;fs=150;Rp=0.2;As=70;Fs=1000;  

%等波纹最佳逼近法设计滤波器
fb=[fp,fs]; m=[1,0];        
%确定remezord函数所需参数f,m,dev
dev=[(10^(Rp/20)-1)/(10^(Rp/20)+1),10^(-As/20)]; %十进制表示的
[Ne,fo,mo,W]=remezord(fb,m,dev,Fs);
disp(Ne-1);   %波纹最佳逼近法设计滤波器 滤波器长度
%确定remez函数所需参数
hn=remez(Ne-1,fo,mo,W);  %调用remez函数进行设计
Hw=abs(fft(hn,1024));  %求设计的滤波器频率特性
yet=fftfilt(hn,xt,N);  %调用函数fftfilt对xt滤波
 
%等波纹设计法的绘图部分（滤波器损耗函数, 滤波器输出信号yw(t)波形）
f=(0:1023)*Fs/1024;
figure(3);subplot(3,1,1);
plot(f,20*log10(Hw/max(Hw)),'g');grid;title('等波纹法低通滤波器幅频特性');
axis([0,Fs/2,-80,10]);
xlabel('f/Hz');ylabel('幅度')
t=(0:N-1)/Fs;Tp=N/Fs;
subplot(3,1,2)
plot(t,yet,'r');grid;
axis([0,Tp/2,-1,1]);xlabel('t/s');ylabel('y_e(t)');
title('滤除噪声后的信号波形');
 
subplot(3,1,3);
fet=fftshift(fft(yet,2000));
stem(f1-500,abs(fet)/max(abs(fet)),'k.');grid;title('滤除噪声后的信号频谱');
axis([0,500,0,1]);      %设置刻度  右边
