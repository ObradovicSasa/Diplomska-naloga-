function [indxPeriod, velikostPeriod] = fnPerioda(meritev)
    % Funkcija poisce indexe vseh period za dano meritev, ter shrani
    % velikosti period za kasnejse dolocanje st. dev kot tudi povprecne
    % vrednosti period
    [meritevMax, meritevMaxIndx] = findpeaks(meritev, 'MinPeakProminence', 20);
    
    j = 1;
    for i = 1:length(meritevMaxIndx)-1
        velikostPeriod(j, 1) = meritevMaxIndx(i+1,1) - meritevMaxIndx(i,1);
        j = j+1;
    end
    indxPeriod = meritevMaxIndx;


end