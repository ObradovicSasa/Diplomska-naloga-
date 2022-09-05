function [acc1, om1, acc2, om2, t] = fnSyncAccOmMW2S(ACC_DATA1, GYRO_DATA1, ACC_DATA2, GYRO_DATA2, fs)
%sinhronizira dva IMU senzorja da se zacneta hkrati :D
%potem lahko uporabimo timestampe da vzamemo tocno en odsek meritev za
%dolocanje kota prek complementary filtra


[acc1, om1, t1, t01] = fnSyncAccOmMW(ACC_DATA1, GYRO_DATA1, fs);

[acc2, om2, t2, t02] = fnSyncAccOmMW(ACC_DATA2, GYRO_DATA2, fs);

tdiff = round((t01 - t02)/1000);
Ndiff = tdiff*fs;

if tdiff > 0
    t = t1;
    acc2 = acc2(Ndiff+1:end,:);
    om2 = om2(Ndiff+1:end,:);
else
    t = t2;
    acc1 = acc1(abs(Ndiff)+1:end,:);
    om1 = om1(abs(Ndiff)+1:end,:);
end

size(acc1)

L = min(length(acc1),length(acc2));
acc1 = acc1(1:L,:); om1 = om1(1:L,:);
acc2 = acc2(1:L,:); om2 = om2(1:L,:);
t = t(1:L);