%% Dolocanje kota iz ciste geometrije -> gledamo le projekciji vektorja g na x in y osi ;)

gama = atan2(g1(:,2),g1(:,1)); %lahko tudi direkt racunamo z acc1/2, vendar so koti s precej vec suma
beta = atan2(g2(:,2),g2(:,1));


alfa = (pi- abs(gama) - beta)*180/pi;
alfa = fnOdstraniPrehod(alfa);


%% basic filtriranje meritev pospeskometra

acc2Filt = lowpass(acc2, 1, fs);
acc1Filt = lowpass(acc1, 1, fs);


%% Dolocanje kota iz pospeskometra -> basic filtriranje

betaFilt = atan2(g2Filt(:,2), g2Filt(:,1));
gamaFilt = atan2(g1Filt(:,2), g1Filt(:,1));

alfaFilt = (pi- gamaFilt - betaFilt)*180/pi;
alfaFilt = fnOdstraniPrehod(alfaFilt);

%% Dolocanje kota iz kalibrirane g komponenta -> odstet startni offset

betaCal = atan2(gCal2(:, 2), gCal2(:, 1));
gamaCal = atan2(gCal1(:,2), gCal1(:,1));

alfaCal = (pi- abs(gamaCal) - betaCal)*180/pi;
alfaCal = fnOdstraniPrehod(alfaCal);

alfaCalEnosmerna = mean(alfaCal(1:200));
alfaCaldetrend = detrend(alfaCal,1);
alfaCalEnosmerna = alfaCalEnosmerna-mean(alfaCaldetrend(1:200));
alfaCaldetrend = alfaCaldetrend+alfaCalEnosmerna;



%% Dolocanje kota s pomocjo qualisys-a

gQual1 = g01;
gQual2 = g02;
for i = 1:length(poravRotZ1)
    gQual1(i+1,:) = (poravRotZ1(:,:,i)'*g01')';
    gQual2(i+1,:) = (poravRotS2(:,:,i)'*g02')';
end

gamaQual = atan2(gQual1(:,2),gQual1(:,1)); 
betaQual = atan2(gQual2(:,2),gQual2(:,1));

alfaz1 = (pi - abs(gamaQual) - betaQual)*180/pi;
alfaz1 = fnOdstraniPrehod(alfaz1);

%% Dolocanje kota z virtualno tocko
gQual1virt = g01;
gQual2virt = g02;
for i = 1:length(poravRotZ1virt)
    gQual1virt(i+1,:) = (poravRotZ1virt(:,:,i)'*g01')';
    gQual2virt(i+1,:) = (poravRotS2virt(:,:,i)'*g02')';
end

gamaQualvirt = atan2(gQual1virt(:,2),gQual1virt(:,1)); 
betaQualvirt = atan2(gQual2virt(:,2),gQual2virt(:,1));

alfaz1virt = (pi - abs(gamaQualvirt) - betaQualvirt)*180/pi;
alfaz1virt = fnOdstraniPrehod(alfaz1virt);

%% Iskanje zamika meritve kota


zamik = fnVskladiKota(alfaCaldetrend,alfaz1virt);
alfaCalVsklajen = alfaCaldetrend(zamik:end);

% zamik = fnVskladiKota(alfaz1virt,alfaCaldetrend);
% alfaCalVsklajen = alfaCaldetrend;
% alfaz1virt = alfaz1virt(zamik:end);
% alfaz1 = alfaz1(zamik:end);
%% Plotanje kota dolocenega iz geometrije

figure;
hold on
%plot(alfaCal(zamik:end))
plot(alfaCalVsklajen, 'g')
plot(alfaz1, 'r')
plot(alfaz1virt)
legend('alfa-kalibriran-detrend', 'alfa-qualisys', 'alfa-qualisys z virtualno tocko')
%legend('alfa-kalibriran-detrend', 'alfa-qualisys')

