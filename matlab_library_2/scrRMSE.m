%% Poskus izracuna RMSE -> v kotnih stopinjah


%% Skrajsanje meritev na enako dolzino

lenCalVsklajen = length(alfaCalVsklajen)
lenKalman = length(alfaKal)
lenComp = length(alfaComp)
lenQual = length(alfaz1virt)

if lenCalVsklajen < lenKalman && lenCalVsklajen < lenComp && lenCalVsklajen < lenQual
    alfaKal = alfaKal(1:lenCalVsklajen);
    alfaComp = alfaComp(1:lenCalVsklajen);
    alfaz1 = alfaz1(1:lenCalVsklajen);
    alfaz1virt = alfaz1virt(1:lenCalVsklajen);
elseif lenKalman < lenCalVsklajen && lenKalman < lenComp && lenKalman < lenQual
    alfaComp = alfaComp(1:lenKalman);
    alfaz1 = alfaz1(1:lenKalman);
    alfaz1virt = alfaz1virt(1:lenKalman);
    alfaCalVsklajen = alfaCalVsklajen(1:lenKalman);
elseif lenComp < lenCalVsklajen && lenComp < lenKalman && lenComp < lenQual
    alfaKal = alfaKal(1:lenComp);
    alfaz1 = alfaz1(1:lenComp);
    alfaz1virt = alfaz1virt(1:lenComp);
    alfaCalVsklajen  = alfaCalVsklajen(1:lenComp);
elseif lenQual < lenComp && lenQual < lenKalman && lenQual < lenCalVsklajen
    alfaKal = alfaKal(1:lenQual);
    alfaComp = alfaComp(1:lenQual);
    alfaCalVsklajen = alfaCalVsklajen(1:lenQual);
end


%% RMSE po celotni meritvi 

% RMSEcalqual = fnRMSE(alfaCalVsklajen(1:length(alfaz1)), alfaz1);
% RMSEkalqual = fnRMSE(alfaKal(1:length(alfaz1)), alfaz1);
% RMSEcompqual = fnRMSE(alfaComp(1:length(alfaz1)), alfaz1);
% 

RMSEcalvirt = fnRMSE(alfaCalVsklajen(1:length(alfaz1virt)), alfaz1virt);
RMSEcalqual = fnRMSE(alfaCalVsklajen(1:length(alfaz1virt)), alfaz1);
RMSEkalvirt = fnRMSE(alfaKal(1:length(alfaz1virt)), alfaz1virt);
RMSEkalqual = fnRMSE(alfaKal(1:length(alfaz1virt)), alfaz1);
RMSEcompvirt = fnRMSE(alfaComp(1:length(alfaz1virt)), alfaz1virt);
RMSEcompqual = fnRMSE(alfaComp(1:length(alfaz1virt)), alfaz1);
RMSEvirtqual = fnRMSE(alfaz1virt, alfaz1);


%% RMSE po periodah meritve
% [alfaz1Indx, alfaz1Per] = fnPerioda(alfaz1);

[alfaz1virtIndx, alfaz1virtPer] = fnPerioda(alfaz1virt);


% for i = 1:length(alfaz1Indx)-1
%     RMSEcalqualPoPer(i) = fnRMSE(alfaCalVsklajen(alfaz1Indx(i):alfaz1Indx(i+1)), alfaz1(alfaz1Indx(i):alfaz1Indx(i+1)));
%     RMSEkalqualPoPer(i) = fnRMSE(alfaKal(alfaz1Indx(i):alfaz1Indx(i+1)), alfaz1(alfaz1Indx(i):alfaz1Indx(i+1)));
%     RMSEcompqualPoPer(i) = fnRMSE(alfaComp(alfaz1Indx(i):alfaz1Indx(i+1)), alfaz1(alfaz1Indx(i):alfaz1Indx(i+1)));
% end
% 
for i = 1:length(alfaz1virtIndx)-1
    RMSEcalvirtPoPer(i) = fnRMSE(alfaCalVsklajen(alfaz1virtIndx(i):alfaz1virtIndx(i+1)), alfaz1virt(alfaz1virtIndx(i):alfaz1virtIndx(i+1)));
    RMSEcalqualPoPer(i) = fnRMSE(alfaCalVsklajen(alfaz1virtIndx(i):alfaz1virtIndx(i+1)), alfaz1(alfaz1virtIndx(i):alfaz1virtIndx(i+1)));
    RMSEkalvirtPoPer(i) = fnRMSE(alfaKal(alfaz1virtIndx(i):alfaz1virtIndx(i+1)), alfaz1virt(alfaz1virtIndx(i):alfaz1virtIndx(i+1)));
    RMSEkalqualPoPer(i) = fnRMSE(alfaKal(alfaz1virtIndx(i):alfaz1virtIndx(i+1)), alfaz1(alfaz1virtIndx(i):alfaz1virtIndx(i+1)));
    RMSEcompvirtPoPer(i) = fnRMSE(alfaComp(alfaz1virtIndx(i):alfaz1virtIndx(i+1)), alfaz1virt(alfaz1virtIndx(i):alfaz1virtIndx(i+1)));
    RMSEcompqualPoPer(i) = fnRMSE(alfaComp(alfaz1virtIndx(i):alfaz1virtIndx(i+1)), alfaz1(alfaz1virtIndx(i):alfaz1virtIndx(i+1)));
    RMSEqualvirtPoPer(i) = fnRMSE(alfaz1(alfaz1virtIndx(i):alfaz1virtIndx(i+1)), alfaz1virt(alfaz1virtIndx(i):alfaz1virtIndx(i+1)));
