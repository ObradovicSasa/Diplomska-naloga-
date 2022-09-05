%% Iskanje minimumov kota kolena

lokalniMinimumi = islocalmin(alfaKal)
tKal = 0:0.01:0.01*(length(alfaKal)-1);
hold on;
plot(tKal, alfaKal)
plot(tKal(lokalniMinimumi), alfaKal(lokalniMinimumi))

% shranjevanje indexov 
j = 1;
for i = 1:length(lokalniMinimumi)
    if lokalniMinimumi(i) == 1
        lokMinIndx(j)=i;
        j = j+1;
    end
end

%%
figure; hold all; grid on
for i = 100:1500
    cikel = 0:360/(lokMinIndx(i+1)-lokMinIndx(i)):360;
    plot(cikel,alfaKal(lokMinIndx(i):lokMinIndx(i+1)))

end
set(gca,'fontsize',20)
xlabel("Kot cikla $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)
ylabel("Kot kolena $[^{\circ}]$", 'interpreter', 'latex', 'FontSize', 30)



