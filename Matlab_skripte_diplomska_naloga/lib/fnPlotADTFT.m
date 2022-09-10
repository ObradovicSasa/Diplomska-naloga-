function fnPlotADTFT(omega,AX, color)

if nargin ==2
    color = 'k';
end
plot(omega,AX,color,'LineWidth', 0.6)
xlabel('$\Omega$','Interpreter','Latex')
ylabel('$A_x(\Omega)$','Interpreter','Latex')
axis([omega(1) omega(end) 0 max(AX)])
%axis([omega(1) omega(end) min(AX) 0])