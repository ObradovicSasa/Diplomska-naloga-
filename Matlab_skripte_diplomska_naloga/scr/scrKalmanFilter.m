%% Kalman filter za prvi senzor

%release(F)
F = imufilter;
F.SampleRate = fs;
F.OrientationFormat ='Rotation matrix';
F.AccelerometerNoise = max(var(acc1(nCalStart1:nCalEnd1,:)*9.81));
F.GyroscopeNoise = max(var(omCal1(nCalStart1:nCalEnd1,:)/180*pi));
F.GyroscopeDriftNoise =   2*10^(-9);
F.LinearAccelerationNoise = max(var(acc1(nStart:nEnd, :)))*9.81;
F.LinearAccelerationDecayFactor = 0.25;
[orientation1, angularVelocity1] = F(acc1(nStart:nEnd,:)*9.81,omCal1(nStart:nEnd,:)/180*pi);

%% Kalman za drugi senzor
release(F)
F = imufilter;
F.SampleRate = fs;
F.OrientationFormat ='Rotation matrix';
F.AccelerometerNoise = max(var(acc2(nCalStart2:nCalEnd2,:)*9.81));
F.GyroscopeNoise = max(var(omCal2(nCalStart2:nCalEnd2,:)/180*pi));
F.GyroscopeDriftNoise =    2*10^(-9);
F.LinearAccelerationNoise = max(var(acc2(nStart:nEnd, :)))*9.81;
F.LinearAccelerationDecayFactor = 0.25;
[orientation2, angularVelocity2] = F(acc2(nStart:nEnd,:)*9.81,omCal2(nStart:nEnd,:)/180*pi);

%% Rotacija g-ja po Kalmanu

[orientationPorav1, g1Rot] = fnOrientationPoravnanje(orientation1, g01);
[orientationPorav2, g2Rot] = fnOrientationPoravnanje(orientation2, g02);

%% Primerjava g-jev 

figure;
plot(gCal1, 'b');
hold on
plot(g1Rot, 'g')
xlabel("n")
ylabel("Gravitacijski pospesek(g)")
legend("Kalibriran g", "Rotiran g -> Kalman")
grid on

%% Izracun kotov iz Kalmana (Matlab implementacija!)

gamaKal = atan2(g1Rot(:,2),g1Rot(:,1)); %lahko tudi direkt racunamo z acc1/2, vendar so koti s precej vec suma
betaKal = atan2(g2Rot(:,2),g2Rot(:,1));

alfaKal = (pi + gamaKal - betaKal)*180/pi;


%% Primerjava kota kolenskega kota dolocenega iz Kalmana (Matlab) & iz kalibriranih g-jev

figure;
plot(alfaKal, 'b')
hold on
xlabel("t(s)")
ylabel("Kolesni kot(deg)")

grid on


