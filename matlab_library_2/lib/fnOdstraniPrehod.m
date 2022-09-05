function y = fnOdstraniPrehod(x)
% pogleda ce so odstopanja sosednjih dveh vrednosti prevelika -> ce so
% potem odsteje/pristeje kot od 2pi, zaradi preskoka 

for i = 2:length(x) 
    if((x(i)-x(i-1)) > 300) 
        x(i) = x(i) - 360;
    elseif (x(i) - x(i-1) < - 300)
        x(i) = x(i) + 360;
    end 

end

y = x;

end