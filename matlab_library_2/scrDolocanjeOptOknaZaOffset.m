%% Skripta za dolocanje variance med okni za srednjo vrednost
%namen je poiskati optimum kjer je najmanjsa varianca in tako najti
%optimalno velikost okna za odstevanje offseta -> lahko bi v teoriji
%avtomatizirali proces racunanja in odstevanja offseta ;)

scrDolIntZaSum;
varOken = fnVarZaRazDolzineOken(11, om1c,5);
grad = abs(gradient(varOken));

for i = 1:length(grad)
    if (grad(i,:))/1e-3 < 10
        optOkno = i-2;
        break
    end
end

meanOkn1 = fnMeanOknjenje(om1c, 2^2, 20);
offset = mean(meanOkn1);


