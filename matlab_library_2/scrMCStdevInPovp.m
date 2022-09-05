%% Po periodah sekanje in interpolacija na najkrajso periodo za BF, VL, VM -> Jaz :)
perBfVlVm = upAlfaKalPer(1:length(upAlfaKalIndx)-1);
minDolzinaObremenitve = min(perBfVlVm);
tZahtevaniObremenitve = 0 : 0.01 : 0.01*(minDolzinaObremenitve-1);

upBfObr = zeros(length(perBfVlVm),minDolzinaObremenitve);
upVlObr = zeros(length(perBfVlVm),minDolzinaObremenitve);
upVmObr = zeros(length(perBfVlVm),minDolzinaObremenitve);

for i = 1:length(perBfVlVm)
    tZacasniObr = 0 : 0.01 : 0.01*(perBfVlVm(i)-1);
    upBfObr(i,:) = interp1(tZacasniObr, upBf(upAlfaKalIndx(i):upAlfaKalIndx(i+1)-1,1),tZahtevaniObremenitve);
    upVlObr(i,:) = interp1(tZacasniObr, upVl(upAlfaKalIndx(i):upAlfaKalIndx(i+1)-1,1),tZahtevaniObremenitve);
    upVmObr(i,:) = interp1(tZacasniObr, upVm(upAlfaKalIndx(i):upAlfaKalIndx(i+1)-1,1),tZahtevaniObremenitve);
end

%% Prikaz interpoliranih
figure; 
subplot(311); hold on; grid on;
for i = 1:length(upBfObr(:,1))
    plot(upBfObr(i,:))
end

subplot(312); hold on; grid on;
for i = 1:length(upVlObr(:,1))
    plot(upVlObr(i,:))
end

subplot(313); hold on; grid on;
for i = 1:length(upVmObr(:,1))
    plot(upVmObr(i,:))
end



%% Izracun stdev in povprecne vrednosti

upBfObrMean = zeros(1,length(upBfObr(1,:)));
upBfObrSTDev = zeros(1,length(upBfObr(1,:)));
upVlObrMean = zeros(1,length(upVlObr(1,:)));
upVlObrSTDev = zeros(1,length(upVlObr(1,:)));
upVmObrMean = zeros(1,length(upVmObr(1,:)));
upVmObrSTDev = zeros(1,length(upVmObr(1,:)));

for i = 1:length(upBfObr(1,:))
    upBfObrMean(1,i) = mean(upBfObr(:,i));
    upBfObrSTDev(1,i) = 2*std(upBfObr(:,i));
    upVlObrMean(1,i) = mean(upVlObr(:,i));
    upVlObrSTDev(1,i) = 2*std(upVlObr(:,i));
    upVmObrMean(1,i) = mean(upVmObr(:,i));
    upVmObrSTDev(1,i) = 2*std(upVmObr(:,i));
end

%% En cikel qualisysa za primerjavo

alfaz1Cikel = (upAlfaZ1Del(upAlfaKalIndx(1):upAlfaKalIndx(2)))';
tcikla = 0 : 0.01 : 0.01*(length(alfaz1Cikel)-1);
alfaz1Cikel = interp1(tcikla, alfaz1Cikel,tZahtevaniObremenitve);
plot(alfaz1Cikel)    


%% 

figure;
subplot(311); hold on; grid on;
plot(tZahtevaniObremenitve,upBfObrMean, LineWidth=2)
plot(tZahtevaniObremenitve,upBfObrMean+upBfObrSTDev, LineStyle="--", LineWidth=2, Color='r')
plot(tZahtevaniObremenitve,upBfObrMean-upBfObrSTDev, LineStyle="--", LineWidth=2, Color='r')
%plot(tZahtevaniObremenitve,alfaz1Cikel, LineStyle=":", LineWidth=2)
set(gca,'fontsize',20)
ylabel("BF [mV/V]", 'interpreter', 'latex', 'FontSize', 30)
xlabel("t cikla [s]", 'interpreter', 'latex', 'FontSize', 30)
xlim([0 max(tZahtevaniObremenitve)])

subplot(312); hold on; grid on;
plot(tZahtevaniObremenitve,upVlObrMean, LineWidth=2)
plot(tZahtevaniObremenitve,upVlObrMean+upVlObrSTDev, LineStyle="--", LineWidth=2, Color='r')
plot(tZahtevaniObremenitve,upVlObrMean-upVlObrSTDev, LineStyle="--", LineWidth=2, Color='r')
%plot(tZahtevaniObremenitve,alfaz1Cikel, LineStyle=":", LineWidth=2)
set(gca,'fontsize',20)
ylabel("VL [mV/V]", 'interpreter', 'latex', 'FontSize', 30)
xlabel("t cikla [s]", 'interpreter', 'latex', 'FontSize', 30)
xlim([0 max(tZahtevaniObremenitve)])

subplot(313); hold on; grid on;
plot(tZahtevaniObremenitve,upVmObrMean, LineWidth=2)
plot(tZahtevaniObremenitve,upVmObrMean+upVmObrSTDev, LineStyle="--", LineWidth=2, Color='r')
plot(tZahtevaniObremenitve,upVmObrMean-upVmObrSTDev, LineStyle="--", LineWidth=2, Color='r')
%plot(tZahtevaniObremenitve,alfaz1Cikel, LineStyle=":", LineWidth=2)
set(gca,'fontsize',20)
ylabel("VM [mV/V]", 'interpreter', 'latex', 'FontSize', 30)
xlabel("t cikla [s]", 'interpreter', 'latex', 'FontSize', 30)
xlim([0 max(tZahtevaniObremenitve)])
