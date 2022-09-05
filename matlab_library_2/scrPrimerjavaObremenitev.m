%% Sekanje delov MC meritev -> vecja in manjsa obremenitev

%% Plot meritev
figOb = figure;
plot(Vl)
hold on 
plot(Vm)
plot(Bf)
legend("Vastus Lateralis","Vastus Medialis","Biceps Femoris");
xlabel("n")
ylabel("Pritisk misic [mV/V]")
grid on

% Sekanje meritev
% Prva dva timestamp-a sta za odsek meritve pod vecjo obremenitvijo
% Druga dva odseka sta za odsek meritve pod manjso obremenitvijo 

[xOb, yOb] = ginput(4);
xOb = round(xOb);
close(figOb)
vecjaObrStart           = xOb(1); vecjaObrEnd          = xOb(2);
manjsaObrStart          = xOb(3); manjsaObrEnd         = xOb(4); 

%% Shranjevanje meritev v delih

vObVl = Vl(vecjaObrStart:vecjaObrEnd); 
vObVm = Vm(vecjaObrStart:vecjaObrEnd); 
vObBf = Bf(vecjaObrStart:vecjaObrEnd); 


mObVl = Vl(manjsaObrStart:manjsaObrEnd);  
mObVm = Vm(manjsaObrStart:manjsaObrEnd); 
mObBf = Bf(manjsaObrStart:manjsaObrEnd);  


%% Iskanje period posemezne meritve -> Neobvezno za izris! mogoce kasneje za primerjavo odzivov
% vcasih tezava z nastavitvijo ustreznega minpeakprominence
% Iskanje maximumov vecje obremenitve 
[vObBfMax, vObBfMaxIndx] = findpeaks(vObBf, 'MinPeakProminence', 40);
[vObVmMax, vObVmMaxIndx] = findpeaks(vObVm, 'MinPeakProminence', 62);
[vObVlMax, vObVlMaxIndx] = findpeaks(vObVl, 'MinPeakProminence', 15);

% Iskanje maximumov manjse obremenitve
[mObBfMax, mObBfMaxIndx] = findpeaks(mObBf, 'MinPeakProminence', 40);
[mObVmMax, mObVmMaxIndx] = findpeaks(mObVm, 'MinPeakProminence', 62);
[mObVlMax, mObVlMaxIndx] = findpeaks(mObVl, 'MinPeakProminence', 15);

%% Kalman za referenco -> periodo ciklov; zaenkrat 4 periode privzete za primerjavo


vMeritevStart = vecjaObrStart - nStart + 1;
vMeritevEnd = vecjaObrEnd - nStart + 1;

mMeritevStart = manjsaObrStart - nStart + 1;
mMeritevEnd = manjsaObrEnd - nStart + 1;



vAlfaKal = alfaKal(vMeritevStart:vMeritevEnd)-mean(alfaKal(vMeritevStart:vMeritevEnd));
mAlfaKal = alfaKal(mMeritevStart:mMeritevEnd)-mean(alfaKal(mMeritevStart:mMeritevEnd));

[vAlfaKalIndx, vAlfaKalPer] = fnPerioda(vAlfaKal);
tPrimerjaveVOb = 0:0.01:(length((vAlfaKal(vAlfaKalIndx(2):vAlfaKalIndx(2+4))))-1)/fs;

[mAlfaKalIndx, mAlfaKalPer] = fnPerioda(mAlfaKal);
tPrimerjaveMOb = 0:0.01:(length((mAlfaKal(mAlfaKalIndx(2):mAlfaKalIndx(2+4))))-1)/fs;

%% Plot za vecjo in mansjo obremenitev

subplot(121)
plot(tPrimerjaveVOb,vAlfaKal(vAlfaKalIndx(2):vAlfaKalIndx(2+4)), LineWidth=1)
hold on
%plot(tPrimerjaveVOb,vObVm(vAlfaKalIndx(2):vAlfaKalIndx(2+4))-mean(vObVm))
%plot(tPrimerjaveVOb,vObVl(vAlfaKalIndx(2):vAlfaKalIndx(2+4))-mean(vObVl))
plot(tPrimerjaveVOb,vObBf(vAlfaKalIndx(2):vAlfaKalIndx(2+4))-mean(vObBf), LineWidth=1)
for i = 2:6
    xline(tPrimerjaveVOb(1,vAlfaKalIndx(i)-vAlfaKalIndx(2)+1), 'LineWidth',1)
end
set(gca,'fontsize',20)
xlabel("\v{C}as $[s]$", 'interpreter', "latex", 'FontSize', 30)
ylabel("Kot kolena $[^{\circ}]$/Pritisk na mi\v{s}ice pri ve\v{c}ji obremenitvi$[mV/V]$", 'interpreter', 'latex', 'FontSize', 30)
grid on
%legend("Kot kolena -> Kalman","Vastus Medialis", "Vastus Lateralis", "Biceps Femoris")




subplot(122)
plot(tPrimerjaveMOb,mAlfaKal(mAlfaKalIndx(2):mAlfaKalIndx(2+4)), LineWidth=1)
hold on
%plot(tPrimerjaveMOb,mObVm(mAlfaKalIndx(2):mAlfaKalIndx(2+4))-mean(mObVm))
%plot(tPrimerjaveMOb,mObVl(mAlfaKalIndx(2):mAlfaKalIndx(2+4))-mean(mObVl))
plot(tPrimerjaveMOb,mObBf(mAlfaKalIndx(2):mAlfaKalIndx(2+4))-mean(mObBf), LineWidth=1)
for i = 2:6
    xline(tPrimerjaveMOb(1,mAlfaKalIndx(i)-mAlfaKalIndx(2)+1), 'LineWidth',1)
end
ylim([-150 300])
set(gca,'fontsize',20)
xlabel("\v{C}as $[s]$", 'interpreter', "latex", 'FontSize', 30)
ylabel("Kot kolena $[^{\circ}]$/Pritisk na mi\v{s}ice pri manj\v{s}i obremenitvi$[mV/V]$", 'interpreter', 'latex', 'FontSize', 30)
grid on
%legend("Kot kolena -> Kalman","Vastus Medialis", "Vastus Lateralis", "Biceps Femoris")




