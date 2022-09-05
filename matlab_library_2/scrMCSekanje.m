%% Sekanje delov MC meritev -> uporabne meritve in odstevanje efekta koze

%% Plot meritev
figMc = figure;
plot(Vl)
hold on 
plot(Vm)
plot(Bf)
legend("Vastus Lateralis","Vastus Medialis","Biceps Femoris");
xlabel("n")
ylabel("Pritisk misic [mV/V]")
grid on

% Sekanje meritev
% Prva dva timestamp-a sta za odsek uporabne meritve
% Druga dva odseka sta za vpliv kontrakcije koze na meritev

[xMc, yMc] = ginput(4);
xMc = round(xMc);
close(figMc)
UpMeritevStart    = xMc(1); UpMeritevEnd    = xMc(2);
KozaStart         = xMc(3); KozaEnd         = xMc(4); 

%% Shranjevanje meritev v delih

upVl = Vl(UpMeritevStart:UpMeritevEnd); %uporabna meritev vastus lateralisa
upVm = Vm(UpMeritevStart:UpMeritevEnd); %uporabna meritev vastus medialisa
upBf = Bf(UpMeritevStart:UpMeritevEnd); %uporabna meritev biceps femorisa


kozaVl = Vl(KozaStart:KozaEnd);  %vpliv kontrakcije koze pri vastus lateralisu
kozaVm = Vm(KozaStart:KozaEnd); %vpliv kontrakcije koze pri vastus medialisu
kozaBf = Bf(KozaStart:KozaEnd);  %vpliv kontrakcije koze pri biceps femorisu

%% Plot sekanih meritev

figSekanMc = figure;
subplot(211)
plot(upVl)
hold on
plot(upVm)
plot(upBf)
grid on
legend("Vastus lateralis","Vastus medialis", "Biceps femoris")
xlabel("n")
ylabel("Pritisk misic [mV/V]")

subplot(212)
plot(kozaVl)
hold on
plot(kozaVm)
plot(kozaBf)
grid on
legend("Vastus lateralis -> koza", "Vastus medialis -> koza", "Biceps femoris -> koza")
xlabel("n")
ylabel("Vpliv kontrakcije koze [mV/V]")
