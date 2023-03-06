%clc;
close all;
clear all
%% Reading the audio
[y ,Fs]=audioread('samples/female.ogg'); % Read the audio sample (male.ogg | female.ogg)
frame=3500; % Set the frame rate to 3500 for sampling our audio in iden_frame function
%sound(y,Fs);
%% Frequency response of input signal
figure
freqz(y);

%% Parameters for low-pass filters
% 
% Wp - passband, Ws - stopband
Wp =100/(Fs/2);  % = 0.0041(6) 
Ws = 400/(Fs/2); % = 0.01(6)

% level of filter order
nth_b = buttord(Wp,Ws,3,30); %Butterworth
nth_ch1 = cheb1ord(Wp,Ws,3,60); %Chebyshev I
nth_ch2 = cheb2ord(Wp,Ws,3,60); %Chebyshev II
nth_el = ellipord(Wp,Ws,3,60); % Elliptic

%% Find coefficients of each filter
%
% b - nominator coefficients, a - denominator coefficients
[b_ch1,a_ch1]=cheby1(nth_ch1,3,300/(Fs/2));
[b_ch2,a_ch2]=cheby2(nth_ch2,13,300/(Fs/2));
[b_b,a_b]=butter(nth_b,300/(Fs/2));
[b_el,a_el] = ellip(nth_el,3,60,300/(Fs/2));

%% In-built pitch function

f0 = pitch(y,Fs); %identify frequencies for
b=mean(f0); % the value of mean of all frequencies of the pitch

figure
t = (0:length(y)-1)/Fs;
plot(t,y)
xlabel("Time (s)")
ylabel("Amplitude")
grid minor
axis tight


%% Identify the frequency of each frame

butter_filter = iden_frame(y,Fs,b_b,a_b, frame,nth_b);
cheby_filter1 = iden_frame(y,Fs,b_ch1,a_ch1, frame,nth_ch1);
cheby_filter2 = iden_frame(y,Fs,b_ch2,a_ch2, frame,nth_ch2);

elliptic_filter = iden_frame(y,Fs,b_el,a_el, frame,nth_el);

%% Display the final Gender

output(b, "pitch function");
output(mean(freq(y)), "customized pitch function");
output(butter_filter, "butter_filter");
output(cheby_filter1,"cheby_filter" );
output(cheby_filter2,"cheby_filter type-2" );
output(elliptic_filter, "elliptic_filter");

%% Plot frequency responses of each filter
%{
figure;
freqz(b_b,a_b);
figure;
freqz(b_ch1,a_ch1);
figure;
freqz(b_ch2,a_ch2);
figure;
freqz(b_el,a_el);
%}

h_b = fvtool(b_b,a_b);
h_ch = fvtool(b_ch1,a_ch1);
h_ch2 = fvtool(b_ch2,a_ch2);
h_el = fvtool(b_el,a_el);
