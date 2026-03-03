clear all
clc
sub = 1:1;
fs = 512; 
FFT = NaN(98,(10*2*fs)/2+1,length(sub));
for s=1:length(sub)   
   address = ['S0',num2str(sub(s)),'.mat'];
   load(address);  
   sig = zeros(size(EEG.data,1),10*2*EEG.srate,length(EEG.event)/10);
   for i=1:10:length(EEG.event)/10
       sig(:,:,i) = EEG.data(:,EEG.event(i).latency:EEG.event(i).latency+10*2*EEG.srate-1);
   end
   % frequency tagging calculation
   sig                 = mean(sig,3,'omitnan');
   sig                 = sig - mean(sig,2);
   freq                = abs(fft(sig')/size(sig,2))';
   freq                = freq(:,1:size(sig,2)/2+1);
   freq(:,2:end-1)     = 2*freq(:,2:end-1);
   f                   = EEG.srate*(0:(size(sig,2)/2))/size(sig,2);   

 end

%    % Normalization
%    temp = freq;
%    tmp  = find(f>=.5 & f<=40);
%    tmp  = [tmp(1),tmp(end)];
%    for i=tmp(1):tmp(2)
%        freq(:,i) = temp(:,i) - (mean(temp(:,i-6:i-3),2) + mean(temp(:,i+3:i+6),2))/2;
%    end
%    FFT(:,:,s) = freq;
% end
%% plot averaged frequency tagging over subjects
ch = 3; % select channel
sig = mean(FFT,3,'omitnan');
figure
plot(f,sig(ch,:));
xlim([.75 6])
%% plot frequency tagging of each subject
ch = 9; % select channel
sig = FFT(:,:,1); % select subject;
figure
plot(f,sig(ch,:));
xlim([.75 6]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ERP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear, clc
sub = 1:4;
fs = 512;
erp = NaN(98,2*fs,length(sub));
for s=1:length(sub)   
   address = ['S0',num2str(sub(s)),'.mat'];
   load(address);
   sig = zeros(size(EEG.data,1),2*EEG.srate,length(EEG.event));
   for i=1:length(EEG.event)
       sig(:,:,i) = EEG.data(:,EEG.event(i).latency:EEG.event(i).latency+2*EEG.srate-1);
   end
   erp(:,:,s) = mean(sig,3,'omitnan');
end
%% plot averaged ERP over subjects
ch = 9; % select channel
sig = mean(erp,3,'omitnan');
t = linspace(0,2*fs,length(sig));
figure
plot(t,sig(ch,:));
%% plot ERP of each subject
ch = 9; % select channel
sig = erp(:,:,1); % select subject;
t = linspace(0,2*fs,length(sig));
figure
plot(t,sig(ch,:));



