%% Complementary filter -> DELA! :D

fuse1 = complementaryFilter("SampleRate", fs, "HasMagnetometer", false, "OrientationFormat", "Rotation matrix", "AccelerometerGain", 0.05);



[rot1, angAccel1] = fuse1(acc1(nStart:nEnd,:), omCal1(nStart:nEnd, :)/180*pi);
[rot2, angAccel2] = fuse1(acc2(nStart:nEnd,:), omCal2(nStart:nEnd, :)/180*pi);

[orientationPoravComp1, g1RotComp] = fnOrientationPoravnanje(rot1, g01);
[orientationPoravComp2, g2RotComp] = fnOrientationPoravnanje(rot2, g02);

gamaComp = atan2(g1RotComp(:,2),g1RotComp(:,1));
betaComp = atan2(g2RotComp(:,2),g2RotComp(:,1));

alfaComp = (pi-abs(gamaComp)-betaComp)*180/pi;

alfaComp = alfaComp(zamik:end);


alfaCompEnosmerna = mean(alfaComp(1:200));
alfaCompdetrend = detrend(alfaComp,1);
alfaCompEnosmerna = alfaCompEnosmerna-mean(alfaCompdetrend(1:200));
alfaCompdetrend = alfaCompdetrend+alfaCompEnosmerna;



figure;hold on
plot(alfaCalVsklajen)
plot(alfaComp, 'g')
plot(alfaCompdetrend)

alfaComp = alfaCompdetrend;
