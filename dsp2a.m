% n=0:9;xn=cos(0.48*pi*n)+cos(0.52*pi*n);
% Xk=fft(xn,10);figure(3);
% subplot(2,1,1);stem(n,xn);grid;
% subplot(2,1,2);stem(n,abs(Xk));grid;

% n=0:9;xn=cos(0.48*pi*n)+cos(0.52*pi*n);
% n1=0:14;xn1=[xn,zeros(1,5)];
% n2=0:69;xn2=[xn,zeros(1,50)];
% Xk1=fft(xn1,15);
% Xk2=fft(xn2,70);figure(4);
% subplot(3,1,1);stem(n,xn);grid;
% subplot(3,1,2);stem(n1,abs(Xk1));grid;
% subplot(3,1,3);stem(n2,abs(Xk2));grid;

% n=0:9;xn=cos(0.48*pi*n)+cos(0.52*pi*n);
% n1=0:145;xn3=[xn,zeros(1,135)];
% Xk3=fft(xn3,146);figure(1);
% plot(n1,abs(Xk3));grid;
%
n=0:69;xn=cos(0.48*pi*n)+cos(0.52*pi*n);
Xk=fft(xn,70);figure(1);
subplot(2,1,1);stem(n,xn);grid;
subplot(2,1,2);stem(n,abs(Xk));grid;