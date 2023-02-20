clc;
clear all;
close all;

[audioIn,fs]= audioread('samples/male.ogg');
f0 = pitch(audioIn,fs);
disp(f0);   %display of all frequencies of the pitch
b=mean(f0); % the value of mean of all frequencies of the pitch
disp(b);     % display the value
if b>165
fprintf("Female Voice");
else
fprintf('Male Voice');
end

%sound(audioIn,fs)

tiledlayout(2,1)

nexttile
t = (0:length(audioIn)-1)/fs;
plot(t,audioIn)
xlabel("Time (s)")
ylabel("Amplitude")
grid minor
axis tight

nexttile
pitch(audioIn,fs)