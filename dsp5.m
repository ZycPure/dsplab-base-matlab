%------------------------------------------------
%���곽 ����һ�� 201813050024
%------------------------------------------------
%ֱ�Ӷ�fftshift�汾��Ƶ��
% [x,fs]=audioread('chirp.wav');%ԭ�ź�    
% N=length(y);    
% y1=fft(x,N);%���ٸ���Ҷ�任  
% figure(1)  
% subplot(2,1,1);  
% plot(x);  
% xlabel('ʱ��');  
% ylabel('����');  
% title('��ʼ�źŲ���'); %���ʱ��  
% grid on;  
% subplot(2,1,2);%���Ƶ��Ƶ��  
% plot(abs(fftshift(y1)));  
% title('��ʼ�ź�Ƶ��');  
% xlabel('Ƶ��');  
% ylabel('����');  
% grid on; 

% %ԭ�ź�Ƶ�׷���
% [x,fs]=audioread('chirp.wav');%ԭ�ź�
% n=size(x,1);%��ȡ�����źŵĳ���
% f=fs*(0:(n+1)/2-1)/n+1;%����Ƶ��ͼ��Ƶ��
% X=fft(x,n+1);%����N+1��FFT�任
% figure(1);
% subplot(2,1,1);
% plot(x);
% title('ԭ�ź�ʱ��');
% xlabel('ʱ�䣨s��');
% ylabel('����');
% subplot(2,1,2);
% plot(abs(fftshift(X)));
% title('ԭ�ź�Ƶ��');
% xlabel('Ƶ��(Hz)');
% ylabel('����');
% sound(x);
% 
% 
% ts=0:1/fs:(size(x)-1)/fs;%�����������źŵĵ�����������ԭʼ�ź���ͬ
% s=x(:,1)'+0.05*sin(2*pi*5000*ts);%������Ϊ5000Hz�������ź���������
% S=fft(s,n+1);%�������������Ƶ��
% %�����˲�
% wp=2000/fs*2*pi;%2000Ϊͨ����ֹƵ��
% ws=3000/fs*2*pi;%3000Ϊ������޽�ֹƵ��
% Rp=4;%ͨ������
% Rs=25;%�������
% T=1/fs;Fs=1/T;%����������
% Wp=2/T*tan(wp/2);%�����Ӧ������Ƶ��
% Ws=2/T*tan(ws/2);
% % 
% % % %��ͼ����
% % 
% % %�����źŵ���ʾ
% figure(2);
% subplot(2,1,1);
% plot(s);title('�������źź��ʱ��');xlabel('ʱ��(s)');
% ylabel('����');
% subplot(2,1,2);
% plot(abs(fftshift(S)));
% title('�������źź��Ƶ��ͼ');xlabel('Ƶ��(Hz)');
% ylabel('����');
% sound(s);
% % 
% % %�����źŵ��˲�
% [N,wn]=buttord(Wp,Ws,Rp,Rs,'s');%�����˲��������ͽ�ֹƵ��
% [c,d]=butter(N,wn,'s');%�����˲���ϵͳ�������ӷ�ĸϵ��
% [B,A]=bilinear(c,d,Fs);%˫���Ա任�õ������˲���ϵͳ�������ӷ�ĸϵ��
% [Hb,Wc]=freqz(B,A);
% sf=filter(B,A,s);%�Լ����źŽ����˲�
% Sf=fft(sf,n+1);%���˲������N+1��FFT�任

% figure(3);
% subplot(2,1,1);
% plot(sf);title('�˲����ʱ��ͼ');xlabel('ʱ��(s)');
% ylabel('����');
% subplot(2,1,2);
% plot(abs(fftshift(Sf))); title('�˲����Ƶ��ͼ');xlabel('Ƶ��(Hz)');
% ylabel('����');sound(x);sound(s);sound(sf);
% sound(sf);
% figure(4);
% plot(fs*Wc/(2*pi),20*log10(abs(Hb)));
% title('��˹��ͨ�˲���Ƶ����Ӧͼ');
% xlabel('Ƶ��(Hz)');
% ylabel('����');
% sound(x);
% sound(s);


%�����˹������
[x,fs]=audioread('d.mp3');%ԭ�ź�
N=size(x,1);%��ȡ�����źŵĳ���
t=(0:length(x)-1)/fs;%��������ʱ��
f=fs*(0:(N+1)/2-1)/N+1;%����Ƶ��ͼ��Ƶ��
X=fft(x,N+1);%����N+1��FFT�任
%�Ӱ�����
z=awgn(x,20);%���źż������10�ĸ�˹������
N1=size(z,1);
t=(0:length(z)-1)/fs;
f=fs*(0:(N1+1)/2-1)/N1+1;
Z=fft(z,N1+1);
Wp=2500/fs*2*pi;
Ws=3000/fs*2*pi;
%��ʾ���˸�˹���������ͼ��
figure(1);
subplot(2,1,1);
plot(z);title('�Ӱ�������ʱ��ͼ');
subplot(2,1,2);
plot(abs(fftshift(Z)));title('�˲�ǰ�ź�Ƶ��ͼ');
sound(z);

B=Ws-Wp;
n=ceil(1*pi/B);
wc=(Wp+Ws)/2;
b=fir1(n-1,wc/pi,'stop',blackman(n));%oblackman�������˲�
[H,w]=freqz(b,1);
y=fftfilt(b,z);
t1=(0:length(y)-1)/fs;
Y=fft(y,N1+1);

figure(2);
subplot(2,1,1);plot(y);
title('�˲����ź�ʱ��ͼ');xlabel('ʱ��(s)');
ylabel('����');subplot(2,1,2);
plot(abs(fftshift(Y)));title('�˲����ź�Ƶ��ͼ');
xlabel('Ƶ��(Hz��');ylabel('����');
figure(3);
plot(fs*w/(2*pi),20*log10(abs(H)));
title('Ƶ����Ӧ')
xlabel('Ƶ�ʣ�Hz��');ylabel('����');
sound(y,fs);
