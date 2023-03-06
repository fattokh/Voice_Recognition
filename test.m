fc = 300;
fs = 1000;

[b,a] = cheby2(6,50,fc/(fs/2));

freqz(b,a,[],fs)
fvtool(b,a);
subplot(2,1,1)
ylim([-100 20])