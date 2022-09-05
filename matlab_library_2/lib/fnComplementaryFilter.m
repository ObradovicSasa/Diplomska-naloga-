function [fi, theta] = fnComplementaryFilter(acc, om, alfa, fs)
%implementacija complementary filtra
%vnos je pospesek s pospeskometra in kotne hitrosti ziroskopov
%alfa doloca koliko je vtez pospesko metra in ziroskopa ;)
%fs doloca cas uzorcenja

ts = 1/fs;

%izracun priblizkov iz pospeskometra
fiAcc = zeros(length(acc), 1);
thetaAcc = zeros(length(acc),1);

%izracun vrednosti iz ziroskopa
%p -> x; q -> y; r -> z 
%uporabimo Eulerjevo integracijsko numericno metodo

fiEuler = zeros(length(om), 1); thetaEuler = zeros(length(om),1);
fiOm = zeros(length(om), 1); thetaOm = zeros(length(om), 1);
fiOm(1, 1) = 0; thetaOm(1, 1) = 0;

for i = 1:length(om)
        %izracun priblizkov iz pospeskometra
        fiAcc(i, :)= atan2(acc(i,2), acc(i,3));
        thetaAcc(i, :) = asin(acc(i,1)/9.81);

        %najprej izracuna euler rates iz zacetnih vrednosti ki so
        %nastavljene na 0 zaradi maksimalne poenostavljenosti
        fiEuler(i,1) = om(i,1) + sin(fiOm(i, :))*tan(thetaOm(i, :))*om(i, 2) + cos(fiOm(i, :))*tan(thetaOm(i, :))*om(i, 3);
        thetaEuler(i,1) = cos(fiOm(i, :))*om(i,2) - sin(fiOm(i, :))*om(i, 3);
        %potem izracuna
        fiOm(i + 1, :) = alfa * fiAcc(i, :) + (1 - alfa)*(fiOm(i, :) + (ts/1000)* fiEuler(i, 1));
        thetaOm(i + 1, :) = alfa * thetaAcc(i, :) + (1 - alfa) * (thetaOm(i, :) + (ts/1000)*thetaEuler(i, 1));
end


%zbrisemo zacetno vrednost, ker je itak le predpostavka :) -> za risanje
%rabimo enako dolzino kot posnetek
fi = fiOm(2:length(fiOm),1);
theta = thetaOm(2:length(thetaOm),1);

end