%% Skripta za primerjavo odziva MC senzorjev skupaj s spremembo kotov

% Iskanje intervala uporabne meritve kotov glede na MC senzorje

korUpMeritevStart = UpMeritevStart - nStart + 1;
korUpMeritevEnd = UpMeritevEnd - nStart + 1;

% Sekanje meritev kotov iz Kalmana in Qualisys-a na interval uporabne MC
% meritve

upAlfaKal = alfaKal(korUpMeritevStart:korUpMeritevEnd)-mean(alfaKal(korUpMeritevStart:korUpMeritevEnd));
upAlfaZ1Del = alfaz1virt(korUpMeritevStart:korUpMeritevEnd)-mean(alfaz1virt(korUpMeritevStart:korUpMeritevEnd));

% Dolocanje periode za uporabno meritev -> glede na Kalman-a
[upAlfaKalIndx, upAlfaKalPer] = fnPerioda(upAlfaKal);
tPrimerjave = 0:0.01:(length((upAlfaKal(upAlfaKalIndx(5):upAlfaKalIndx(5+10))))-1)/fs;
%% Plot MC senzorjev skupaj s spremembo kota pri Qualisys-u in Kalman-u
primerjavaMCkot = figure; 

subplot(221); hold all; grid on;
plot(tPrimerjave,(upAlfaKal(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upAlfaKal))/max(upAlfaKal), LineWidth=1)
%plot(tPrimerjave,upAlfaZ1Del(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upAlfaKal))
plot(tPrimerjave,(upVm(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upVm))/max(upVm),'LineWidth',2)
for i = 5:15
    xline(tPrimerjave(1,upAlfaKalIndx(i)-upAlfaKalIndx(5)+1), 'LineWidth',1)
end
set(gca,'fontsize',20)
xlabel("\v{C}as [s]", 'interpreter', "latex", 'FontSize', 30)
ylabel("Kot kolena in odziv mi\v{s}ice", 'interpreter', 'latex', 'FontSize', 30)

subplot(222); hold all; grid on;
plot(tPrimerjave,(upAlfaKal(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upAlfaKal))/max(upAlfaKal), LineWidth=1)
%plot(tPrimerjave,upAlfaZ1Del(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upAlfaKal))
plot(tPrimerjave,(upVl(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upVl))/max(upVl),'LineWidth',2)
for i = 5:15
    xline(tPrimerjave(1,upAlfaKalIndx(i)-upAlfaKalIndx(5)+1), 'LineWidth',1)
end
set(gca,'fontsize',20)
xlabel("\v{C}as [s]", 'interpreter', "latex", 'FontSize', 30)
ylabel("Kot kolena in odziv mi\v{s}ice", 'interpreter', 'latex', 'FontSize', 30)

subplot(223); hold all; grid on;
plot(tPrimerjave,(upAlfaKal(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upAlfaKal))/max(upAlfaKal), LineWidth=1)
%plot(tPrimerjave,upAlfaZ1Del(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upAlfaKal))
plot(tPrimerjave,(upBf(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upBf))/max(upBf), 'LineWidth',2)
for i = 5:15
    xline(tPrimerjave(1,upAlfaKalIndx(i)-upAlfaKalIndx(5)+1), 'LineWidth',1)
end
set(gca,'fontsize',20)
xlabel("\v{C}as [s]", 'interpreter', "latex", 'FontSize', 30)
ylabel("Kot kolena in odziv mi\v{s}ice", 'interpreter', 'latex', 'FontSize', 30)

subplot(224); hold all; grid on;
plot(tPrimerjave,(upAlfaKal(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upAlfaKal))/max(upAlfaKal), LineWidth=1)
%plot(tPrimerjave,upAlfaZ1Del(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upAlfaKal))
plot(tPrimerjave,(upVm(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upVm))/max(upVm),'LineWidth',2)
plot(tPrimerjave,(upVl(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upVl))/max(upVl),'LineWidth',2)
plot(tPrimerjave,(upBf(upAlfaKalIndx(5):upAlfaKalIndx(5+10))-mean(upBf))/max(upBf),'LineWidth',2)
for i = 5:15
    xline(tPrimerjave(1,upAlfaKalIndx(i)-upAlfaKalIndx(5)+1), 'LineWidth',1)
end
set(gca,'fontsize',20)
xlabel("\v{C}as [s]", 'interpreter', "latex", 'FontSize', 30)
ylabel("Kot kolena in odziv mi\v{s}ic", 'interpreter', 'latex', 'FontSize', 30)
 %$[^{\circ}]$