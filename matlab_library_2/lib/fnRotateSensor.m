function [Rkv, Rtr] = fnRotateSensor(om, t, R)
%% funkcija izracuna rotacijo senzorja tj. usmerjenost lastnih osi x, y in z v referencnem sistemu
%% om  - kotna hitrost, merjena v senzorskem sistemu
%% t   - casovni odtisi meritev
%% R   - opcijsko: zacetna usmerjenost senzorskega v referencem sistemu
%% Rkv - rotacija izracunana po kvadratni metodi
%% Rtr - rotacija izracunana po trapezoidni metodi

if nargin  == 2
    Rkv{1} = eye(3);
    Rtr{1} = eye(3);
else
    Rkv{1} = R;
    Rtr{1} = R;
end
for i = 1:length(om)-1
%for i = 1:2
    v        = om(i,:);
    deltaT   = t(i+1) - t(i);
    phi      = norm(v)*deltaT;
    v        = v/norm(v);
    Rkv{i+1} = Rkv{i}*rotationmat3D(phi,v);

    v        = (om(i,:)+om(i+1,:))/2; 
    deltaT   = t(i+1) - t(i);
    phi      = norm(v)*deltaT;
    v        = v/norm(v);
    Rtr{i+1} = Rtr{i}*rotationmat3D(phi,v);  
end