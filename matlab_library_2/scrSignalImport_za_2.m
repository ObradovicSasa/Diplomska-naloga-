%% Vkljucitev datotek
addpath(genpath('lib'));%za zapiranje vseh slik v command vrstici close all
addpath(genpath('data'));

%% Poskus dolocanja kota prek qualisys motion tracking sistema
RPYs2 = (squeeze(Measurement12.RigidBodies.RPYs(3,:,:)))'; % RPY spodnjega markerja
RPYz1 = (squeeze(Measurement12.RigidBodies.RPYs(4,:,:)))'; % RPY zgornjega markerja

POZs2 = (squeeze(Measurement12.RigidBodies.Positions(3,:,:)))';
POZz1 = (squeeze(Measurement12.RigidBodies.Positions(4,:,:)))';

RotZ1 = [Measurement12.RigidBodies.Rotations(4,1:3,:); Measurement12.RigidBodies.Rotations(4,4:6,:); Measurement12.RigidBodies.Rotations(4,7:9,:) ];
RotS2 = [Measurement12.RigidBodies.Rotations(3,1:3,:); Measurement12.RigidBodies.Rotations(3,4:6,:); Measurement12.RigidBodies.Rotations(3,7:9,:) ];
% ^ Rotacijski matriki za zgornji in spodnji koordinatni sistem ^

fsQ = Measurement12.FrameRate; % frekvenca vzorcenja 
tQ = (1:length(RPYz1))/fsQ; % cas poteka posnetka

figure;
plot(tQ, (-RPYs2(:,3)-RPYz1(:,3)))
hold on
plot(tQ, (-RPYs2(:,2)-RPYz1(:,2)))
hold on
plot(tQ, (-RPYs2(:,1)-RPYz1(:,1)))

%% Pozicijske meritve iz qualisys-a

figure;
plot(tQ, POZz1)
hold on
plot(tQ, POZs2)

