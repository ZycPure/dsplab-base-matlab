I=imread('Lenna.jpg');

fftI=fft2(I);                %二维离散傅立叶变换
sfftI=fftshift(fftI);           %直流分量移到频谱中心
RR=real(sfftI);            %取傅立叶变换的实部
II=imag(sfftI);             %取傅立叶变换的虚部
A=sqrt(RR.^2+II.^2);       %计算频谱幅值
A=(A-min(min(A)))/(max(max(A))-min(min(A)))*225;    %归一化
figure;                   %设定窗口
subplot 121;imshow(I) % 以图形形式显示滤波器
title(' Lenna真实图像')
subplot 122;imshow(A)
title(' 真实图像的频谱')

% I=imread('square.jpg');
% I=rgb2gray(I);
% % imshow(I);               %显示原图像
% fftI=fft2(I);                %二维离散傅立叶变换
% sfftI=fftshift(fftI);           %直流分量移到频谱中心
% RR=real(sfftI);            %取傅立叶变换的实部
% II=imag(sfftI);             %取傅立叶变换的虚部
% A=sqrt(RR.^2+II.^2);       %计算频谱幅值
% A=(A-min(min(A)))/(max(max(A))-min(min(A)))*225;    %归一化
% figure;                   %设定窗口
% subplot 121;imshow(I) % 以图形形式显示滤波器
% title(' 原图像')
% subplot 122;imshow(A)
% title(' 原图像的频谱')

% I=imread('daimond.jpg');
% I=rgb2gray(I);
% % imshow(I);               %显示原图像
% fftI=fft2(I);                %二维离散傅立叶变换
% sfftI=fftshift(fftI);           %直流分量移到频谱中心
% RR=real(sfftI);            %取傅立叶变换的实部
% II=imag(sfftI);             %取傅立叶变换的虚部
% A=sqrt(RR.^2+II.^2);       %计算频谱幅值
% A=(A-min(min(A)))/(max(max(A))-min(min(A)))*225;    %归一化
% figure;                   %设定窗口
% subplot 121;imshow(I) % 以图形形式显示滤波器
% title(' 旋转45°后的图像')
% subplot 122;imshow(A)
% title(' 旋转45°后的图像的频谱')
