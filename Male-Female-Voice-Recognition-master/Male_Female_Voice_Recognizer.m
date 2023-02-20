clc;close all;
%clear all
%% Reading the audio
[y ,Fs]=audioread('samples/male.ogg'); % Read the audio sample
frame=3500; % Set the frame rate
freqz(y);

% Plot the frequency response of the filtered signal

[b0,a0]=mybutter(350/(Fs/2)); % Get the coefficient of the filter matrix
%freqz(b0, a0);

%% In-built pitch function

f0 = pitch(audioIn,Fs);
%disp(f0);   %display of all frequencies of the pitch
b=mean(f0); % the value of mean of all frequencies of the pitch
%disp(b);     % display the value


%% Identify the frequency of each frame
for i=1:length(y)/frame
    x=y(1+(i-1)*frame:i*frame);
    xin = abs(x);
    xin=myfilter(b0,a0,xin);    
    xin = xin-mean(xin);   
    x_out(1+(i-1)*frame:i*frame,1)=xin;
    x2=zeros(length(xin),1);
    x2(1:length(x)-1)=xin(2:length(x));
    zc=length(find((xin>0 & x2<0) | (xin<0 & x2>0)));
    F0(i)=0.5*Fs*zc/length(x);
    
end
Fx=mean(F0); % Take mean of all the frequency for each frame

%% Display the output frequency
 % Use the function freq to find the frequency
fprintf('Estimated frequency by in-built function is %3.2f Hz.\n', ...
    mean(freq(y)));

%% Display the final Gender


if b>165
inbuilt = "Female Voice";
else
inbuilt = 'Male Voice';
end
fprintf('In-built pitch function: %s \n ', inbuilt);
 



disp("mean(F0)")
if Fx>165   % set the threshold
    meanF0 = 'Female Voice';
else
    meanF0 = 'Male Voice';

end
fprintf(' Estimated frequency (Fx=mean(F0)) is %3.2f Hz.\n',Fx);



disp("(mean(freq(y))))")
if mean(freq(y))>165   % set the threshold
    fprintf('Female Voice\n');
else
    fprintf('Male Voice\n');

end