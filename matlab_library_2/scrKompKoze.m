%% Skripta za kompenzacijo vpliva koze na meritev kontrakcije misic

%% Sekanje uporabne meritev za dolocanje ene periode

figUpMc = figure;
plot(upBf)
hold on
plot(upVm)
plot(upVl)
legend("Biceps Femoris", "Vastus Medialis", "Vastus Lateralis");
xlabel("n")
ylabel("Pritisk misic [mV/V]")
grid on


[xUpMc, yUpMc] = ginput(2);
xUpMc = round(xUpMc);
close(figUpMc)
TUpMeritevStart    = xUpMc(1); TUpMeritevEnd    = xUpMc(2); % Timestampi za dolocanje periode meritve
 
korUpMeritevStart = TUpMeritevStart - nStart + 1;
korUpMeritevEnd = TUpMeritevEnd - nStart + 1;


tUpBf = upBf(TUpMeritevStart:TUpMeritevEnd)- mean(upBf);
tUpVm = upVm(TUpMeritevStart:TUpMeritevEnd)- mean(upVm);
tUpVl = upVl(TUpMeritevStart:TUpMeritevEnd)- mean(upVl);
tAlfaKal = alfaKal(TUpMeritevStart:TUpMeritevEnd);

%%
upAlfaKal = alfaKal(UpMeritevStart:UpMeritevEnd);
kozaAlfaKal = alfaKal(KozaStart:KozaEnd);

tUpBf = upBf;
tUpVm = upVm;
tUpVl = upVl;

tKozaBf = kozaBf;
tKozaVl = kozaVl;
tKozaVm = kozaVm;



%% Sekanje meritve vpliva koze za kalibracijo

figKozaMc = figure;
plot(kozaBf)
hold on
plot(kozaVm)
plot(kozaVl)
legend("Biceps Femoris", "Vastus Medialis", "Vastus Lateralis");
xlabel("n")
ylabel("Pritisk misic [mV/V]")
grid on


[xKozaMc, yKozaMc] = ginput(2);
xUpMc = round(xKozaMc);
close(figKozaMc)
TKozaMeritevStart    = xKozaMc(1); TKozaMeritevEnd    = xKozaMc(2); % Timestampi za dolocanje periode meritve

tKozaBf = kozaBf(TKozaMeritevStart:TKozaMeritevEnd)-mean(kozaBf);
tKozaVm = kozaVm(TKozaMeritevStart:TKozaMeritevEnd)-mean(kozaVm);
tKozaVl = kozaVl(TKozaMeritevStart:TKozaMeritevEnd)-mean(kozaVl);

%% Dolocanje ene periode za vsak signal
% vcasih tezava nastavitve minpeakprominence za dolocanje period
% Iskanje maximumov uporabne meritve
[upMaxBf, upMaxIndxBf] = findpeaks(tUpBf, 'MinPeakProminence', 0.005);
[upMaxVm, upMaxIndxVm] = findpeaks(tUpVm, 'MinPeakProminence', 0.015);
[upMaxVl, upMaxIndxVl] = findpeaks(tUpVl, 'MinPeakProminence', 0.0017);

% Iskanje maximumov vpliva koze
[kozaMaxBf, kozaMaxIndxBf] = findpeaks(tKozaBf, 'MinPeakProminence', 0.005);
[kozaMaxVm, kozaMaxIndxVm] = findpeaks(tKozaVm, 'MinPeakProminence', 0.05);
[kozaMaxVl, kozaMaxIndxVl] = findpeaks(tKozaVl, 'MinPeakProminence', 0.005);

%% Periodi uporabne meritve in vpliva kontrakcije koze

% Biceps Femoris
perKozaBf = tKozaBf(kozaMaxIndxBf(1):kozaMaxIndxBf(2));
perUpBf   = tUpBf(upMaxIndxBf(1):upMaxIndxBf(2));
perAlfaKalBf = tAlfaKal(upMaxIndxBf(1):upMaxIndxBf(2));

tPraviBf =  0 : 0.01 : 0.01*(length(perUpBf)-1);
tKozeBf  =  0 : 0.01 : 0.01*(length(perKozaBf)-1);

