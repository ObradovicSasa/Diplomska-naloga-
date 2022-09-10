%% preprosta kalibracija ziroskopa



%[omOffset1, omCal1]   = fnOffset(om1, [nCalStart1 nCalEnd1], [0 0 0]);
omCal1 = om1-omOffset1;
[b1, a1]              = butter(30, 30/fs*2); %butterworth filter


[omOffset2, omCal2]   = fnOffset(om2, [nCalStart2 nCalEnd2], [0 0 0]);
%omCal2 = om2-omOffset2;
[b2, a2]              = butter(30, 30/fs*2);

%% osnovna orientacija vektorja gravitacije
g01                  = mean(acc1(nStart:nStart+20,:));
g02                  = mean(acc2(nStart:nStart+20,:));

%% rotacija vektorja g
[gCal1 , Rot1Cal   ]            = fnRotateG(omCal1(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g01);
[gCal2 , Rot2Cal   ]            = fnRotateG(omCal2(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g02);

fig4 = figure;
subplot(121)
hold on;
plot(acc1(nStart:nEnd,:))
plot(gCal1)
grid on

subplot(122)
hold on;
plot(acc2(nStart:nEnd,:))
plot(gCal2)
grid on


