function alfa = fnKolesniKot(gCal1, gCal2, acc1, acc2)

gama = zeros(length(gCal1), 1);
beta = zeros(length(gCal2), 1);

for i = 1:length(gCal1)
    gama(i,1) = acos(gCal1(i,:)*acc1(i,:)'/norm(gCal1(i,:))/norm(acc1(i,:)))*180/pi;
end

for i = 1:length(gCal2)
    beta(i,1) = acos(gCal2(i,:)*acc2(i,:)'/norm(gCal2(i,:))/norm(acc2(i,:)))*180/pi;
end


alfa = 180-beta-gama;

end