korKozaBf = interp1(tKozeBf, perKozaBf, tPraviBf);


% Vastus Medialis

perKozaVm = tKozaVm(kozaMaxIndxVm(1):kozaMaxIndxVm(2));
perUpVm   = tUpVm(upMaxIndxVm(1):upMaxIndxVm(2));
perAlfaKalVm = tAlfaKal(upMaxIndxVm(1):upMaxIndxVm(2));

tPraviVm =  0 : 0.01 : 0.01*(length(perUpVm)-1);
tKozeVm  =  0 : 0.01 : 0.01*(length(perKozaVm)-1);

korKozaVm = interp1(tKozeVm, perKozaVm, tPraviVm);

% Vastus Lateralis

perKozaVl    =  tKozaVl(kozaMaxIndxVl(1):kozaMaxIndxVl(2));
perUpVl      =  tUpVl(upMaxIndxVl(1):upMaxIndxVl(2));
perAlfaKalVl =  tAlfaKal(upMaxIndxVl(1):upMaxIndxVl(2));

tPraviVl =  0 : 0.01 : 0.01*(length(perUpVl)-1);
tKozeVl  =  0 : 0.01 : 0.01*(length(perKozaVl)-1);

korKozaVl = interp1(tKozeVl, perKozaVl, tPraviVl);

% Graf vseh treh

subplot(131)
plot(tPraviBf,(korKozaBf-mean(korKozaBf))/max(korKozaBf))
hold on
plot(tPraviBf,(perUpBf-mean(perUpBf))/max(perUpBf))
plot(tPraviBf,(perAlfaKalBf-mean(perAlfaKalBf))/max(perAlfaKalBf))
grid on
ylabel("Pritisk na Bf")
xlabel("t(s)")
legend("Perioda vpliva koze", "Perioda Bf", "Perioda kota iz Kalmana")

subplot(132)
plot(tPraviVm,(korKozaVm-mean(korKozaVm))/max(korKozaVm))
hold on
plot(tPraviVm,(perUpVm-mean(perUpVm))/mean(perUpVm))
plot(tPraviVm,(perAlfaKalVm-mean(perAlfaKalVm))/max(perAlfaKalVm))
grid on
legend("Perioda vpliva koze", "Perioda Vm", "Perioda kota iz Kalmana")

subplot(133)
plot(tPraviVl,(korKozaVl-mean(korKozaVl))/max(korKozaVl))
hold on
plot(tPraviVl,(perUpVl-mean(perUpVl))/max(perUpVl))
plot(tPraviVl,(perAlfaKalVl-mean(perAlfaKalVl))/max(perAlfaKalVl))
grid on
legend("Perioda vpliva koze", "Perioda Vl", "Perioda kota iz Kalmana")

%% Odstet vpliv koze

korUpBf = perUpBf - korKozaBf';
korUpVm = perUpVm - korKozaVm';
korUpVl = perUpVl - korKozaVl';


subplot(131)
plot(tPraviBf, korUpBf)
hold on
plot(tPraviBf, perUpBf)
plot(tPraviBf,perAlfaKalBf)
grid on
ylabel("Pritisk na Bf")
xlabel("t(s)")
legend("Kompenzovan vpliv koze", "Pred kompenzacijo vpliva koze", "Perioda spremembe kota -> Kalman")

subplot(132)
plot(tPraviVm, korUpVm)
hold on
plot(tPraviVm, perUpVm)
plot(tPraviVm,perAlfaKalVm)
grid on
ylabel("Pritisk na Vm")
xlabel("t(s)")
legend("Kompenzovan vpliv koze", "Pred kompenzacijo vpliva koze", "Perioda spremembe kota -> Kalman")

subplot(133)
plot(tPraviVl, korUpVl-mean(korUpVl))
hold on
plot(tPraviVl, perUpVl-mean(perUpVl))
plot(tPraviVl,perAlfaKalVl)
grid on
ylabel("Pritisk na Vl")
xlabel("t(s)")
legend("Kompenzovan vpliv koze", "Pred kompenzacijo vpliva koze", "Perioda spremembe kota -> Kalman")



