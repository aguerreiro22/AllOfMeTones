keys = [52, 52, 52, 53, 53, 53, 52, 52, 52, 50, 50, 50, 52, 52, 50, 52, 52, 52, 52, 52, 52, 48, 48, 50, 52, 52, 50, 48, 50, 52, 50, 48, 48, 45, 45, 50, 52, 53, 52, 48, 53, 52, 48, 50, 50, 52, 50, 45, 50, 52, 52, 52, 50, 52, 52, 50, 48, 48, 43, 50, 52, 52, 55, 53, 52, 52, 50, 48, 48, 45, 50, 52, 53, 52, 48, 48, 53, 53, 52, 48, 48, 50, 52, 50, 52, 0, 45, 48, 57, 55, 53, 52, 50, 48, 47, 45, 43, 45, 0, 57, 57, 55, 53, 52, 52, 50, 48, 50, 52, 55, 52, 55, 52, 50, 48, 52, 52, 52, 50, 50, 50, 48, 50, 53, 52, 52, 50, 50, 50, 48, 50, 45, 52, 52, 55, 52, 55, 52, 52, 50, 48, 52, 52, 52, 50, 50, 50, 48, 50, 53, 52, 52, 50, 50, 50, 48, 50, 45, 52, 52, 53, 55, 60, 59, 57, 55, 53, 52, 50, 52, 50, 52, 52, 53, 55, 60, 59, 57, 55, 53, 52, 50, 52, 50, 55, 52];
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
durs = [90, 90, 60, 90, 90, 60, 90, 90, 60, 90, 90, 60, 90, 30, 30, 30, 60, 30, 30, 60, 60, 60, 120, 30, 30, 60, 30, 30, 60, 30, 30, 30, 30, 90, 30, 30, 60, 150, 30, 90, 120, 30, 90, 60, 60, 30, 90, 120, 30, 30, 60, 30, 30, 60, 30, 30, 30, 30, 120, 30, 30, 60, 30, 30, 60, 30, 30, 30, 30, 120, 30, 90, 120, 30, 60, 30, 60, 60, 30, 60, 30, 120, 30, 90, 150, 30, 30, 30, 90, 60, 60, 120, 60, 60, 120, 60, 60, 90, 180, 90, 60, 30, 30, 120, 60, 30, 30, 240, 30, 180, 30, 150, 120, 150, 30, 150, 30, 60, 90, 60, 60, 30, 30, 90, 60, 60, 90, 60, 60, 30, 60, 90, 30, 60, 210, 30, 150, 30, 60, 240, 30, 150, 30, 60, 90, 60, 60, 30, 30, 90, 60, 60, 90, 60, 60, 30, 30, 90, 30, 30, 30, 30, 120, 120, 120, 90, 30, 120, 90, 30, 120, 30, 30, 30, 30, 120, 120, 120, 90, 30, 120, 90, 30, 150, 120, 240]/bpm;
for i = 2:length(durs)
   tStart = [tStart, tStart(i-1)+durs(i-1)]; 
end
maxTime = max(tStart+durs) + 0.1; %-- Add time to show signal ending
durLengthEstimate = ceil(maxTime*fs);
tt = (0:durLengthEstimate)*(1/fs); %-- be conservative (add one)
t1 = 0*tt; %--make a vector of zeros to hold the total signal
for kk = 1:length(amps)
    nStart = round(fs*tStart(kk))+1; %-- add one to avoid zero index
    xNew = shortSinus(amps(kk), freqs(kk), phases(kk), fs, durs(kk));
    Lnew = length(xNew);
    nStop = nStart + Lnew-1; %<========= Add code
    t1(nStart:nStop) = t1(nStart:nStop) + xNew;
end
%plotspec(t1,fs,256); grid on