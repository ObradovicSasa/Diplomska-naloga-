function fnPlotGOrient(t, acc ,g, gCal, bitPlotAngle)%bitPlotAngle je se selekcija za izris kotov

if bitPlotAngle
    for i=1:length(g)
        phi(i) = acos(g(i,:)*acc(i,:)'/norm(g(i,:))/norm(acc(i,:)))*180/pi;
        phiCal(i) = acos(gCal(i,:)*acc(i,:)'/norm(gCal(i,:))/norm(acc(i,:)))*180/pi;
    end
end

burgundy = [0.50,0.00,0.13]; 
jade     = [0.00,0.66,0.42]; 
indigo   = [0.29,0.00,0.51];
fig1 = figure; lineWidth = 1.2; %set(fig2,'WindowStyle','docked');
if bitPlotAngle
    subplot(221)
else
    subplot(211)
end
plot(t-t(1), acc, 'LineWidth', lineWidth), hold on, 
plot(t-t(1), g(:,1),'color',jade, 'LineWidth', lineWidth), %izrisemo zasukan g po komponentah na osnovi ziroskopskih meritev
plot(t-t(1), g(:,2),'color',burgundy, 'LineWidth', lineWidth), 
plot(t-t(1), g(:,3),'color',indigo, 'LineWidth', lineWidth)   
xlabel('$t\ [\mathrm{s}]$','interpreter','latex'), ylabel('$a\ [g]$','interpreter','latex')
if bitPlotAngle
    subplot(222)
else
    subplot(212)
end
plot(t-t(1), acc, 'LineWidth', lineWidth), hold on, 
plot(t-t(1), gCal(:,1),'color',jade, 'LineWidth', lineWidth), 
plot(t-t(1), gCal(:,2),'color',burgundy, 'LineWidth', lineWidth), 
plot(t-t(1), gCal(:,3),'color',indigo, 'LineWidth', lineWidth)   
xlabel('$t\ [\mathrm{s}]$','interpreter','latex'), ylabel('$a\ [g]$','interpreter','latex')

if bitPlotAngle
    subplot(223)
    plot(t-t(1), phi, 'LineWidth', lineWidth)
    xlabel('$t\ [\mathrm{s}]$','interpreter','latex'), ylabel('$\varphi\ [^{\circ}]$','interpreter','latex')
    subplot(224)
    plot(t-t(1), phiCal, 'LineWidth', lineWidth)
    xlabel('$t\ [\mathrm{s}]$','interpreter','latex'), ylabel('$\varphi\ [^{\circ}]$','interpreter','latex')
end
