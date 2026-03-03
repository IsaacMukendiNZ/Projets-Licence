clc 
close all
clear all
load Eye_Movement.mat U D BL DBL LF RT
load EEG_EO.mat EEG_YO Fs;
figure
subplot(321)
plot(U)
title('UP')
subplot(322)
plot(D)
title('Down')
subplot(323)
plot(BL)
title('Blink')
subplot(324)
plot(DBL)
title('Double Blink')
subplot(325)
plot(LF)
title('Left')
subplot(326)
plot(RT)
title('Right')
%%SUPPERPOSER LES PEV SUR LE EEG 


X=EEG_YO 
X=X/max(max(X));
%%%
NF=2;
Fc1=0.5;%%% frequence de coupure 
Fc2=30;%%% frequence de coupure  
Wn1=2*Fc1/Fs; 
Wn2=2*Fc2/Fs; %%%
%%% filtre passe bande 
[B, A] = butter(NF, [Wn1 Wn2]); % Design a bandpass Butterworth filter

Xf = filtfilt(B, A, X)'; % Apply the filter to the signal

figure
signalplot(Xf',Fs)

SCH=10;
AT=DBL;
DL=length(AT);
Ti=2;
Xf(Ti*Fs:Ti*Fs+DL-1,SCH)=Xf(Ti*Fs+DL-1,SCH)+AT'

NCH=size(Xf,2);
DL=length(Xf);
template=AT;

CM_Sig=[];
for k=1:NCH
    [PsC_s,best_lag] = PsC(template,Xf(:,k),DL);
    CM_Sig(:,k)=zeros(DL,1);
    if PsC_s~=0
        CM_Sig(best_lag,k)=10;
    end
end

figure
signalplot(Xf',Fs)
title('SORTIE ARTEFACT')
figure
signalplot(CM_Sig',Fs)
title('COMMANDE')