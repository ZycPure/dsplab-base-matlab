[y1,fs]=audioread('chirp.wav');%ԭ�ź�
N=length(y1); 
figure(1);
plot(y1);
title( 'ԭ�����ź�ʱ����ͼ' );
xlabel( '��λ' );ylabel( '����' );
f1= (0:N-1)*fs/N;
y2 = fft (y1,N);
figure(2);
plot( f1, abs(y2) );
axis([-1000 5000 0 3000]);
title( 'ԭ�����ź�Ƶ����ͼ' );
xlabel('��λ');ylabel('����');