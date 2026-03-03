clear all
clc
sub = 1:1;
fs = 512; 
FFT = NaN(98,(10*2*fs)/2+1,length(sub));
for s=1:length(sub)   
   address = ['S0',num2str(sub(s)),'.mat'];
   load(address);  
   sig = zeros(size(EEG.data,1),10*2*EEG.srate,floor(length(EEG.data)/1000));
   for i=1:10:floor(length(EEG.data)/100)
       sig(:,:,i) = EEG.data(:,EEG.data(i).latency:EEG.data(i).latency+10*2*EEG.srate-1);
   end
   % frequency tagging calculation
   sig                 = mean(sig,3,'omitnan');
   sig                 = sig - mean(sig,2);
   freq                = abs(fft(sig')/size(sig,2))';
   freq                = freq(:,1:size(sig,2)/2+1);
   freq(:,2:end-1)     = 2*freq(:,2:end-1);
   f                   = EEG.srate*(0:(size(sig,2)/2))/size(sig,2); 

end