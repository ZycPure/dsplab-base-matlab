I=imread('Lenna.jpg');

fftI=fft2(I);                %��ά��ɢ����Ҷ�任
sfftI=fftshift(fftI);           %ֱ�������Ƶ�Ƶ������
RR=real(sfftI);            %ȡ����Ҷ�任��ʵ��
II=imag(sfftI);             %ȡ����Ҷ�任���鲿
A=sqrt(RR.^2+II.^2);       %����Ƶ�׷�ֵ
A=(A-min(min(A)))/(max(max(A))-min(min(A)))*225;    %��һ��
figure;                   %�趨����
subplot 121;imshow(I) % ��ͼ����ʽ��ʾ�˲���
title(' Lenna��ʵͼ��')
subplot 122;imshow(A)
title(' ��ʵͼ���Ƶ��')

% I=imread('square.jpg');
% I=rgb2gray(I);
% % imshow(I);               %��ʾԭͼ��
% fftI=fft2(I);                %��ά��ɢ����Ҷ�任
% sfftI=fftshift(fftI);           %ֱ�������Ƶ�Ƶ������
% RR=real(sfftI);            %ȡ����Ҷ�任��ʵ��
% II=imag(sfftI);             %ȡ����Ҷ�任���鲿
% A=sqrt(RR.^2+II.^2);       %����Ƶ�׷�ֵ
% A=(A-min(min(A)))/(max(max(A))-min(min(A)))*225;    %��һ��
% figure;                   %�趨����
% subplot 121;imshow(I) % ��ͼ����ʽ��ʾ�˲���
% title(' ԭͼ��')
% subplot 122;imshow(A)
% title(' ԭͼ���Ƶ��')

% I=imread('daimond.jpg');
% I=rgb2gray(I);
% % imshow(I);               %��ʾԭͼ��
% fftI=fft2(I);                %��ά��ɢ����Ҷ�任
% sfftI=fftshift(fftI);           %ֱ�������Ƶ�Ƶ������
% RR=real(sfftI);            %ȡ����Ҷ�任��ʵ��
% II=imag(sfftI);             %ȡ����Ҷ�任���鲿
% A=sqrt(RR.^2+II.^2);       %����Ƶ�׷�ֵ
% A=(A-min(min(A)))/(max(max(A))-min(min(A)))*225;    %��һ��
% figure;                   %�趨����
% subplot 121;imshow(I) % ��ͼ����ʽ��ʾ�˲���
% title(' ��ת45����ͼ��')
% subplot 122;imshow(A)
% title(' ��ת45����ͼ���Ƶ��')
