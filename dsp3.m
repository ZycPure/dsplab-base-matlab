Fs=10000;T=1/Fs;   %����Ƶ��
%�����źŲ�������mstg��������·�����ز������ź���ӹ��ɵĸ����ź�st 
st=mstg;

%��ͨ�˲��������ʵ��

fp=280;fs=450;
wp=2*fp/Fs;ws=2*fs/Fs;rp=0.1;rs=60;   %DFָ�꣨��ͨ�˲�����ͨ������߽�Ƶ��
[N,wp]=ellipord(wp,ws,rp,rs); %����ellipord������ԲDF����N��ͨ����ֹƵ��wp
[B,A]=ellip(N,rp,rs,wp);      %����ellip������Բ��ͨDFϵͳ����ϵ������B��A
y1t=filter(B,A,st);           %�˲������ʵ��
% ��ͨ�˲��������ʵ�ֻ�ͼ����
figure(2);subplot(2,1,1);
myplot(B,A);  %���û�ͼ����myplot������ĺ�������
yt='y_1(t)';
subplot(2,1,2);tplot(y1t,T,yt); %���û�ͼ����tplot�����˲����������
title('��ͨ�˲����������');

%��ͨ�˲��������ʵ��

fpl=440;fpu=560;fsl=275;fsu=900;
wp=[2*fpl/Fs,2*fpu/Fs];ws=[2*fsl/Fs,2*fsu/Fs];rp=0.1;rs=60; 
[N,wp]=ellipord(wp,ws,rp,rs);    %����ellipord������ԲDF����N��ͨ����ֹƵ��wp
[B,A]=ellip(N,rp,rs,wp); %����ellip������Բ��ͨDFϵͳ����ϵ������B��A
y2t=filter(B,A,st);     %�˲������ʵ��
% ��ͨ�˲��������ʵ�ֻ�ͼ����
figure(3);subplot(2,1,1);
myplot(B,A);  %���û�ͼ����myplot������ĺ�������
yt='y_2(t)';
subplot(2,1,2);tplot(y2t,T,yt);
title('��ͨ�˲����������');

%��ͨ�˲��������ʵ��

fp=890;fs=600;
wp=2*fp/Fs;ws=2*fs/Fs;rp=0.1;rs=60;   %DFָ�꣨��ͨ�˲�����ͨ������߽�Ƶ��
[N,wp]=ellipord(wp,ws,rp,rs);    %����ellipord������ԲDF����N��ͨ����ֹƵ��wp
[B,A]=ellip(N,rp,rs,wp,'high');  %����ellip������Բ��ͨDFϵͳ����ϵ������B��A
y3t=filter(B,A,st);     %�˲������ʵ��
% ��ͨ�˲��������ʵ�ֻ�ͼ����
figure(4);subplot(2,1,1)
myplot(B,A)  %���û�ͼ����myplot������ĺ�������
y3t=filter(B,A,st);
yt='y_3(t)';
subplot(2,1,2);tplot(y3t,T,yt);
title('��ͨ�˲����������');