% clc;clear;close all;
% n = 0:99;
% x = cos(0.48*pi*n) + cos(0.52*pi*n);
% n1 = 0:9;
% y1 = x(1:10);
% subplot(2,1,1)
% stem(n1,y1);
% title('signal x(n), 0 <= n <= 9');
% xlabel('n');ylabel('x(n) over n in [0,9]');
% 
% K = 500;
% k = 0:1:K;
% w = 2*pi*k/K; 
% X = y1*exp(-i*n1'*w);
% magX = abs(X);
% subplot(2,1,2);
% stem(w/pi,magX);
% title('DTFT of x(n) in [0,9]');

clc;clear;
 
n = 0:99;
x = cos(0.48*pi*n) + cos(0.52*pi*n);
 
% zero padding into N = 100
n1 = 0:99;
y1 = [x(1:10),zeros(1,90)];
 
subplot(2,1,1)
stem(n1,y1);
title('signal x(n), 0 <= n <= 99');
xlabel('n');ylabel('x(n) over n in [0,99]');
Y1 = dft(y1,100);
magY1 = abs(Y1);
k1 = 0:1:99;
N = 100;
w1 = (2*pi/N)*k1;
subplot(2,1,2);
stem(w1/pi,magY1);
title('DFT of x(n) in [0,9]');
xlabel('frequency in pi units');