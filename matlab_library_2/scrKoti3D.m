
alfaRot = [];
alfaRotQual = [];

for i = 1 : length(g1Rot)
    alfaRot(i) = acos((g1Rot(i,:)*g2Rot(i, :)')/(norm(g01)*norm(g02)));
end

for i = 1 : length(gQual1)
    alfaRotQual(i) = acos((gQual1(i,:)*gQual2(i, :)')/(norm(g01)*norm(g02)));
end

alfaRot = alfaRot';
alfaRotQual = alfaRotQual';

%% Izris

plot(alfaz1)
hold on
plot(alfaRotQual*180/pi)
plot(alfaRot*180/pi)
grid on
legend("kot 2d - Qualisys","kot 3d - Qualisys","kot 3d - IMU")
