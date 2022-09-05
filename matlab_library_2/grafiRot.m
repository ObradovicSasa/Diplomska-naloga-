figure;
subplot(221)
plot(squeeze(poravRotZ1virt(:,1,:))')
grid on 
legend("Qualisys z vritualno tocko")

subplot(222)
plot(squeeze(poravRotZ1(:,1,:))')
grid on 
legend("Qualisys")

subplot(223)
plot(squeeze(orientationPorav1(:,1,:))')
grid on 
legend("Kalman")

subplot(224)
plot(squeeze(Rot1Cal(:,1,:))')
grid on 
legend("Kalibrirana z detrendom")

%%

figure; hold on
plot(alfaz1)
plot(alfaz1virt)
plot(alfaKal+0.65)
plot(alfaCalVsklajen+0.65)
plot(alfaComp+0.7)
legend("qualisys", "qualisys z virt tocko", "Kalman", "Kalibriran z detrendom", "Complementary z detrendom")

%%

figure; hold on
plot(acc1)


