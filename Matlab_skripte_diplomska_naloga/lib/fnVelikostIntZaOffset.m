function offsetEnd = fnVelikostIntZaOffset(omega, x)

% Izracuna interval za odstevanje offseta tako da pogleda naslednjo in
% prejsnjo meritev, ter iz njihove razlike doloci zadnjo tocko kjer je
% validen interval za odstevanje offseta, 
% x-> parameter s katerim lahko odstejemo od konca se doloceno stevilo
% meritev, ce bi se iskazalo da smo slucajno vzeli nekaj zacetnih vzorcev
% meritve

if nargin < 2
    x = 0;
    laufZanko = 1;
    omega = abs(omega);
    i = 1; %zacetna tocka
    while laufZanko
        razlikaVrednosti = omega(i+1, 1) - omega(i, 1);
        if abs(razlikaVrednosti) >= 5
            laufZanko = 0;
        else
            i = i + 1;
        end
    end

    offsetEnd = i;

else
    laufZanko = 1;
    i = 1; %zacetna tocka
    omega = abs(omega);
    while laufZanko
        razlikaVrednosti = omega(i+1, 1) - omega(i, 1);
        if abs(razlikaVrednosti) >= 5
            laufZanko = 0;
        else
            i = i + 1;
        end
    end

    offsetEnd = i - x;

end

end