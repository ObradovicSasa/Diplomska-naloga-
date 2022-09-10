function fnAnimirajRotacijo(R, t, N, r)

for i = 1:N:length(R)-1
    deltaT = t(i+1)-t(i);
    plot3([0,0],[0,0],[0,0]); hold on, view(20,30), axis([-2 2 -2 2 -2 2]), daspect([1 1 1]), grid on
    text(1.5,1.5,1.5,num2str(t(i)-t(1)))
    arrow3([0,0,0],R{i}(:,1)','j'), 
    arrow3([0,0,0],R{i}(:,2)','u'), 
    arrow3([0,0,0],R{i}(:,3)','i'), hold off
    pause(deltaT/r)     
end

