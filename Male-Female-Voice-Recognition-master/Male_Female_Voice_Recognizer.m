clc;close all;
clear all
%% Reading the audio
[y ,Fs]=audioread('samples/male.ogg'); % Read the audio sample (male.ogg | female.ogg)
frame=3500; % Set the frame rate to 3500
n = 3;  % nth order (3 is optimum value, the other values may lead to inaccuracy)

%% Frequency response of input signal
figure
freqz(y);

figure
freqss = freq(y);
%% Find coefficients of each filter
[b0_ch,a0_ch]=cheby1(n-1,3,260/(Fs/2));
[b0_b,a0_b]=butter(n-1,260/(Fs/2));% Get the coefficient of the filter matrix
[b0_el,a0_el] = ellip(n-1,10,50,260/(Fs/2));

%% In-built pitch function

f0 = pitch(y,Fs);
b=mean(f0); % the value of mean of all frequencies of the pitch

figure
tiledlayout(2,1)

nexttile
t = (0:length(y)-1)/Fs;
plot(t,y)
xlabel("Time (s)")
ylabel("Amplitude")
grid minor
axis tight

nexttile
pitch(y,frame);

%% Plot frequency responses of each filter

figure
freqz(b0_b, a0_b);
figure
freqz(b0_ch, a0_ch);
figure
freqz(b0_el, a0_el);

%% Identify the frequency of each frame

butter_filter = iden_frame(y,Fs,b0_b,a0_b, frame,n);
cheby_filter = iden_frame(y,Fs,b0_ch,a0_ch, frame,n);
elliptic_filter = iden_frame(y,Fs,b0_el,a0_el, frame,n);

%% Display the final Gender

output(b, "pitch function");
output(mean(freq(y)), "customized pitch function");
output(butter_filter, "butter_filter");
output(cheby_filter,"cheby_filter" );
output(elliptic_filter, "elliptic_filter");



