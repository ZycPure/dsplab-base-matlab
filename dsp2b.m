% T=1/(32*10^3);t=(0:15);
% xn=cos(2*pi*6.5*10^3*t*T)+cos(2*pi*7*10^3*t*T)+cos(2*pi*9*10^3*t*T);
% Xk=fft(xn,16);figure(1);
% subplot(2,1,1);stem(t,xn);grid;
% subplot(2,1,2);stem(t,abs(Xk));grid;

% T=1/(32*10^3);
% t=(0:15);
% xn=cos(2*pi*6.5*10^3*t*T)+cos(2*pi*7*10^3*t*T)+cos(2*pi*9*10^3*t*T);
% n1=0:50;xn1=[xn,zeros(1,35)];Xk1=fft(xn1,51);figure(8);
% subplot(2,1,1);stem(n1,xn1);grid;
% subplot(2,1,2);plot(n1,abs(Xk1));grid;

T=1/(32*10^3);t=(0:50);
xn=cos(2*pi*6.5*10^3*t*T)+cos(2*pi*7*10^3*t*T)+cos(2*pi*9*10^3*t*T);
Xk2=fft(xn,51);figure(9);
subplot(2,1,1);stem(t,xn);grid;
subplot(2,1,2);plot(t,abs(Xk2));grid;