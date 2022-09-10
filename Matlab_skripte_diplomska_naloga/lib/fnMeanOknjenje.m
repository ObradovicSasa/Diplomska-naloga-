function meanOknjenje = fnMeanOknjenje(omega,m,tau)
%Oknjene in primerjava srednje vrednosti pri meritvi
%m->dolzina okna
%tau->interval zamika, ce zelimo da se okna med seboj prekrivata ;)

if nargin < 3
    tau = 0;
    stIteracij = floor(length(omega)/m);
    meanPoOdsekih = zeros(stIteracij,3);
    omegaVzorcev = omega(1:stIteracij*m, :);
    for i= 0:stIteracij-1
        meanPoOdsekih(1+i, :) = mean(omegaVzorcev(1+i*m:(i+1)*m, :));
    end
    meanOknjenje = meanPoOdsekih;
else
    stIteracijM = (floor(length(omega)/m))*m;
    stIteracijTau = floor((stIteracijM-m)/tau);
    meanPoOdsekih = zeros(stIteracijTau,3);
    omegaVzorcev = omega(1:stIteracijTau*tau+m, :);
    for i= 0:stIteracijTau-1
        meanPoOdsekih(1+i, :) = mean(omegaVzorcev(1+i*tau:1+i*tau+m, :));
    end
    meanOknjenje = meanPoOdsekih;

end


end


