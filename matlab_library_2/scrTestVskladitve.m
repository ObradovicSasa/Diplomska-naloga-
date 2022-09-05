%% Skripta za vskladitev rotacijskih matrik in meritev kota kolena 
% iz opticnega sistema in IMU senzorjev


%% Vsklajevanje vseh meritev
upAlfaz1 = alfaz1 - mean(alfaz1);
alfaKal = alfaKal - mean(alfaKal);
[upAlfaz1, upAlfaKal] = fnSkrajsajSignala(upAlfaz1, alfaKal);
plot(upAlfaKal)
hold on
plot(upAlfaz1)


Rxy = fnRxy(upAlfaKal, upAlfaz1);
[p, plocs] = findpeaks(Rxy, 'MinPeakProminence', 0.00015);
figure; plot(Rxy)
hold on
plot(plocs, Rxy(plocs), '.m', 'MarkerSize', 12)

[maxRxy, maxRxyIndx] = max(p);
upAlfaz1 = [upAlfaz1(plocs(maxRxyIndx):end); upAlfaz1(1:plocs(maxRxyIndx)-1)];

figure; plot(upAlfaz1)
hold on
plot(upAlfaKal)
grid on



zacZ11 = poravRotZ1(:,:,plocs(maxRxyIndx):end);
zacZ12 = poravRotZ1(:,:,1:plocs(maxRxyIndx));
zacS21 = poravRotS2(:,:,plocs(maxRxyIndx):end);
zacS22 = poravRotS2(:,:,1:plocs(maxRxyIndx));



% Shiftanje rotacijskih matrik skupaj s premikom funkcije

for i = 1:length(poravRotZ1(:,:,plocs(maxRxyIndx):end))
    upRotZ1(:,:,i) = zacZ11(:,:,i);
    upRotS2(:,:,i) = zacS21(:,:,i);
end

k = 1;
i = 1;
j = length(poravRotZ1(:,:,plocs(maxRxyIndx):end))+1;

while k == 1 
    if(j < (length(poravRotZ1(:,:,plocs(maxRxyIndx):end))+1)+length(zacZ12))
        upRotZ1(:,:,j) = zacZ12(:,:,i);
        upRotS2(:,:,j) = zacS22(:,:,i);
        j = j+1;
        i = i+1;
    else
        k = 0;
    end
end




