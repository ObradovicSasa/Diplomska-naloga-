%% primerjava vseh metod

% izracun kotov iz imu senzorjev in qualisys-a
plot(alfaz1, 'b')
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
legend("Qualisys","Surove meritve","LPF meritve","Kalman filter","Kalibrirana meritev","Complementary filter")
grid on

