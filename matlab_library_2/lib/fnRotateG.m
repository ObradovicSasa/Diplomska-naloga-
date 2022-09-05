function [g,Rot] = fnRotateG(om, t, g0)

if nargin ==3
    g(1,:) = g0;
else
    g(1,:) = [0 0 1];
end
%% rotacija za minus kot v referencnem sistemu
Rot(:,:,1) = [1 0 0; 0 1 0; 0 0 1];
for i = 2:length(om)-1
    v = om(i-1,:);%opredeljevanje osi
    deltaT = t(i)-t(i-1);%cas vzorcenja
    phi = -norm(v)*deltaT;%kot preden smo normirali vektor
    v = v/norm(v);    
    R = rotationmat3D(phi,v);
    g(i,:) = (R*g(i-1,:)')';
    %Rot(:,:,i) = R*Rot(:,:,i-1);
end

%% rotacija za plus kot v sistemu senzorja
for i = 2:length(om)-1
    v = om(i,:);
    deltaT = t(i+1)-t(i);
    phi = norm(v)*deltaT;
    v = v/norm(v);    
    R = rotationmat3D(phi,v);
    Rot(:,:,i) = Rot(:,:,i-1)*R;
end