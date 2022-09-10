function meanOken = fnMeanZaRazDolzineOken(eksp, omega, tau)
    
    if nargin < 3
        tau = 0;
        n = 2.^(1:eksp)';
        meanOkna = zeros(length(omega), 3);
        for i = 1:length(n)
            meanOkna(i,:) = fnMeanOknjenje(omega, n(i));
        end
        for i = 1:length(meanOkna)
            if meanOkna(i,:) == 0
                cutOffElement = i-1;
                break
            end
        end
        meanOken = meanOkna(1:cutOffElement, :);
    else
        n = 2.^(1:eksp)';
        meanOkna = zeros(length(omega), 3);
        for i = 1:length(n)
            meanOkna(i,:) = fnMeanOknjenje(omega, n(i), tau);
        end
        for i = 1:length(meanOkna)
            if meanOkna(i,:) == 0
                cutOffElement = i-1;
                break
            end
        end
        meanOken = meanOkna(1:cutOffElement, :);
    end
    figure;
    subplot(121)
    loglog(meanOken)
    grid on
    subplot(122)
    plot(meanOken)
    grid on
end