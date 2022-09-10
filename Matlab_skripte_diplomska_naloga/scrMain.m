%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Glavna skripta za diplomsko nalogo - kolesarjenje :) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Vkljucitev datotek
scrAddPath;

%% Uvoz podatkov iz Qualisys opticnega sistema
% pred izvedbo izbrati meritev(treba je tudi pravilno izbrati v scr - 
% preimenovati q spremenljivko ustrezno)
load data/23082022/Qualisys/23082022_M3.mat
%%
% skripta naredi uvoz rotacijskih matrik iz meritev opticnega sistema, ter
% NaN vrednosti ustrezno dopolni
scrQualisysUvoz;

%% Uvoz meritev MC senzorjev
% Pred vsakim importom je pomembno pogledati ce se ujemajo meritve z
% ustreznimi misicami. V nasprotnem so meritve popolnoma neuporabne, saj
% ne znamo kateri misici pripada odziv.

scrMcImport;

%% Izravnava MC meritev
% Zaradi temperaturnega segrevanja senzorjev, ter vpliva lepilnega traku na
% njihovo postavitev na kozi, se pokvari karakteristika MC senzorjev, kar
% je treba ustrezno izravnati

scrIzravnavaMCMeritev;

% Ce ni nobenih cudnih prehodov v meritvah se uporabi polinom poljubne
% stopnje za aproksimacijo trenda, ki se potem odsteje skupaj z enosmerno
% komponento

%% Uvoz podatkov iz IMU senzorjev
% pred uvozom preveriti u skripti ali so pravilne meritve izbrane (ustrezno
% je treba spremeniti vrednosti spremenljivk ACCDATA in GYRODATA)
fs = 100; % frekvenca vzorcenja - ustrezno nastaviti
scrUvozIMU;

%% Sinhronizacija posnetkov IMU in MC senzorjev
% Uporabi se en delta impulz (priblizek z enim hitrim udarcem na senzorje),
% za poravnavo senzorjev v sinhronizacijo, potem se daljsa meritev skrajsa
% na tisto krajso in imamo vsklajeni meritvi
scrIMUsinhMC;

%% Poravnava intrinsicnega koordinatnega sistema IMU senzorjev in togih teles
% Rotacija meritev IMU senzorjev za 180 stopinj
% Mnozenje je narejeno s postopkom premultiplikacije Rot*vektor, saj so 
% rotacije glede na lokalni koordinatni sistem IMU senzorjev
scrRotKoordSis;

%% Skrajsevanje MC meritev
% Skrajsevanje MC meritev na interval kjer je meritev uporabna, saj lahko
% pride do popacitev med opravljanjem meritev
scrMCSkrajsevanje;

%% Skrajsevanje meritev IMU senzorjev na del za odstevanje odmika ziroskopov in uporabno meritev
% Prve dve casovni znacki sta za izracun odmika prvega ziroskopa
% naslednji dve casovni znacki sta za skrajsevanje meritve na uporabni del
% poslednji dve znacki sta za izracun odmika drugega ziroskopa
% za bolj natancen izracun odmika se se enkrat izbereta casovni znacki
% vendar le na od prej dolocenem intervalu
scrSkrajsevanjeMeritev;

%% Odstevanje odmika ziroskopa od stacionarnega stanja in rotacija vektorja g
scrKalibInOffset;

%% Complementary filter
% uporabljena izvedba iz Sensor fusion and tracking toolbox-a
% magnetometer je ugasnjen zaradi kovine na kolesu, ki povzroca precejsnje
% motnje
% utez je nastavljena na vrednost 0.001 - lahko se spreminja kot parameter
% AccelerometerGain
scrCompFilter;

%% Kalman filter
% uporabljena izvedba iz Sensor fusion and tracking toolbox-a
% za spremembo parametrov filtra poglej skripto :)
% vkljucena primerjava vektorja gravitacije dolocenega z uporabo Kalmana in
% osnovne meritve
scrKalmanFilter;

%% Izracuni kota iz osnovne meritve in Qualisys opticnega sistema;
% Skupno vsklajevanje meritev s pomocjo korelacijske funkcije
scrDolKotov;

%% Izracun RMSE po periodah meritve; 
% izracun minimalnega in maksimalnega kota kolenskega sklepa s pomocjo
% opticnega sistema; izracun povprecne kadence kolesarja, ter izris
% povprecnega RMSE in RMSE pogreska po periodah
scrRMSE;

%% Primerjava MC meritev skupaj z izmerjenim kotom iz Kalmanovega filtra in Qualisys meritev
% Stevilo izrisanih period lahko uporabnik sam doloci v skripti
scrPrimerjavaMcQualImu;

%% Primerjava manjse in vecje obremenitve pri MC meritvah skupaj z izmerjenim kotom kolena
% Stevilo izrisanih period lahko uporabnik sam doloci v skripti
scrPrimerjavaObremenitev;

%% Izris meritev MC senzorjev glede na kot kolenskega sklepa - histereze
scrHisterezeMCSenzorjev;

%% Izracun povprecnega odziva misic glede na periodo kota kolena, ter intervala zaupanja
% prva skripta je namenjena za meritve, kjer je obcutljiva sprememba
% obremenitve na kolesu
scrPovprecniOdzivMisiceInStDev;
%% 
% druga skripta je namenjena za meritve, kjer ni bilo obcutljive spremebe
% obremenitve na kolesu
scrMCStdevInPovp;
