%% Skripta za uvoz podatkov z MC senzorjev
% Potrebno je ustrezno poimenovati MC csv datoteko!!!
mc = MeritveFE_MCexport_20Jul22_02;

fsMc = 1000; % MC senzorji vzorcijo s frekvenco 1000 Hz
tmc  = mc(:,1); % Cas meritve MC senzorja
Vm   = mc(:,5); % Vastus medialis
Bf   = mc(:,6); % Biceps femoris
Vl   = mc(:,7); % Vastus lateralis
xacc = mc(:,9);

%% Detrend meritve
%Plot meritev
figMc = figure;
plot(Vl)
hold on 
plot(Vm)
plot(Bf)
legend("Vastus Lateralis","Vastus Medialis","Biceps Femoris");
xlabel("n")
ylabel("Pritisk misic [mV/V]")
grid on

% Sekanje meritev
% Prva dva timestamp-a sta za odsek uporabne meritve
% Druga dva odseka sta za vpliv kontrakcije koze na meritev

[xMcBp, yMcBp] = ginput(3);
xMcBp = round(xMcBp);
close(figMc)
Bp1    = xMcBp(1); Bp2    = xMcBp(2); Bp3 = xMcBp(3);
bp = [Bp1; Bp2];
%% Korekcija lezanja v MC meritvah zaradi vpliva lepilnega traka, ter segrevanja senzorjev

% uporablja se plinom n-te stopnje (zaenkrat kot primer 6-te stopnje), ter
% se na osnovi breakpoint-ov skusa ustrezno popraviti karakteristike
korBf = detrend(Bf, 2, bp);
korVm = detrend(Vm, 2, bp);
korVl = detrend(Vl, 19, bp);

%% Plot izravnanih meritev glede na prvotne MC meritve

subplot(311)
plot(tmc, korBf)
hold on
plot(tmc, Bf-mean(Bf))
xlabel("t(s)")
ylabel("Pritisk na misice")
legend("Korigirana meritev", "Nekorigirana meritev")

subplot(312)
plot(tmc, korVm)
hold on
plot(tmc, Vm-mean(Vm))
xlabel("t(s)")
ylabel("Pritisk na misice")
legend("Korigirana meritev", "Nekorigirana meritev")

subplot(313)
plot(tmc, korVl)
hold on
plot(tmc, Vl-mean(Vl))
xlabel("t(s)")
ylabel("Pritisk na misice")
legend("Korigirana meritev", "Nekorigirana meritev")



