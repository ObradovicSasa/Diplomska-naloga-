%% Vsklajevanje vseh meritev
upAlfaz1 = alfaz1 - mean(alfaz1);
alfaKal = alfaKal - mean(alfaKal);
[upAlfaz1, alfaKal] = fnVskladiSignala(upAlfaz1, alfaKal);
plot(alfaKal)
hold on
plot(upAlfaz1)

%[xVskladi, yVskladi] = ginput(2);
% prvi dve sta za vskladitev IMU in Qualisysa
%xVskladi = round(xVskladi);
%nVskladiStart  = xVskladi(1); nVskladiEnd    = xVskladi(2);
% drugi dve sta za vskladitev 

% upAlfaKal = alfaKal(nVskladiStart:nVskladiEnd);
% upAlfaz1 = alfaz1(nVskladiStart:nVskladiEnd);
% upAlfaComp = alfaComp(nVskladiStart:nVskladiEnd);
% upAlfa = alfa(nVskladiStart:nVskladiEnd);
% upAlfaFilt = alfaFilt(nVskladiStart:nVskladiEnd);
% upAlfaCal = alfaCal(nVskladiStart:nVskladiEnd);


Rxy = fnRxy(alfaKal, upAlfaz1);
[p, plocs] = findpeaks(Rxy, 'MinPeakProminence', 0.00015);
figure; plot(Rxy)
hold on
plot(plocs, Rxy(plocs), '.m', 'MarkerSize', 12)

upAlfaz1 = [upAlfaz1(plocs(1):end); upAlfaz1(1:plocs(1)-1)];

