%% Testna skripta za dolocanje zacetne orientacijske ROT matrike

% Obvezno vprasati za sinhronizacijo, saj je nujno da primerjamo ta prave
% rotacijske matrike !!!

% Izracun rotacijske matrike za zacetno orientacijo v vsaki tocki

zacOrientacija1 = zeros(3, 3, length(poravRotZ1));
%zacOrientacija2 = zeros(3, 3, length(poravRotZ));

for i = 1 : length(poravRotZ1)
    zacOrientacija1(:,:,i) = poravRotZ1(:,:,i)/(poravRotS2(:,:,i));
end

% for i = 1 : length(zacRotS2Per)
%     zacOrientacija2(:,:,i) = zacRotCal2Per(:,:,i)\zacRotS2Per(:,:,i);
% end

% Izracun za vsako rot matriko kot rotacije in vektor smeri

theta1           =  zeros(length(poravRotZ1),1);
theta1Prejsnji   =  zeros(length(poravRotZ1),1);
u1               =  zeros(length(poravRotZ1),3);
v1               =  zeros(length(poravRotZ1),3);

% theta2           =  zeros(length(zacRotS2Per),1);
% theta2Prejsnji   =  zeros(length(zacRotS2Per),1);
% u2               =  zeros(length(zacRotS2Per),3);
% v2               =  zeros(length(zacRotS2Per),3);


for i = 1 : length(poravRotZ1)
    u1(i, 3) = -(zacOrientacija1(3, 2, i) - zacOrientacija1(2, 3, i));
    u1(i, 2) = zacOrientacija1(1, 3, i) - zacOrientacija1(3, 1 ,i);
    u1(i, 1) = -(zacOrientacija1(2, 1, i) - zacOrientacija1(1, 2, i));
    theta1Prejsnji(i, 1) = acos(trace((zacOrientacija1(:,:,i)-1)/2)); % zakaj v complex zapisuje? o.0
    theta1(i, 1) = asin(sqrt(u1(i, 1)^2+u1(i, 2)^2+u1(i, 3)^2)/2);
end

% for i = 1 : length(zacRotS2Per)
%     theta2Prejsnji(i, 1) = acos(trace((zacOrientacija2(:,:,i)-1)/2)); % zakaj v complex zapisuje? o.0
%     u2(i, 3) = -(zacOrientacija2(3, 2, i) - zacOrientacija2(2, 3, i));
%     u2(i, 2) = zacOrientacija2(1, 3, i) - zacOrientacija2(3, 1 ,i);
%     u2(i, 1) = -(zacOrientacija2(2, 1, i) - zacOrientacija2(1, 2, i));
%     theta2(i, 1) = asin(sqrt(u2(i, 1)^2+u2(i, 2)^2+u2(i, 3)^2)/2);
% end

% Povprecenje vseh kotov in vektroja orientacije

v1 = u1./(2*sin(theta1));
% v2 = u2./(2*sin(theta2));

povpV1 = zeros(1, 3);
povpTheta1 = mean(theta1);
povpV1(1, 1) = mean(v1(:, 1));
povpV1(1, 2) = mean(v1(:, 2));
povpV1(1, 3) = mean(v1(:, 3));


% povpV2 = zeros(1, 3);
% povpTheta2 = mean(theta2);
% povpV2(1, 1) = mean(v2(:, 1));
% povpV2(1, 2) = mean(v2(:, 2));
% povpV2(1, 3) = mean(v2(:, 3));


% Izracun rotacijske matrike

zacRot1 = rotationmat3D(povpTheta1, povpV1);
% zacRot2 = rotationmat3D(povpTheta2, povpV2);

%%
save('data/rotacijskeMatrikeZaVskladitev/3_5', "zacRot1", "zacRot2")

%% Povpravek vektroja g

for i = 1 : length(g1Rot)
    g1Rot(i, :) = (zacRot1*(g1Rot(i,:))')';
end

for i = 1 : length(g2Rot)
    g2Rot(i, :) = (zacRot2*(g2Rot(i,:))')';
end



