%Signal Generation


%% Signal Parameters
fs = 2500;         %sampling frequeny in hz
t = 0: 1/fs : 0.6;    %time axis

fm =10;
Am = 1.2;

fc = 100;           %carrier frequency in hz
Ac = 1;             %carrier Amplitude A
kp = 15;             %phase constant val

%% Signal Definition
m_t = generateMessage(t,Am,fm);
PM = PMGenerator(t,m_t,kp,Ac,fc);


%% Fourier Transform 
m_f = fft(m_t);
PM_f = fft(PM);

%% Signal Generation Plot
figure;
subplot(2,1,1);
plot(t,m_t);
xlabel('TIme (s)');
title('Message Signal');

subplot(2,1,2);
plot(t,PM);
xlabel('TIme (s)');
ylabel('PM Signal');
title('PM Modulated Signal');


% Fourier Plot 
figure;
N = length(PM);
f = (0:N/2 +1) * (fs/N);

subplot(2,1,1);
plot(f,abs(m_f(1:round(N/2)+1)));
xlabel('Freq (Hz)');
title('Frequency Domain oF Message Signal');

subplot(2,1,2);
plot(f,abs(PM_f(1:round(N/2 +1))));
xlabel('Freq (Hz)');
title('Frequency Domain oF PM Signal');