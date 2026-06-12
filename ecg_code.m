% ECG Signal Analysis and Noise Filtering
% Author: Beema Shahana Shiyad

%% Load ECG Data
ecg = readmatrix('ecg.csv');

% If the file has multiple columns, use the first column
if size(ecg,2) > 1
    ecg = ecg(:,1);
end

%% Plot Original ECG Signal
figure;
plot(ecg,'b');
title('Original ECG Signal');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;

%% Add Gaussian Noise
noise = 0.1 * randn(size(ecg));
noisy_ecg = ecg + noise;

%% Plot Original vs Noisy ECG
figure;
plot(ecg,'b');
hold on;
plot(noisy_ecg,'r');
title('Original vs Noisy ECG');
xlabel('Sample Number');
ylabel('Amplitude');
legend('Original ECG','Noisy ECG');
grid on;

%% Apply Moving Average Filter
filtered_ecg = movmean(noisy_ecg,5);

%% Butterworth Filter

Fs = 360;          % Sampling frequency
Fc = 40;           % Cutoff frequency

[b,a] = butter(4, Fc/(Fs/2), 'low');

butter_ecg = filtfilt(b,a,noisy_ecg);

%% Moving Average vs Butterworth Comparison

figure;

plot(ecg,'b');
hold on;

plot(filtered_ecg,'g');

plot(butter_ecg,'m');

title('Moving Average vs Butterworth Filter');

xlabel('Sample Number');

ylabel('Amplitude');

legend('Original ECG','Moving Average','Butterworth');

grid on;

%% Plot Filtered ECG
figure;
plot(filtered_ecg,'g');
title('Filtered ECG');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;
%% Filter Comparison

filtered_5 = movmean(noisy_ecg,5);
filtered_10 = movmean(noisy_ecg,10);
filtered_15 = movmean(noisy_ecg,15);

figure;
plot(ecg,'b');
hold on;
plot(filtered_5,'g');
plot(filtered_10,'m');
plot(filtered_15,'k');

title('Comparison of Different Filter Window Sizes');
xlabel('Sample Number');
ylabel('Amplitude');

legend('Original','Window=5','Window=10','Window=15');
grid on;

%% Compare Original, Noisy, and Filtered Signals
figure;
plot(ecg,'b');
hold on;
plot(noisy_ecg,'r');
plot(filtered_ecg,'g');

title('ECG Signal Analysis and Noise Filtering');
xlabel('Sample Number');
ylabel('Amplitude');

legend('Original ECG','Noisy ECG','Filtered ECG');
grid on;

%% R-Peak Detection

[pks, locs] = findpeaks(butter_ecg, ...
    'MinPeakHeight', 0.2, ...
    'MinPeakDistance', 200);

figure;
plot(butter_ecg,'b');
hold on;

plot(locs,pks,'ro','MarkerFaceColor','r');

title('R-Peak Detection');

xlabel('Sample Number');
ylabel('Amplitude');

legend('Filtered ECG','Detected R-Peaks');

grid on;

%% Heart Rate Calculation

Fs = 360;

RR_intervals = diff(locs)/Fs;

heart_rate = 60/mean(RR_intervals);

fprintf('Number of R-Peaks Detected = %d\n',length(locs));
fprintf('Average Heart Rate = %.2f BPM\n',heart_rate);

%% FFT Analysis

Fs = 360;

N = length(ecg);

f = (0:N-1)*(Fs/N);

fft_ecg = abs(fft(ecg));

figure;

subplot(2,1,1);
plot(ecg);
title('ECG Signal (Time Domain)');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(f(1:floor(N/2)),fft_ecg(1:floor(N/2)));

title('ECG Signal Spectrum (Frequency Domain)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
