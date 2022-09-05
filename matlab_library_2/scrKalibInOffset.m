%% preprosta kalibracija ziroskopa

%nCalStart1 = 1;
%nCalEnd1 = fnVelikostIntZaSum(om1, 25);
%nCalStart1 = 6642;
%nCalEnd1   = 7154;

[omOffset1, omCal1]   = fnOffset(om1, [nCalStart1 nCalEnd1], [0 0 0]);

% omOffset1 = [-0.989916950973286,0.511556598732197,-0.255144677699547];
% omOffset2 = [0.075776278813779,0.123175117809146,0.040355330549081];
% omCal1 = om1-omOffset1;

[b1, a1]              = butter(30, 30/fs*2); %butterworth filter
omCal1               = filtfilt(b1, a1, omCal1); %zero-faze digital filltering
acc1               = filtfilt(b1, a1, acc1);

%nCalStart2 = 1;
%nCalEnd2 = nCalEnd1;
%nCalStart2 = 6644;
%nCalEnd2   = 6958;

[omOffset2, omCal2]   = fnOffset(om2, [nCalStart2 nCalEnd2], [0 0 0]);

%omCal2 = om2-omOffset2;

[b2, a2]              = butter(30, 30/fs*2);
omCal2               = filtfilt(b2, a2, omCal2);
acc2               = filtfilt(b2, a2, acc2);

%% Startni in koncni interval za IMU meritve

%nStart = fnVelikostIntZaOffset(om1, 250);
%nEnd = length(om1);
%nStart = 7048; 
%nEnd   = 66433;

%% osnovna orientacija vektorja gravitacije
g01                  = mean(acc1(nStart:nStart+20,:));
g02                  = mean(acc2(nStart:nStart+20,:));


%% basic filtriranje meritev ziroskopa

om2Filt = lowpass(om2, 0.1, fs);
om1Filt = lowpass(om1, 0.1, fs);

%% rotacija vektorja g
[g1    , Rot1      ]            = fnRotateG(om1(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g01);
[g1Filt, Rot1Filt  ]            = fnRotateG(om1Filt(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g01);
[gCal1 , Rot1Cal   ]            = fnRotateG(omCal1(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g01);

[g2    , Rot2      ]            = fnRotateG(om2(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g02);
[g2Filt, Rot2Filt  ]            = fnRotateG(om2Filt(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g02);
[gCal2 , Rot2Cal   ]            = fnRotateG(omCal2(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g02);

%1->desno koleno
%2->desno stopalo

fig4 = figure;
plot(t(nStart:nEnd-1),gCal1/1,t(nStart:nEnd-1),gCal2/1)
legend("x-1","y-1","z-1", "x-2","y-2","z-2")
title("Vsi senzorji skupaj")
grid on

% figure; 
% plot(gCal2)