%% Poskus rotacijske matrike -> iz pozicij vendar ne dela :(
R = zeros(4,4,length(POZz1));
R(4, 4, :) = 1;
A = eye(4, 4);
B = eye(4, 4);

for i = 1:length(POZz1)-1
    A(1:3, 4) = POZz1(i, :);
    B(1:3, 4) = POZz1(i+1, :);
    R(:,:,i) = B*(inv(A));

end


%% Uvoz podatkov
ACCDATA_1      = readtable('data/KotKolenaLab04032022/7_acc.csv');
GYRODATA_1     = readtable('data/KotKolenaLab04032022/7_gyro.csv');
ACCDATA_2      = readtable('data/KotKolenaLab04032022/8_acc.csv');
GYRODATA_2     = readtable('data/KotKolenaLab04032022/8_gyro.csv');

fs = 100; %frekvenca vzorcenja

[acc1, om1, acc2, om2, t] = fnSyncAccOmMW2S(ACCDATA_1, GYRODATA_1, ACCDATA_2, GYRODATA_2, fs);
%% Plot posnetkov senzorjev

figure;
subplot(211),plot(t/60,acc1,t/60, acc2)
subplot(212),plot(t/60,om1, t/60, om2)

%% eliminacija previsokih vrednosti, ki popacijo meritev -> nepotrebno zaenkrat
for i = 1:size(acc1, 2)
    acc1(:,i) = medfilt1(acc1(:,i), 4);
    acc2(:,i) = medfilt1(acc2(:,i), 4);
end

for i = 1:size(om1, 2)
    om1(:,i) = medfilt1(om1(:,i), 4);
    om2(:,i) = medfilt1(om2(:,i), 4);
end

figure;
subplot(211),plot(t/60,acc1,t/60, acc2)
subplot(212),plot(t/60,om1, t/60, om2)
%% Markerji za zacetek signalov + odstevanje offseta :D


%prvi dve tocki sta za kalibracijo, drugi dve pa za zajem signala
fig1 = figure;
subplot(211),plot(acc1)
subplot(212),plot(om1)
[x1, y1] = ginput(4);
x1 = round(x1);
close(fig1)
nCalStart1    = x1(1); nCalEnd1    = x1(2);%odrezi majhno variacijo signala aka gravitacijska komponenta
nStart       = x1(3); nEnd       = x1(4); %zacetek in konec signala

fig2 = figure;
subplot(211),plot(acc2)
subplot(212),plot(om2)
[x2, y2] = ginput(2);
x2 = round(x2);
close(fig2)
nCalStart2    = x2(1); nCalEnd2    = x2(2);

%% preprosta kalibracija ziroskopa
[omOffset1, omCal1]   = fnOffset(om1, [nCalStart1 nCalEnd1], [0 0 0]);
[b1, a1]              = butter(30, 30/fs*2); %butterworth filter
omCal1               = filtfilt(b1, a1, omCal1); %zero-faze digital filltering
acc1               = filtfilt(b1, a1, acc1);

[omOffset2, omCal2]   = fnOffset(om2, [nCalStart2 nCalEnd2], [0 0 0]);
[b2, a2]              = butter(30, 30/fs*2);
omCal2               = filtfilt(b2, a2, omCal2);
acc2               = filtfilt(b2, a2, acc2);


%% osnovna orientacija vektorja gravitacije
g01                  = mean(acc1(nStart:nStart+20,:));
g02                 = mean(acc2(nStart:nStart+20,:));

%% rotacija vektorja g
g1                   = fnRotateG(om1(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g01);
gCal1                = fnRotateG(omCal1(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g01);
%fnPlotGOrient(t(nStart:nEnd), acc1(nStart:nEnd,:) , g1, gCal1, 1);%jade-->x , burgundy-->y, indigo-->z

g2                   = fnRotateG(om2(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g02);
gCal2                = fnRotateG(omCal2(nStart:nEnd,:)./180*pi, t(nStart:nEnd), g02);
%fnPlotGOrient(t2(nStart:nEnd), acc2(nStart:nEnd,:) , g2, gCal2, 0);%jade-->x , burgundy-->y, indigo-->z

%1->desno koleno
%2->desno stopalo

fig4 = figure;
subplot(211),plot(t(nStart:nEnd),gCal1/1,t(nStart:nEnd),gCal2/1)
legend("x-1","y-1","z-1", "x-2","y-2","z-2")
title("Vsi senzorji skupaj")
grid on


%% Complementary filter -> DELA! :D

fuse1 = complementaryFilter("SampleRate", fs, "HasMagnetometer", false, "OrientationFormat", "Rotation matrix", "AccelerometerGain", 0.5);



rot1 = fuse1(acc1(nStart:nEnd,:), omCal1(nStart:nEnd, :)/180*pi);
rot2 = fuse1(acc2(nStart:nEnd,:), omCal2(nStart:nEnd, :)/180*pi);

[orientationPoravComp1, g1RotComp] = fnOrientationPoravnanje(rot1, g01);
[orientationPoravComp2, g2RotComp] = fnOrientationPoravnanje(rot2, g02);

gamaComp = atan2(g1RotComp(:,2),g1RotComp(:,1));
betaComp = atan2(g2RotComp(:,2),g2RotComp(:,1));

alfaComp = (-gamaComp-betaComp)*180/pi;


figure;
plot(t(nStart:nEnd)/60, alfaComp, 'g')
hold on

%% Dolocanje kota iz ciste geometrije -> gledamo le porjekciji vektorja g na x in y osi ;)

gama = atan2(acc1(nStart:nEnd,2),acc1(nStart:nEnd,1)); %lahko tudi direkt racunamo z acc1/2, vendar so koti s precej vec suma
beta = atan2(acc2(nStart:nEnd,2),acc2(nStart:nEnd,1));


alfa = (- gama - beta)*180/pi;


%% basic filtriranje meritev pospeskometra

acc2Filt = lowpass(acc2, 1, fs);
acc1Filt = lowpass(acc1, 1, fs);


%% Dolocanje kota iz pospeskometra -> basic filtracija

betaFilt = atan2(acc2Filt(nStart:nEnd, 2), acc2Filt(nStart:nEnd, 1));
gamaFilt = atan2(acc1Filt(nStart:nEnd,2),acc1Filt(nStart:nEnd,1));

alfaFilt = (- gamaFilt - betaFilt)*180/pi;

%% Dolocanje kota iz kalibrirane g komponenta -> odstet startni offset

betaCal = atan2(gCal2(:, 2), gCal2(:, 1));
gamaCal = atan2(gCal1(:,2), gCal1(:,1));

alfaCal = (- gamaCal - betaCal)*180/pi;

%% Plotanje kota dolocenega iz geometrije

plot(alfa, 'g')
hold on
plot(alfaFilt, 'b')
hold on
plot(alfaCal, 'r')

%% Kalman filter za prvi senzor

%release(F)
F = imufilter;
F.SampleRate = fs;
F.OrientationFormat ='Rotation matrix';
F.AccelerometerNoise = max(var(acc1(nCalStart1:nCalEnd1,:)*9.81));
F.GyroscopeNoise = max(var(omCal1(nCalStart1:nCalEnd1,:)/180*pi));
%F.GyroscopeDriftNoise
F.LinearAccelerationNoise = F.AccelerometerNoise*10;
F.LinearAccelerationDecayFactor = 0.25;
[orientation1, angularVelocity1] = F(acc1(nStart:nEnd,:)*9.81,omCal1(nStart:nEnd,:)/180*pi);

%% Kalman za drugi senzor

F = imufilter;
F.SampleRate = fs;
F.OrientationFormat ='Rotation matrix';
F.AccelerometerNoise = max(var(acc2(nCalStart2:nCalEnd2,:)*9.81));
F.GyroscopeNoise = max(var(omCal2(nCalStart2:nCalEnd2,:)/180*pi));
%F.GyroscopeDriftNoise
F.LinearAccelerationNoise = F.AccelerometerNoise*10;
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

%% Izracun kotov iz Kalmana (Matlab implementacija!)

gamaKal = atan2(g1Rot(:,2),g1Rot(:,1)); %lahko tudi direkt racunamo z acc1/2, vendar so koti s precej vec suma
betaKal = atan2(g2Rot(:,2),g2Rot(:,1));

alfaKal = (- gamaKal - betaKal)*180/pi;


%% Primerjava kota kolenskega kota dolocenega iz Kalmana (Matlab) & iz kalibriranih g-jev

figure;
plot(t(nStart:nEnd)/60,alfaFilt, 'g')
hold on
plot(t(nStart:nEnd)/60, alfaKal, 'b')
hold on

%% Izracun kota iz qualisys meritev RPY + korekcija za NaN  vrednosti

alfaz1 = fnOdstraniPrehod(-RPYs2(:,3)-RPYz1(:,3));
alfaz1 = 180-alfaz1;

k = find(~isnan(alfaz1(:,1)));
tValid = zeros(length(tQ),1); tValid(k) = 1; tValid = tValid(1:end);
disp(['Qualisys loss: ', num2str(1-length(k)/length(alfaz1))]);
alfaz1 = (interp1(tQ(k),alfaz1(k,:),tQ(1:end)))';

%% Iz neznanega razloga ta del za vsklajevanje meritev ne dela :(


[alfaz1, alfaKal] = fnVskladiSignala(alfaz1, alfaKal);
Rxy = fnRxy(alfaKal, alfaz1);
[p, plocs] = findpeaks(Rxy, 'MinPeakProminence', 0.000015);
%plot(Rxy)
figure; plot(Rxy)
hold on
plot(plocs, Rxy(plocs), '.m', 'MarkerSize', 12)


alfaz1 = [alfaz1(plocs(1):end); alfaz1(1:plocs(1)-1)];

%% Odsek za izracun RMSE & primerjavo signalov s Qualisys-om

plot(alfaz1)
hold on 
plot(alfaKal(1:length(alfaz1)))

[x5, y5] = ginput(1);
x5 = round(x5);

alfaz1 = alfaz1(1:x5);
alfaKal = alfaKal(1:x5);
alfaComp = alfaComp(1:x5);
alfa = alfa(1:x5);
alfaFilt = alfaFilt(1:x5);
alfaCal = alfaCal(1:x5);


%% Poskus izracuna RMSE -> v kotnih stopinjah

RMSE = fnRMSE(alfaz1-2, alfa)
filtRMSE = fnRMSE(alfaz1-2, alfaFilt)
calRMSE = fnRMSE(alfaz1-2, alfaCal)
compRMSE = fnRMSE(alfaz1-2, alfaComp)
kalRMSE = fnRMSE(alfaz1-2, alfaKal)

%% primerjava vseh metod

figure;
plot(alfaz1-2, 'b')
hold on
plot(alfa, 'r')
hold on
plot(alfaFilt, 'g')
hold on
plot(alfaKal, 'black')
hold on
plot(alfaCal, 'm')
hold on
plot(alfaComp)
xlabel('$n$', 'interpreter', 'latex', 'FontSize', 12)
ylabel('$Kot$ $kolena$ $[^{\circ}]$', 'interpreter', 'latex', 'FontSize', 12)
grid on