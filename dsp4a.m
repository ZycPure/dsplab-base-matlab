clear;
%����xtg�������м����������ź�x(t)
%x(t)����N=1000,����ʾx(t)�źŲ��μ���Ƶ��
N=2000;xt=xtg(N);Fs=1000;T=1/Fs;Tp=N*T;
k=0:N-1;f1=k/Tp; 
 
%��ʼ��ָ��
%ͨ����ֹƵ��fp �����ֹƵ��fs ͨ�����˥�� �����С˥�� ����Ƶ��Fs=1000Hz
fp=120;fs=150;Rp=0.2;As=70;Fs=1000;  
 
%�ô�����������˲���
wc=(fp+fs)/Fs;      %�����ͨ�˲�����ֹƵ��(����pi��һ����
B=2*pi*(fs-fp)/Fs;  %���ɴ����ָ��
Nw=ceil(11*pi/B);   %blackman���ĳ���N
hn=fir1(Nw-1,wc,blackman(Nw)); %�����С˥��Ϊ60dB ������blackman��
disp(Nw-1);             %������������˲��� �˲�������-1=����
Hw=abs(fft(hn,1024));   %����Ƶ��˲���Ƶ������
ywt=fftfilt(hn,xt,N);   %���ú���fftfilt��xt�˲�
 
%����������Ʒ��Ļ�ͼ���֣��˲�����ĺ���, �˲�������źŲ��Σ�
f=(0:1023)*Fs/1024;
figure(2);subplot(3,1,1);
plot(f,20*log10(Hw/max(Hw)));grid;title('����������ͨ�˲�����Ƶ����')
axis([0,Fs/2,-120,20]);
xlabel('f/Hz');ylabel('����')
t=(0:N-1)/Fs;Tp=N/Fs; 
subplot(3,1,2);
plot(t,ywt);grid on;
axis([0,Tp/2,-1,1]);xlabel('t/s');ylabel('y_w(t)');
title('�˳���������źŲ���');
 
subplot(3,1,3);
fxt=fftshift(fft(ywt,2000));
stem(f1-500,abs(fxt)/max(abs(fxt)));grid;title('�˳���������ź�Ƶ��');
axis([0,500,0,1]);      %���ÿ̶�  �ұ�
 
% %����xtg�������м����������ź�x(t)
% %x(t)����N=1000,����ʾx(t)�źŲ��μ���Ƶ��
% N=2000;xt=xtg(N);Fs=1000;T=1/Fs;Tp=N*T;
% k=0:N-1;f1=k/Tp; 
%  
% %��ʼ��ָ��
% %ͨ����ֹƵ��fp �����ֹƵ��fs ͨ�����˥�� �����С˥�� ����Ƶ��Fs=1000Hz
% fp=120;fs=150;Rp=0.2;As=70;Fs=1000;  

%�Ȳ�����ѱƽ�������˲���
fb=[fp,fs]; m=[1,0];        
%ȷ��remezord�����������f,m,dev
dev=[(10^(Rp/20)-1)/(10^(Rp/20)+1),10^(-As/20)]; %ʮ���Ʊ�ʾ��
[Ne,fo,mo,W]=remezord(fb,m,dev,Fs);
disp(Ne-1);   %������ѱƽ�������˲��� �˲�������
%ȷ��remez�����������
hn=remez(Ne-1,fo,mo,W);  %����remez�����������
Hw=abs(fft(hn,1024));  %����Ƶ��˲���Ƶ������
yet=fftfilt(hn,xt,N);  %���ú���fftfilt��xt�˲�
 
%�Ȳ�����Ʒ��Ļ�ͼ���֣��˲�����ĺ���, �˲�������ź�yw(t)���Σ�
f=(0:1023)*Fs/1024;
figure(3);subplot(3,1,1);
plot(f,20*log10(Hw/max(Hw)),'g');grid;title('�Ȳ��Ʒ���ͨ�˲�����Ƶ����');
axis([0,Fs/2,-80,10]);
xlabel('f/Hz');ylabel('����')
t=(0:N-1)/Fs;Tp=N/Fs;
subplot(3,1,2)
plot(t,yet,'r');grid;
axis([0,Tp/2,-1,1]);xlabel('t/s');ylabel('y_e(t)');
title('�˳���������źŲ���');
 
subplot(3,1,3);
fet=fftshift(fft(yet,2000));
stem(f1-500,abs(fet)/max(abs(fet)),'k.');grid;title('�˳���������ź�Ƶ��');
axis([0,500,0,1]);      %���ÿ̶�  �ұ�
