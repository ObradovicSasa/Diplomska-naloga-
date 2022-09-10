function [xOffset, xCal] = fnOffset(x, n, xReal)

%% funkcija izracuna odklon od stacionarnega stanja
%% x     - vhodni signal
%% n     - razpon za racunanje stacionarnega stanja

xOffset = mean(x(n(1):n(2),:) - xReal);
xCal    = x - xOffset;