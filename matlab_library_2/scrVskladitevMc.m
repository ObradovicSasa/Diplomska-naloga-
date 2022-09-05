%%

plot(Vm)
hold on
plot(Bf)
hold on
plot(Vl)
grid on
[xmc, ymc] = ginput(2);
xmc = round(xmc);
nCalStartMc   = xmc(1); nCalEndMc   = xmc(2);


%% Sekanje meritve MC

tmc = tmc(nCalStartMc:nCalEndMc);
Vm = Vm(nCalStartMc:nCalEndMc);
Vl = Vl(nCalStartMc:nCalEndMc);
Bf = Bf(nCalStartMc:nCalEndMc);

%%

plot(tmc, Vm)
hold on
plot(tmc, Bf)
hold on
plot(tmc, Vl)
grid on
legend('Vastus medialis','Biceps femoralis','Vastus lateralis')
xlabel('t(s)')
ylabel('Pritisk misic(mV/V)') 