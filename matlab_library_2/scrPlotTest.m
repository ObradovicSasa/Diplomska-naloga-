
korUpMeritevStart = KozaStart - nStart + 1;
korUpMeritevEnd = KozaEnd - nStart + 1;


kozaAlfaKal = alfaKal(korUpMeritevStart:korUpMeritevEnd)-mean(alfaKal(korUpMeritevStart:korUpMeritevEnd));


plot(kozaBf)
hold on
plot(kozaAlfaKal)