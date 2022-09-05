subplot(121)
plot(om2)
legend("x-os","y-os","z-os")
subplot(122)
plot(meanOkna)
legend("x-os","y-os","z-os")
hold on
plot(linspace(meanOkna(1,1),meanOkna(length(meanOkna),1), length(meanOkna)))
hold on
plot(linspace(meanOkna(1,2),meanOkna(length(meanOkna),2), length(meanOkna)))
hold on
plot(linspace(meanOkna(1,3),meanOkna(length(meanOkna),3), length(meanOkna)))


%%

dOmega1 = (max(meanOkna(:,1))-min(meanOkna(:,1)))*pi/180;
dOmega2 = (max(meanOkna(:,2))-min(meanOkna(:,2)))*pi/180;
dOmega3 = (max(meanOkna(:,3))-min(meanOkna(:,3)))*pi/180;
