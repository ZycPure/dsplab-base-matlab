Fs=1200;Fp=1000;Ft=8000;As=100;Ap=1;
[x,fs]=audioread('chirp.wav');

%x=x(:,1);
Y=fft(x);

wp=2*pi*Fp/Ft;
ws=2*pi*fs/Ft;

[n,wn]=ellipord(wp,ws,Ap,As,'s');
[b,a]=ellip(n,Ap,As,wn,'s');
[B,A]=bilinear(b,a,1);
[h,w]=freqz(B,A);

% figure(1);
% subplot(2,1,1);
% plot(w,20*log10(abs(h))); %画对数幅度谱
% grid on;
% xlabel('归一化频率w/pi'); ylabel('幅度(dB)');
% title('IIR-幅度响应');
% subplot(2,1,2);
% plot(w,angle(h)); grid on;
% xlabel('归一化频率w/pi');ylabel('相位');
% title('IIR-相位响应');

% y=filter(B,A,x); %滤波
% 
% figure(2);
% subplot(2,1,1);plot(x);
% title('IIR低通滤波器滤波前的时域波形');
% subplot(2,1,2);
% plot(y);
% title('IIR低通滤波器滤波后的时域波形');

y=filter(B,A,x);
Y1=fft(y);
n=0:length(x)-1;
% t=(0:fs-1)/fs;
figure(1);
subplot(3,1,1);plot(y);grid on;
title('低通滤波器滤波后时域波形图');
xlabel('时间');
ylabel('幅度');
subplot(3,1,2);plot(n,abs(Y));grid on;
title('低通滤波前语音信号频谱');
xlabel('频率');
ylabel('?幅度');
axis([0 1000000 0 8]);
subplot(3,1,3);plot(n,abs(Y1));grid on;
title('低通滤波后语音信号频谱');
xlabel('频率');
ylabel('?幅度');
axis([0 1000000 0 8]);
