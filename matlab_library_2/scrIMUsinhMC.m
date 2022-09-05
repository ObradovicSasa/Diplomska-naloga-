%% Sihnronizacija MC meritev in IMU meritev za primerjavo glede na kot kolena

%% Iskanje maksimum za vsklajevanje obeh meritev
[accmax,accindex] = max(acc1(1:7000,2));
[xmax,index] = max(xacc);


%% Sekanje in decimacija mc meritev

neKorVl = Vl; % Nekorigirana meritev Vastus lateralisa
Vl = korVl(index+200:10:end);
neKorVm = Vm; % Nekorigirana meritev Vastus medialisa
Vm = korVm(index+200:10:end);
neKorBf = Bf; % Nekorigirana meritev Biceps femorisa
Bf = korBf(index+200:10:end);

tmc = tmc(index+200:10:end);


%% Sekanje IMU meritev

acc1 = acc1(accindex+20:end, :);
acc2 = acc2(accindex+20:end, :);
om1 = om1(accindex+20:end, :);
om2 = om2(accindex+20: end, :);
t = t(accindex+20: end);

%% Skrajsanje na enako dolzino

if length(acc1) > length(Vl) 

    acc1 = acc1(1: length(Vl),:);
    acc2 = acc2(1: length(Vl),:);
    om1  = om1(1: length(Vl),:);
    om2  = om2(1: length(Vl),:);
    t    = t(1: length(Vl));

elseif length(Vl) > length(acc1)

    Vl = Vl(1:length(acc1));
    Vm = Vm(1:length(acc1));
    Bf = Bf(1:length(acc1));
    tmc = tmc(1:length(acc1));
    
end
%% Izris obeh rezultatov

figure;
subplot(411)
plot(acc1)
hold on
plot(acc2)
grid on

subplot(412)
plot(Vl)
hold on
plot(Vm)
plot(Bf)
grid on

subplot(413)
plot(om1)
hold on
plot(om2)
grid on

subplot(414); hold on;
plot(acc1)
plot(Vl(1:length(acc1)))
plot(Vm(1:length(acc1)))
plot(Bf(1:length(acc1)))
grid on



