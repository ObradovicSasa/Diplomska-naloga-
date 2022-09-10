%% Skripta za uvoz podatkov z MC senzorjev

%% Najprej izberemo na katere vhode smo dali mc senzorje 
LoggerLoad;

%% Izlocitev iz ans vrednosti ki jo vrne LoggerLoad funkcija 

% Treba je za vsako novo meritev preveriti katere so misice bile merjene,
% sicer pa meritev ni uporabna, ker ne vemo kateri misici pripada!

fsMc = 1000; % MC senzorji vzorcijo s frekvenco 1000 Hz
tmc  = ans(1:end-11,1); % Cas meritve MC senzorja
Vm   = ans(1:end-11,3); % Vastus medialis
Bf   = ans(1:end-11,4); % Biceps femoris
Vl   = ans(1:end-11,2); % Vastus lateralis
xacc = ans(1:end-11,5);

%% Plot MC meritev vse skupaj

% Potrebno je tudi ustrezno poimenovati legendo za posamezne misice !

plot(tmc, Vm)
hold on
plot(tmc, Bf)
hold on
plot(tmc, Vl)
plot(tmc, xacc)
grid on
legend('Vastus medialis','Biceps femoris','Vastus lateralis')
xlabel('t(s)')
ylabel('Pritisk misic(mV/V)') 