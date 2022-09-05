function zamik = fnVskladiKota(alfa1, alfa2)
% Vskladi meritev kota glede na to katera je daljsa meritev, oz katera ima
% daljse posneto mirovanje :D
% Vsklajevanje je vedno narejeno tako da je alfa1 daljsi od alfa2, torej je
% treba biti pozoren pri klicu funkcije kateri signal je daljsi od drugega

    alfa1Enosmerna = mean(alfa1);
    alfa1 = alfa1 - mean(alfa1);
    alfa2 = alfa2 - mean(alfa2);
    [alfa1, alfa2] = fnSkrajsajSignala(alfa1, alfa2);
    plot(alfa1)
    hold on
    plot(alfa2)

    
    Rxy = fnRxy(alfa2, alfa1);
    [p, plocs] = findpeaks(Rxy, 'MinPeakProminence', 0.00015);
    figure; plot(Rxy)
    hold on
    plot(plocs, Rxy(plocs), '.m', 'MarkerSize', 12)
    
    [maxRxy, maxRxyIndx] = max(p);
    zamik = plocs(maxRxyIndx);


end