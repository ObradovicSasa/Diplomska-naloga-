function fnPlotX(n,x)

stem(n,x,'.k', 'MarkerSize', 8, 'LineWidth', 0.6)
xlabel('$n$','Interpreter','Latex')
ylabel('$x[n]$','Interpreter','Latex')