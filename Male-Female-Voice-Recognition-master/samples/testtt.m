clear all;
close all; 

[y,fs] = audioread('m1.wav');
y = y(:,1); % select one channel
y = highpass(y, 100, fs); % apply high-pass filter to remove low frequency noise
y = normalize(y); % normalize signal

% Extract MFCC features
n_mfcc = 13; % number of MFCC coefficients to extract
mfcc = melcepst(y,fs,'M',n_mfcc); % calculate MFCC coefficients

% Create training data
X = [mfcc(1:50,:) ; mfcc(101:150,:)]; % use first and third sets of 50 MFCC coefficients for training
Y = [ones(50,1) ; zeros(50,1)]; % label first set as male (1) and second set as female (0)

% Train SVM classifier
svm = fitcsvm(X,Y);

% Test classifier on new data
mfcc_test = melcepst(y_test,fs,'M',n_mfcc); % extract MFCC coefficients from new audio signal
label = predict(svm,mfcc_test); % classify new signal as male or female