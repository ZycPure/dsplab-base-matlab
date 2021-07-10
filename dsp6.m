[y1,fs]=audioread('chirp.wav');%原信号
N=length(y1); 
figure(1);
plot(y1);
title( '原语音信号时域波形图' );
xlabel( '单位' );ylabel( '幅度' );
f1= (0:N-1)*fs/N;
y2 = fft (y1,N);
figure(2);
plot( f1, abs(y2) );
axis([-1000 5000 0 3000]);
title( '原语音信号频域波形图' );
xlabel('单位');ylabel('幅度');