%% Plot meritev
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

[xMcBp, yMcBp] = ginput(2);
xMcBp = round(xMcBp);
close(figMc)
Bp1    = xMcBp(1); Bp2    = xMcBp(2);
bp = [Bp1; Bp2];
%% Korekcija lezanja v MC meritvah zaradi vpliva lepilnega traka, ter segrevanja senzorjev

% uporablja se plinom n-te stopnje (zaenkrat kot primer 6-te stopnje), ter
% se na osnovi breakpoint-ov skusa ustrezno popraviti karakteristike
korBf = detrend(Bf, 19, bp);
korVm = detrend(Vm, 9, bp);
korVl = detrend(Vl, 1, bp);

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