end

%% RMSE po periodah in mean

figure; 

subplot(611)
hold on
plot(RMSEcalqualPoPer(1:200), LineWidth=2)
plot(linspace(RMSEcalqual,RMSEcalqual,length(RMSEcalqualPoPer(1:200))), '--', LineWidth=2)
grid on
%legend("RMSE kalibrirani in qual po periodah","RMSE kalibrirani in qual za celotno meritev")
set(gca,'fontsize',20)
xlabel("$n$  period", 'interpreter', 'latex', 'FontSize',30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)

subplot(612)
hold on
plot(RMSEcalvirtPoPer(1:200), LineWidth=2)
plot(linspace(RMSEcalvirt,RMSEcalvirt,length(RMSEcalvirtPoPer(1:200))),'--', LineWidth=2)
grid on
%legend("RMSE kalibrirani in qual z virt tocko po periodah", "RMSE kalibrirani in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("$n$  period", 'interpreter', 'latex', 'FontSize',30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)

subplot(613)
hold on
plot(RMSEkalqualPoPer(1:200), LineWidth=2)
plot(linspace(RMSEkalqual,RMSEkalqual,length(RMSEkalqualPoPer(1:200))),'--', LineWidth=2)
grid on
%legend("RMSE Kalman in qual po periodah","RMSE Kalman in qual za celotno meritev")
set(gca,'fontsize',20)
xlabel("$n$  period", 'interpreter', 'latex', 'FontSize',30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)

subplot(614)
hold on
plot(RMSEkalvirtPoPer(1:200), LineWidth=2)
plot(linspace(RMSEkalvirt,RMSEkalvirt,length(RMSEkalvirtPoPer(1:200))),'--', LineWidth=2)
grid on
%legend("RMSE Kalman in qual z virt tocko po periodah", "RMSE Kalman in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("$n$  period", 'interpreter', 'latex', 'FontSize',30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)

subplot(615)
hold on
plot(RMSEcompqualPoPer(1:200), LineWidth=2)
plot(linspace(RMSEcompqual,RMSEcompqual,length(RMSEcompqualPoPer(1:200))),'--', LineWidth=2)
grid on
%legend("RMSE Complementary in qual po periodah","RMSE Kalman in qual za celotno meritev")
set(gca,'fontsize',20)
xlabel("$n$  period", 'interpreter', 'latex', 'FontSize', 30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)

subplot(616)
hold on
plot(RMSEcompvirtPoPer(1:200), LineWidth=2)
plot(linspace(RMSEcompvirt,RMSEcompvirt,length(RMSEcompvirtPoPer(1:200))),'--', LineWidth=2)
grid on
%legend("RMSE Complementary in qual z virt tocko po periodah", "RMSE Kalman in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("$n$  period", 'interpreter', 'latex', 'FontSize', 30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)

% subplot(717)
% hold on
% plot(RMSEqualvirtPoPer)
% plot(linspace(RMSEvirtqual,RMSEvirtqual,length(RMSEqualvirtPoPer)))
% grid on
% xlabel("$n$  periods", 'interpreter', 'latex', 'FontSize',10)
% ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 10)
% legend("RMSE qual z in brez virt tocke po periodah", "RMSE qual z in brez virt tocke za celotno meritev")




%% Ce ni meritve z virtualno tocko

figure; 

subplot(311)
hold on
plot(RMSEcalqualPoPer)
plot(linspace(RMSEcalqual,RMSEcalqual,length(RMSEcalqualPoPer)))
grid on
xlabel("n period")
ylabel("RMSE [deg]")
legend("RMSE kalibrirani in qual po periodah","RMSE kalibrirani in qual za celotno meritev")


subplot(312)
hold on
plot(RMSEkalqualPoPer)
plot(linspace(RMSEkalqual,RMSEkalqual,length(RMSEkalqualPoPer)))
grid on
xlabel("n period")
ylabel("RMSE [deg]")
legend("RMSE Kalman in qual po periodah","RMSE Kalman in qual za celotno meritev")

subplot(313)
hold on
plot(RMSEcompqualPoPer)
plot(linspace(RMSEcompqual,RMSEcompqual,length(RMSEcompqualPoPer)))
grid on
xlabel("n period")
ylabel("RMSE [deg]")
legend("RMSE Complementary in qual po periodah","RMSE Complementary in qual za celotno meritev")

%% Shranjevanje rezultatov v .mat datoteko

%save('data/rezultati_meritev/01062022_M2_2_6_comp.mat', "alfaz1Per", "alfaz1Indx", "RMSEcalqual", "RMSEcalqualPoPer", "RMSEkalqual", "RMSEkalqualPoPer", "RMSEcompqualPoPer", "RMSEcompqual");
save('data/rezultati_meritev/23082022_M5_62.mat', "alfaz1virtPer", "alfaz1virtIndx", "RMSEcalqual", "RMSEcalqualPoPer", "RMSEcalvirt", "RMSEcalvirtPoPer", "RMSEkalqual", "RMSEkalqualPoPer", "RMSEkalvirt", "RMSEkalvirtPoPer", "RMSEvirtqual", "RMSEqualvirtPoPer", ...
    "RMSEcompqualPoPer", "RMSEcompvirtPoPer", "RMSEcompvirt", "RMSEcompqual")


%% Racunanje stdev
stdCompVirt = 2*std(RMSEcompvirtPoPer)
stdCompQual = 2*std(RMSEcompqualPoPer)

stdKalVirt = 2*std(RMSEkalvirtPoPer)
stdKalQual = 2*std(RMSEkalqualPoPer)

stdCalVirt = 2*std(RMSEcalvirtPoPer)
stdCalQual = 2*std(RMSEcalqualPoPer)


%% Racunanje kadence

meanKad = mean(alfaz1virtPer)
stdKad = 2*std(alfaz1virtPer)

%%
figure;

subplot(311)
hold on
plot(RMSEcalvirtPoPer, LineWidth=2)
plot(linspace(RMSEcalvirt,RMSEcalvirt,length(RMSEcalvirtPoPer)),'--', LineWidth=2)
grid on
%legend("RMSE kalibrirani in qual z virt tocko po periodah", "RMSE kalibrirani in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("n  period", 'interpreter', 'latex', 'FontSize',30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)



subplot(312)
hold on
plot(RMSEkalvirtPoPer, LineWidth=2)
plot(linspace(RMSEkalvirt,RMSEkalvirt,length(RMSEkalvirtPoPer)),'--', LineWidth=2)
grid on
%legend("RMSE Kalman in qual z virt tocko po periodah", "RMSE Kalman in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("n  period", 'interpreter', 'latex', 'FontSize',30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)



subplot(313)
hold on
plot(RMSEcompvirtPoPer, LineWidth=2)
plot(linspace(RMSEcompvirt,RMSEcompvirt,length(RMSEcompvirtPoPer)),'--', LineWidth=2)
grid on
%legend("RMSE Complementary in qual z virt tocko po periodah", "RMSE Kalman in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("n  period", 'interpreter', 'latex', 'FontSize', 30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)

%%
figure;

subplot(311)
hold on
plot(RMSEcalqualPoPer, LineWidth=2)
plot(linspace(RMSEcalqual,RMSEcalqual,length(RMSEcalqualPoPer)),'--', LineWidth=2)
grid on
%legend("RMSE kalibrirani in qual z virt tocko po periodah", "RMSE kalibrirani in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("n  period", 'interpreter', 'latex', 'FontSize',30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)



subplot(312)
hold on
plot(RMSEkalqualPoPer, LineWidth=2)
plot(linspace(RMSEkalqual,RMSEkalqual,length(RMSEkalqualPoPer)),'--', LineWidth=2)
grid on
%legend("RMSE Kalman in qual z virt tocko po periodah", "RMSE Kalman in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("n  period", 'interpreter', 'latex', 'FontSize',30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)



subplot(313)
hold on
plot(RMSEcompqualPoPer, LineWidth=2)
plot(linspace(RMSEcompqual,RMSEcompqual,length(RMSEcompqualPoPer)),'--', LineWidth=2)
grid on
%legend("RMSE Complementary in qual z virt tocko po periodah", "RMSE Kalman in qual z virt tocko za celotno meritev")
set(gca,'fontsize',20)
xlabel("n  period", 'interpreter', 'latex', 'FontSize', 30)
ylabel("RMSE $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)


%%

save('workSpaceERK2.mat')


%% STDEV za Qualisys za merjeni kot
maximumiAlfaz1virt = zeros(length(alfaz1virtIndx),1);
for i = 1:length(alfaz1virtIndx)
    maximumiAlfaz1virt(i) = alfaz1virt(i);
end
stDevMaximumov = 2*std(maximumiAlfaz1virt)
povprecjeMaximumov = mean(maximumiAlfaz1virt)

%% Iskanje minimumov

lokalniMinimumi = islocalmin(alfaz1virt, MinProminence=20)
tVirt = 0:0.01:0.01*(length(alfaz1virt)-1);
hold on;
plot(tVirt, alfaz1virt)
plot(tVirt(lokalniMinimumi), alfaz1virt(lokalniMinimumi))

% shranjevanje indexov 
j = 1;
for i = 1:length(lokalniMinimumi)
    if lokalniMinimumi(i) == 1
        lokMinIndx(j)=i;
        j = j+1;
    end
end
lokMinIndx = lokMinIndx';
%%

minimumiAlfaz1virt = zeros(length(lokMinIndx),1);
minimumiAlfaz1virt = alfaz1(lokMinIndx);
stDevMinimumov = 2*std(minimumiAlfaz1virt)
povprecjeMinimumov = mean(minimumiAlfaz1virt)