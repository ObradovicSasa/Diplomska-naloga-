
%% Manjsa in vecja obremenitev Biceps Femoris -> Simon
vecjaObremenitev = upAlfaKalPer(1:round(length(upAlfaKalIndx)/4)-1);
manjsaObremenitev = upAlfaKalPer(round(length(upAlfaKalIndx)/2):round(length(upAlfaKalIndx)*0.75));
minDolzinaVecjeObremenitve = min(vecjaObremenitev);
minDolzinaManjseObremenitve = min(manjsaObremenitev);
tZahtevaniVecje = 0 : 0.01 : 0.01*(minDolzinaVecjeObremenitve-1);
tZahtevaniManjse = 0 : 0.01 : 0.01*(minDolzinaManjseObremenitve-1);
upBfVecjaObr = zeros(length(vecjaObremenitev),minDolzinaVecjeObremenitve);
for i = 1:length(vecjaObremenitev)
    tZacasniVecja = 0 : 0.01 : 0.01*(vecjaObremenitev(i)-1);
    upBfVecjaObr(i,:) = interp1(tZacasniVecja, upBf(upAlfaKalIndx(i):upAlfaKalIndx(i+1)-1,1),tZahtevaniVecje);
end

upBfManjsaObr = zeros(length(manjsaObremenitev),minDolzinaManjseObremenitve);
j = 1;
for i = round(length(upAlfaKalIndx)/2):round(length(upAlfaKalIndx)/2)+length(manjsaObremenitev)-1
    tZacasniManjsa = 0 : 0.01 : 0.01*(manjsaObremenitev(j)-1);
    upBfManjsaObr(j,:) = interp1(tZacasniManjsa, upBf(upAlfaKalIndx(i):upAlfaKalIndx(i+1)-1,1),tZahtevaniManjse);
    j = j+1;
end



%% Samo prikaz brez nobene interpolacije
figure; 
subplot(211);hold on; grid on;
for i = 1:length(upAlfaKalIndx)/4-1
    plot(upBf(upAlfaKalIndx(i):upAlfaKalIndx(i+1)))
end


subplot(212); hold on; grid on;
for i = round(length(upAlfaKalIndx)/2):round(length(upAlfaKalIndx)*0.75)
    plot(upBf(upAlfaKalIndx(i):upAlfaKalIndx(i+1)))
end

%% Prikaz interpoliranih
figure; 
subplot(211); hold on; grid on;
for i = 1:length(upBfVecjaObr(:,1))
    plot(upBfVecjaObr(i,:))
end

subplot(212); hold on; grid on;
for i = 1:length(upBfManjsaObr(:,1))
    plot(upBfManjsaObr(i,:))
end

%% Izracun stdev in povprecne vrednosti

upBfVecjaObrMean = zeros(1,length(upBfVecjaObr(1,:)));
upBfVecjaObrSTDev = zeros(1,length(upBfVecjaObr(1,:)));

for i = 1:length(upBfVecjaObrMean)
    upBfVecjaObrMean(1,i) = mean(upBfVecjaObr(:,i));
    upBfVecjaObrSTDev(1,i) = 2*std(upBfVecjaObr(:,i));
end

upBfManjsaObrMean = zeros(1,length(upBfManjsaObr(1,:)));
upBfManjsaObrSTDev = zeros(1,length(upBfManjsaObr(1,:)));

for i = 1:length(upBfManjsaObrMean)
    upBfManjsaObrMean(1,i) = mean(upBfManjsaObr(:,i));
    upBfManjsaObrSTDev(1,i) = 2*std(upBfManjsaObr(:,i));
end


%% 

figure;
subplot(212); hold on; grid on;
plot(tZahtevaniManjse,upBfManjsaObrMean, LineWidth=1)
plot(tZahtevaniManjse,upBfManjsaObrMean+upBfManjsaObrSTDev, LineStyle="--", LineWidth=1, Color='r')
plot(tZahtevaniManjse,upBfManjsaObrMean-upBfManjsaObrSTDev, LineStyle="--", LineWidth=1, Color='r')
set(gca,'fontsize',20)
ylabel("BF manj\v{s}a obremenitev $[mV/V]$", 'interpreter', 'latex', 'FontSize', 30)
xlabel("\v{C}as cikla $[s]$", 'interpreter', 'latex', 'FontSize', 30)

subplot(211); hold on; grid on;
plot(tZahtevaniVecje,upBfVecjaObrMean, LineWidth=1)
plot(tZahtevaniVecje,upBfVecjaObrMean+upBfVecjaObrSTDev, LineStyle="--", LineWidth=1, Color='r')
plot(tZahtevaniVecje,upBfVecjaObrMean-upBfVecjaObrSTDev, LineStyle="--", LineWidth=1, Color='r')
set(gca,'fontsize',20)
ylabel("BF ve\v{c}ja obremenitev $[mV/V]$", 'interpreter', 'latex', 'FontSize', 30)
xlabel("\v{C}as cikla $[s]$", 'interpreter', 'latex', 'FontSize', 30)
