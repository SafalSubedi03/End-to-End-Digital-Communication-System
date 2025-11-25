%Signal Generation


%% Signal Parameters
fs = 10000;          %sampling frequeny in hz
t = 0: 1/fs : 1;    %time axis

fm = 10;
Am = 2;

fc = 500;           %carrier frequency in hz
Ac = 2;             %carrier Amplitude A


%% Signal Definition
m_t = generateMessage(t,Am,fm);
c_t = carrierSignal(t,fc);
AM  = modulatedSignal(Ac,m_t,c_t);

%% Fourier Transform 
m_f = fft(m_t);
c_f = fft(c_t);
AM_f = fft(AM);

%% Signal Generation Plot
figure;
subplot(3,1,1);
plot(t,m_t);
xlabel('TIme (s)');
title('Message Signal');

subplot(3,1,2);
plot(t,c_t);
xlabel('TIme (s)');
title('Carrier Signal With A = 1');

subplot(3,1,3);
plot(t,AM);
xlabel('TIme (s)');
ylabel('AM Signal');
title('AM Modulated Signal');


% Fourier Plot 
figure;
N = length(AM);
f = (0:N/2 +1) * (fs/N);

subplot(3,1,1);
plot(f,abs(m_f(1:round(N/2 +1))));
xlabel('Freq (Hz)');
title('Frequency Domain oF Message Signal');

subplot(3,1,2);
plot(f,abs(c_f(1:round(N/2 +1))));
xlabel('Freq (Hz)');
title('Frequency Domain oF Carrier Signal');

subplot(3,1,3);
plot(f,abs(AM_f(1:round(N/2 +1))));
xlabel('Freq (Hz)');
title('Frequency Domain oF AM Signal');
 
%% Noise Simulation 
NoiseInDb = 20;
AM_W_Noise = awgn(AM,NoiseInDb,'measured');

%Noise Plot
figure;
plot(t,AM_W_Noise);
xlabel('Time (s)');
title('AM signal with Noise');



%% Demodulation - Using Edge Detection

Rectified_AM_W_Noise = HalfRectification(AM_W_Noise);
figure;
plot(t,Rectified_AM_W_Noise)
xlabel('Time');
title('Rectified Wave');

% Chebyshev Filter Approximation
fcutoff = 20; %in Hz
filterOrder = 4;
Rp = 1; %passband ripple in db

%Normalized cutoff freq
wn = fcutoff / (fs/2);

[num,den] = cheby1(filterOrder,Rp,wn,'low');

Filtered_Rectified_AM_W_Noise = filter(num,den,Rectified_AM_W_Noise);

figure;
plot(t, m_t, 'b', 'LineWidth', 1.5);                        % Original message
hold on;
plot(t, Filtered_Rectified_AM_W_Noise, 'r', 'LineWidth', 1.5);  % Demodulated signal
hold off;

xlabel('Time (s)');
ylabel('Amplitude');
title('Original Message vs Demodulated AM Signal');
legend('Original Message', 'Demodulated Signal');
grid on;




