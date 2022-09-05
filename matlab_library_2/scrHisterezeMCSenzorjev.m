figure
for i = 5:50
    subplot(221); hold on; grid on;
    plot(upAlfaKal(upAlfaKalIndx(i):upAlfaKalIndx(i+1)),upVm(upAlfaKalIndx(i):upAlfaKalIndx(i+1))-mean(upVm))
    set(gca,'fontsize',20)
    xlabel("Kot kolena $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)
    ylabel("Odziv mi\v{s}ic", Interpreter="latex", FontSize=30)

    subplot(222); hold on; grid on;
    plot(upAlfaKal(upAlfaKalIndx(i):upAlfaKalIndx(i+1)),upVl(upAlfaKalIndx(i):upAlfaKalIndx(i+1))-mean(upVm))
    set(gca,'fontsize',20)
    xlabel("Kot kolena $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)
    ylabel("Odziv mi\v{s}ic", Interpreter="latex", FontSize=30)

    subplot(223); hold on; grid on;
    plot(upAlfaKal(upAlfaKalIndx(i):upAlfaKalIndx(i+1)),upBf(upAlfaKalIndx(i):upAlfaKalIndx(i+1))-mean(upVm))
    set(gca,'fontsize',20)
    xlabel("Kot kolena $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)
    ylabel("Odziv mi\v{s}ic", Interpreter="latex", FontSize=30)
end

%% Iskanje minimumov kota kolena

lokalniMinimumi = islocalmin(upAlfaKal, 'MinProminence',20)
tKal = 0:0.01:0.01*(length(upAlfaKal)-1);
hold on;
plot(tKal, upAlfaKal)
plot(tKal(lokalniMinimumi), upAlfaKal(lokalniMinimumi))

% shranjevanje indexov 
j = 1;
for i = 1:length(lokalniMinimumi)
    if lokalniMinimumi(i) == 1
        lokMinIndx(j)=i;
        j = j+1;
    end
end

%%
figure; 
for i = 5:100
    cikel = 0:360/(lokMinIndx(i+1)-lokMinIndx(i)):360;
    subplot(131);hold all; grid on
    plot(cikel,upBf(lokMinIndx(i):lokMinIndx(i+1)))
    subplot(132);hold all; grid on
    plot(cikel,upVm(lokMinIndx(i):lokMinIndx(i+1)))
    subplot(133);hold all; grid on
    plot(cikel,upVl(lokMinIndx(i):lokMinIndx(i+1)))
end
set(gca,'fontsize',20)
xlabel("Kot cikla $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)
ylabel("Kot kolena $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)

