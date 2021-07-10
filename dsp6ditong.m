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
% plot(w,20*log10(abs(h))); %������������
% grid on;
% xlabel('��һ��Ƶ��w/pi'); ylabel('����(dB)');
% title('IIR-������Ӧ');
% subplot(2,1,2);
% plot(w,angle(h)); grid on;
% xlabel('��һ��Ƶ��w/pi');ylabel('��λ');
% title('IIR-��λ��Ӧ');

% y=filter(B,A,x); %�˲�
% 
% figure(2);
% subplot(2,1,1);plot(x);
% title('IIR��ͨ�˲����˲�ǰ��ʱ����');
% subplot(2,1,2);
% plot(y);
% title('IIR��ͨ�˲����˲����ʱ����');

y=filter(B,A,x);
Y1=fft(y);
n=0:length(x)-1;
% t=(0:fs-1)/fs;
figure(1);
subplot(3,1,1);plot(y);grid on;
title('��ͨ�˲����˲���ʱ����ͼ');
xlabel('ʱ��');
ylabel('����');
subplot(3,1,2);plot(n,abs(Y));grid on;
title('��ͨ�˲�ǰ�����ź�Ƶ��');
xlabel('Ƶ��');
ylabel('?����');
axis([0 1000000 0 8]);
subplot(3,1,3);plot(n,abs(Y1));grid on;
title('��ͨ�˲��������ź�Ƶ��');
xlabel('Ƶ��');
ylabel('?����');
axis([0 1000000 0 8]);
