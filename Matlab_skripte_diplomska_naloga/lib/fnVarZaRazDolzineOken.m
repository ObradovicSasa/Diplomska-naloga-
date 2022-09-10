function varOken = fnVarZaRazDolzineOken(eksp, omega, tau)
    
    if nargin < 3
        tau = 0;
        n = 2.^(1:eksp)';
        varOkna = zeros(length(omega), 3);
        for i = 1:length(n)
            varOkna(i,:) = var(fnMeanOknjenje(omega, n(i)),1);
        end
        for i = 1:length(varOkna)
            if varOkna(i,:) == 0
                cutOffElement = i-1;
                break
            end
        end
        varOken = varOkna(1:cutOffElement, :);
    else
        n = 2.^(1:eksp)';
        varOkna = zeros(length(omega), 3);
        for i = 1:length(n)
            varOkna(i,:) = var(fnMeanOknjenje(omega, n(i), tau),1);
        end
        for i = 1:length(varOkna)
            if varOkna(i,:) == 0
                cutOffElement = i-1;
                break
            end
        end
        varOken = varOkna(1:cutOffElement, :);
    end
    figure;
    subplot(121)
    loglog(varOken)
    grid on
    subplot(122)
    plot(varOken)
    grid on
end
