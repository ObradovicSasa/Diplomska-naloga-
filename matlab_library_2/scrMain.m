%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Glavna skripta za diplomsko nalogo - kolesarjenje :) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Vkljucitev datotek
scrAddPath;

%% Uvoz podatkov iz Qualisys opticnega sistema
% pred izvedbo izbrati meritev!(treba je tudi pravilno izbrati v scr!)
load data/21072022_M2/Qualisys/21072022_M2.mat
%%
% ko je prebrana .mat datoteka, je treba ustrezno spremeniti parametre za
% uvoz!
scrQualisysUvoz;
% dolocitev kolenskega kota in korekcija NaN vrednosti v meritvah
scrQualisysKot;

%% Import meritev MC senzorjev
% Pred vsakim importom je pomembno pogledati ce se ujemajo meritve z
% ustreznimi misicami!!! V nasprotnem so meritve popolnoma neuporabne, saj
% ne znamo kateri misici pripada odziv!

scrMcImport;

%% Izravnava MC meritev (NI TREBA CE JE UPORABLJENA SCR ZA DRUG LOGGER!)
% Zaradi temperaturnega segrevanja senzorjev, ter vpliva lepilnega traku na
% njihovo postavitev na kozi, se pokvari karakteristika MC senzorjev, kar
% je treba ustrezno izravnati

scrIzravnavaMCMeritev;

% Ce ni nobenih cudnih prehodov v meritvah se uporabi polinom poljubne
% stopnje za aproksimacijo trenda, ki se potem odsteje skupaj z enosmerno
% komponento

%% Ce je bil uporabljen novejsi logger potem uporabiti tole skripto za import!

load data/20072022/MCTest/MeritveFE_MCexport_20Jul22_02.csv
%% Potrebno je nujno odpreti skripto in zamenjati ustrezno spremenljivko mc preden zazenemo!

scrMCImportDrugLogger;

%% Uvoz podatkov iz IMU senzorjev
% pred uvozom preveriti u skripti ali so pravilne meritve izbrane !
fs = 100; % frekvenca vzorcenja - ustrezno nastaviti!
scrUvozIMU;

%% Sinhronizacija posnetkov IMU in MC senzorjev
% Uporabi se en delta impulz (priblizek z enim hitrim udarcem na senzorje),
% za poravnavo senzorjev v sinhronizacijo, potem se daljsa meritev skrajsa
% na tisto krajso in imamo vsklajeni meritvi
scrIMUsinhMC;


%% V primeru da je bil zarotiran model za kot kolena za Pi rad 
% Ce je bil pri meritvi model bil zasukan za kot od 180 stopinj se uporabi
% preprosto mnozenje z rotacijsko matriko
% Mnozenje gre Rot*vektor, saj so rotacije glede na relativni koordinatni
% sistem

scrRotKoordSis;

%% Sekanje MC meritev
% 
% Prva dva timestamp-a sta za uporabno meritev
% Druga dva sta za izracun vpliva kontrakcije koze na meritev in
% kalibracijo

scrMCSekanje;

%% Rezanje signala in shranjevanje v .mat datoteko za kasnejso obdelavo
% EDIT: shranjevanje v .mat se vedno deluje, vendar se lahko zanemari
% opcija
% NJUJNO! poimenovati .mat datoteke za meritve v spodnji skripti
% na prvem grafu sta prva dva klika za odstevanje stacionarnega stanja
% druga dva pa sta dolzina meritve
% na drugem grafu sta klika namenjena odstevanju stacionarnega stanja pri
% drugem senzorju tako kot pri prvem
scrSekanjeMeritev;

%% Odstevanje offseta pri ziroskopu 
scrKalibInOffset;

%% Izracuni kota iz cistih, filtriranih in meritev z odstetim offsetom, ter kalibracijo
scrDolKotov;

%% Dolocanje kota iz skalarnega produkta - testno oz. ni uporabljeno
scrKoti3D;

%% Complementary filter
% uporabljena izvedba iz Sensor fusion and tracking toolbox-a
% magnetometer je ugasnjen zaradi kovine na kolesu, ki povzroca precejsnje
% motnje
scrCompFilter;

%% Kalman filter
% uporabljena izvedba iz Sensor fusion and tracking toolbox-a
% za spremembo parametrov filtra poglej spodnjo skripto :)
% vkljucena primerjava vektorja gravitacije dolocenega z uporabo Kalmana in
% odstevanjem offseta
% vkljucena primerjava kota dolocenega iz lowpass filtracije in Kalmanovega
% filtra
scrKalmanFilter;

%% Izracun RMSE vseh meritev
% Nujno pogledati koliko je odstopanje pri alfaz1 zaradi pozicije
% markerjev! in popraviti v skripti v prvi vrstici!!!
% Izracuna tudi interval zaupanja za RMSE v velikosti 2*stdev, ter izracuna
% povprecno kadenco skupaj z intervalom zaupanja :)
scrRMSE;

%% Graficna primerjava vseh metod za dolocanje kota
% EDIT: tale skripta je outdated -> ni uporabljena pri izdelavi diplomske
% naloge :)
scrPrimerjava;


%% Se ne svrstane napisane skripte med izdelavo diplome
% skripte napisane v glavnem z uporabo MC meritev in njihovo primerjavo
% glede na kot kolena
scrPrimerjavaMcQualImu;
scrKompKoze; %% kljub pravilni implementaciji ni uspesno :(
scrPrimerjavaObremenitev;
scrTestDolZacOrientacije; %% ni uporabljeno
scrHisterezeMCSenzorjev;
scrPovprecniOdzivMisiceInStDev; % Za Simonovo meritev misic, kjer je ocitna sprememba obremenitve!
scrMCStdevInPovp; % Za moje meritve, prikaz povprecnega odziva posamezne misice skupaj z intervalom od +-2*stdev
