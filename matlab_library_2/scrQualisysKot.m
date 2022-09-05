%% Izracun kota iz qualisys meritev RPY + korekcija za NaN  vrednosti


poravRotZ1 = [];
poravRotS2 = [];
poravRotZ1virt = [];
poravRotS2virt = [];


for i = 1:length(RotZ1)
    poravRotZ1(:,:,i) = (RotZ1(:,:,200))\RotZ1(:,:,i);
    poravRotS2(:,:,i) = (RotS2(:,:,200))\RotS2(:,:,i);
    poravRotZ1virt(:,:,i) = (RotZ1virt(:,:,200))\RotZ1virt(:,:,i);
    poravRotS2virt(:,:,i) = (RotS2virt(:,:,200))\RotS2virt(:,:,i);
end



%%

% figure; 
% subplot(211), plot(squeeze(Rot1Cal(:,1,:))')
% subplot(212), plot(squeeze(poravRotZ1(:,1,:))')
% 
% figure; 
% subplot(211)
% plot(squeeze(RotZ1(:,1,:))')
% subplot(212)
% plot(squeeze(Rot1Cal(:,1,:))')
% 
% Rot1CalGlobal = []; Rot2CalGlobal = [];
% for i = 1:length(Rot1Cal)
%     Rot1CalGlobal(:,:,i) = RotZ1(:,:,200)*Rot1Cal(:,:,i);
%     Rot2CalGlobal(:,:,i) = RotS2(:,:,200)*Rot2Cal(:,:,i);
% end
% figure; 
% subplot(211)
% plot(squeeze(RotZ1(:,1,:))')
% subplot(212)
% plot(squeeze(Rot1CalGlobal(:,1,:))')

