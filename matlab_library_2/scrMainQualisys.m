load data/KotKolenaLab04032022/Measurement1.mat;
M = Measurement1;
L = length(M.Trajectories.Labeled.Data);
t = 0:L-1;
t = t./M.FrameRate;
ZD = squeeze(M.Trajectories.Labeled.Data(3,1:3,:))';
ZL = squeeze(M.Trajectories.Labeled.Data(4,1:3,:))';
SD = squeeze(M.Trajectories.Labeled.Data(1,1:3,:))';
SL = squeeze(M.Trajectories.Labeled.Data(2,1:3,:))';

figure;
subplot(221)
plot(t,ZD)
xlabel('$t\ [\mathrm{s}]$', 'Interpreter', 'Latex')
ylabel('$ZD\ [\mathrm{mm}]$', 'Interpreter', 'Latex')
legend('$x$','$y$','$z$','Interpreter', 'Latex')
subplot(222)
plot(t,ZL)
xlabel('$t\ [\mathrm{s}]$', 'Interpreter', 'Latex')
ylabel('$ZL\ [\mathrm{mm}]$', 'Interpreter', 'Latex')
subplot(223)
plot(t,SD)
xlabel('$t\ [\mathrm{s}]$', 'Interpreter', 'Latex')
ylabel('$SD\ [\mathrm{mm}]$', 'Interpreter', 'Latex')
subplot(224)
plot(t,SL)
xlabel('$t\ [\mathrm{s}]$', 'Interpreter', 'Latex')
ylabel('$SL\ [\mathrm{mm}]$', 'Interpreter', 'Latex')

ZD_fft = fft(ZD)./L; 
ZL_fft = fft(ZL)./L; 
SD_fft = fft(SD)./L; 
SL_fft = fft(SL)./L; 
f = 0:L-1; f = f*M.FrameRate./L;
N4plot1 = 2;
N4plot2 = 30;

figure;
subplot(221)
plot(f(N4plot1:N4plot2),abs(ZD_fft(N4plot1:N4plot2,:)))
xlabel('$f\ [\mathrm{Hz}]$', 'Interpreter', 'Latex')
ylabel('$ZD$', 'Interpreter', 'Latex')
legend('$x$','$y$','$z$','Interpreter', 'Latex')
subplot(222)
plot(f(N4plot1:N4plot2),abs(ZL_fft(N4plot1:N4plot2,:)))
xlabel('$f\ [\mathrm{Hz}]$', 'Interpreter', 'Latex')
ylabel('$ZL$', 'Interpreter', 'Latex')
subplot(223)
plot(f(N4plot1:N4plot2),abs(SD_fft(N4plot1:N4plot2,:)))
xlabel('$f\ [\mathrm{Hz}]$', 'Interpreter', 'Latex')
ylabel('$SD$', 'Interpreter', 'Latex')
subplot(224)
plot(f(N4plot1:N4plot2),abs(SL_fft(N4plot1:N4plot2,:)))
xlabel('$f\ [\mathrm{Hz}]$', 'Interpreter', 'Latex')
ylabel('$SL$', 'Interpreter', 'Latex')


