function alfaCorr = fnNaNKorekcija(alfa)

for i=1:length(alfa)
    if isnan(alfa(i))
       alfa(i) = alfa(i-1)-1;
    end
end

alfaCorr = alfa;

end