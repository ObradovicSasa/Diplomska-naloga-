%% Poskus dolocanja kota prek qualisys motion tracking sistema

%Pred klicem je treba odpreti .mat datoteko in zamenjati ime da ustreza tej
%datoteki!
q = qtm_21072022_M2;

RPYs2 = (squeeze(q.RigidBodies.RPYs(2,:,:)))'; % RPY spodnjega markerja
RPYz1 = (squeeze(q.RigidBodies.RPYs(1,:,:)))'; % RPY zgornjega markerja

fsQ = q.FrameRate; % frekvenca vzorcenja 
tQ = (1:length(RPYz1))/fsQ; % cas poteka posnetka


POZs2 = (squeeze(q.RigidBodies.Positions(2,:,:)))';
POZz1 = (squeeze(q.RigidBodies.Positions(1,:,:)))';

predRotS2 = squeeze(q.RigidBodies.Rotations(2,:,:)); 
predRotZ1 = squeeze(q.RigidBodies.Rotations(1,:,:)); 

predRotS2virt = squeeze(q.RigidBodies.Rotations(4,:,:)); 
predRotZ1virt = squeeze(q.RigidBodies.Rotations(3,:,:)); 


% Iskanje NaN vrednost v rotacijskih matrikah in potem interpolacija vmes,
% da se lahko izracuna potrebna rotacijska matrika za posamezen senzor,
% kakor bi se vskladila koordinatna sistema senzorja in opticnega sistema

k2 = find(~isnan(predRotS2(1,:)));
k1 = find(~isnan(predRotZ1(1,:)));
k2virt = find(~isnan(predRotS2virt(1,:)));
k1virt = find(~isnan(predRotZ1virt(1,:)));
%tValidRot = zeros(length(tQ),1); tValidRot(k1) = 1; tValidRot = tValidRot(1:end);

for i = 1:9
    predRotZ1(i,:) = (interp1(tQ(k1),predRotZ1(i, k1),tQ(1:end)));
    predRotS2(i,:) = (interp1(tQ(k2),predRotS2(i, k2),tQ(1:end)));
    predRotZ1virt(i,:) = (interp1(tQ(k1virt),predRotZ1virt(i, k1virt),tQ(1:end)));
    predRotS2virt(i,:) = (interp1(tQ(k2virt),predRotS2virt(i, k2virt),tQ(1:end)));
end

clear RotZ1 RotS2 RotZ1virt RotS2virt
for i = 1:length(predRotZ1)
    RotZ1(:,:,i) = [predRotZ1(1:3, i) predRotZ1(4:6, i) predRotZ1(7:9, i)];
    RotS2(:,:,i) = [predRotS2(1:3, i) predRotS2(4:6, i) predRotS2(7:9, i)];
    RotZ1virt(:,:,i) = [predRotZ1virt(1:3, i) predRotZ1virt(4:6, i) predRotZ1virt(7:9, i)];
    RotS2virt(:,:,i) = [predRotS2virt(1:3, i) predRotS2virt(4:6, i) predRotS2virt(7:9, i)];
end


%% Sekanje na uporaben del in kalibracijski

sekanjeFig = figure; hold on;
plot(squeeze(RotZ1virt(:,1,:))')


[xQ, yQ] = ginput(1);
xQ = round(xQ);
close(sekanjeFig)
rotOdsek    = xQ(1);

%% Sekanje rotacijskih matrik na kalibracijski del in del za 

RotZ1kalib = RotZ1(:,:,1:rotOdsek);
RotS2kalib = RotS2(:,:,1:rotOdsek);
RotZ1kalibVirt = RotZ1virt(:,:,1:rotOdsek);
RotS2kalibVirt = RotS2virt(:,:,1:rotOdsek);


RotZ1 = RotZ1(:,:,rotOdsek:end);
RotS2 = RotS2(:,:,rotOdsek:end);
RotZ1virt = RotZ1virt(:,:,rotOdsek:end);
RotS2virt = RotS2virt(:,:,rotOdsek:end);

%% Pozicijske meritve iz qualisys-a

figure;

subplot(211), plot(tQ, POZz1)
xlabel("t(s)")
ylabel("Premiki po oseh")
legend("x","y","z")
grid on

subplot(212), plot(tQ, POZs2)
xlabel("t(s)")
ylabel("Premiki po oseh")
legend("x","y","z")
grid on


