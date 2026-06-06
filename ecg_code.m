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