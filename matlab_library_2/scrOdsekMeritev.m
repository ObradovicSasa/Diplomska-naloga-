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
