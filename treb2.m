keys = [45, 45, 45, 45, 45, 45, 43, 43, 43, 47, 47, 47, 45, 45, 0, 45, 45, 0, 45, 43, 0, 43, 0, 0, 0, 48, 0, 48, 43, 0, 43, 0, 0, 43, 48, 0, 41, 0, 0, 50, 0, 43, 0, 0, 48, 0, 48, 0, 43, 0, 45, 0, 48, 48, 0, 0, 48, 0, 48, 45, 0, 45, 0, 45, 0, 45, 45, 0, 45, 0, 47, 0, 0, 45, 45, 0, 52, 52, 53, 48, 0, 43, 43, 43, 43, 0, 52, 52, 53, 48, 0, 43, 43, 43, 43, 48, 45];
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
durs = [90, 90, 60, 90, 90, 60, 90, 90, 60, 90, 90, 60, 90, 30, 60, 60, 30, 150, 60, 120, 120, 30, 210, 240, 120, 30, 90, 120, 30, 90, 60, 180, 180, 60, 30, 150, 30, 30, 240, 30, 150, 30, 30, 240, 120, 120, 60, 180, 120, 120, 150, 90, 90, 60, 810, 720, 150, 180, 120, 180, 30, 150, 90, 90, 180, 90, 60, 60, 90, 300, 30, 810, 510, 90, 60, 540, 120, 120, 120, 90, 30, 120, 90, 30, 120, 120, 120, 120, 120, 90, 30, 120, 90, 30, 150, 120, 240]/bpm;
for i = 2:length(durs)
   tStart = [tStart, tStart(i-1)+durs(i-1)]; 
end
maxTime = max(tStart+durs) + 0.1; %-- Add time to show signal ending
durLengthEstimate = ceil(maxTime*fs);
tt = (0:durLengthEstimate)*(1/fs); %-- be conservative (add one)
t2 = 0*tt; %--make a vector of zeros to hold the total signal
for kk = 1:length(amps)
    nStart = round(fs*tStart(kk))+1; %-- add one to avoid zero index
    xNew = shortSinus(amps(kk), freqs(kk), phases(kk), fs, durs(kk));
    Lnew = length(xNew);
    nStop = nStart + Lnew-1; %<========= Add code
    t2(nStart:nStop) = t2(nStart:nStop) + xNew;
end
%plotspec(t2,fs,256); grid on