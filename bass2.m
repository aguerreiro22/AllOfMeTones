keys = [0, 0, 0, 0, 33, 29, 24, 31, 33, 29, 24, 31, 33, 29, 24, 31, 33, 29, 24, 31, 26, 0, 26, 0, 0, 31, 36, 0, 33, 0, 29, 0, 36, 0, 33, 0, 0, 0, 29, 0, 33, 0, 33, 0];
amps = ones(1,length(keys));
for i = 1:length(keys)
   if keys(i) == 0
      amps(i) = 0;
   end
end
freqs = [];
bpm = 120;
for i = 1:length(keys)
   freqs = [freqs 440*2^((keys(i)-49)/12)];
end
phases = zeros(1,length(keys));
fs = 8000;
tStart = [0];
durs = [240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 30, 930, 30, 210, 480, 240, 30, 450, 30, 450, 30, 930, 30, 450, 30, 180, 30, 240, 30, 930, 30, 930, 30, 1170]/bpm;
for i = 2:length(durs)
   tStart = [tStart, tStart(i-1)+durs(i-1)]; 
end
maxTime = max(tStart+durs) + 0.1; %-- Add time to show signal ending
durLengthEstimate = ceil(maxTime*fs);
tt = (0:durLengthEstimate)*(1/fs); %-- be conservative (add one)
b2 = 0*tt; %--make a vector of zeros to hold the total signal
for kk = 1:length(amps)
    nStart = round(fs*tStart(kk))+1; %-- add one to avoid zero index
    xNew = shortSinus(amps(kk), freqs(kk), phases(kk), fs, durs(kk));
    Lnew = length(xNew);
    nStop = nStart + Lnew-1; %<========= Add code
    b2(nStart:nStop) = b2(nStart:nStop) + xNew;
end
%plotspec(b2,fs,256); grid on