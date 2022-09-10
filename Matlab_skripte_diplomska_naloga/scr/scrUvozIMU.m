%% Uvoz podatkov
ACCDATA_1      = readtable('data/23082022/IMU/M3/3_2022-08-23T15.16.45.584_DDBF59C1DA86_Accelerometer.csv');
GYRODATA_1     = readtable('data/23082022/IMU/M3/3_2022-08-23T15.16.45.584_DDBF59C1DA86_Gyroscope.csv');
ACCDATA_2      = readtable('data/23082022/IMU/M3/2_2022-08-23T15.16.45.584_E085FC57C781_Accelerometer.csv');
GYRODATA_2     = readtable('data/23082022/IMU/M3/2_2022-08-23T15.16.45.584_E085FC57C781_Gyroscope.csv');

fs = 100; %frekvenca vzorcenja

[acc1, om1, acc2, om2, t] = fnSyncAccOmMW2S(ACCDATA_1, GYRODATA_1, ACCDATA_2, GYRODATA_2, fs);


%% Plot posnetkov senzorjev

figure;
subplot(211),plot(t/60,acc1,t/60, acc2)
xlabel("t [min]")
ylabel("Pospeskometri [g]")
grid on

subplot(212),plot(t/60,om1, t/60, om2)
xlabel("t [min]")
ylabel("Ziroskopi [deg/s]")
grid on