%% Complementary filter -> DELA! :D

fuse1 = complementaryFilter("SampleRate", fs, "HasMagnetometer", false, "OrientationFormat", "Rotation matrix", "AccelerometerGain", 0.001,"ReferenceFrame", "ENU");


[rot1, angAccel1] = fuse1(acc1(nStart:nEnd,:)*9.81, omCal1(nStart:nEnd, :)/180*pi);
[rot2, angAccel2] = fuse1(acc2(nStart:nEnd,:)*9.81, omCal2(nStart:nEnd, :)/180*pi);

[orientationPoravComp1, g1RotComp] = fnOrientationPoravnanje(rot1, g01);
[orientationPoravComp2, g2RotComp] = fnOrientationPoravnanje(rot2, g02);

gamaComp = atan2(fnDetrend(g1RotComp(:,2)),fnDetrend(g1RotComp(:,1)));
%betaComp = atan2(fnDetrend(g2RotComp(:,2)),fnDetrend(g2RotComp(:,1)));
% gamaComp = atan2(g1RotComp(:,2),g1RotComp(:,1));
betaComp = atan2(g2RotComp(:,2),g2RotComp(:,1));
% gamaComp = (fnDetrend(fnOdstraniPrehod(gamaComp*180/pi)))*pi/180;
 betaComp = (fnDetrend(fnOdstraniPrehod(betaComp*180/pi)))*pi/180;

alfaComp = (pi+gamaComp-betaComp)*180/pi;
alfaComp = fnOdstraniPrehod(alfaComp);
alfaComp = fnDetrend(alfaComp);


figure;
subplot(311)
plot(alfaComp, 'g')
subplot(312)
plot(g1RotComp(:, :))
subplot(313)
plot(g2RotComp(:, :))

