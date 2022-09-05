
figure;
subplot(1,2,1), plot(squeeze(poravRotZ1(:, 1, :))')
grid on 
subplot(1,2,2), plot(squeeze(Rot1Cal(:, 3, :))')
grid on

figure;
plot(squeeze(Rot1Cal(:,1, 1:5000))')
hold on
plot(squeeze(poravRotZ1(:,1,3252:8251))')
grid on
legend("1 Cal", "2 Cal", "3 Cal", "1 Qual", "2 Qual", "3 Qual")


%%
zacRotZ1 = [];
zacRotS2 = [];
zacRotCal1 = [];
zacRotCal2 = [];
zacRotCal1 = Rot1Cal(:,:, 1:5000);
zacRotCal2 = Rot2Cal(:,:, 1:5000);
zacRotZ1 = poravRotZ1(:,:, 3252:8251);
zacRotS2 = poravRotS2(:,:, 3222:8221);

%%


[Z1indx, Z1period] =  findpeaks(squeeze(zacRotZ1(1,1,:))', 'MinPeakProminence', 0.05);
[S2indx, S2period] =  findpeaks(squeeze(zacRotS2(1,1,:))', 'MinPeakProminence', 0.05);

%%

zacRotZ1Per = [];
zacRotS2Per = [];
zacRotCal1Per = [];
zacRotCal2Per = [];
zacRotCal1Per = zacRotCal1(:,:, Z1period(1):Z1period(4));
zacRotCal2Per = zacRotCal2(:,:, S2period(1):S2period(4));
zacRotZ1Per = zacRotZ1(:,:, Z1period(1):Z1period(4));
zacRotS2Per = zacRotS2(:,:, S2period(1):S2period(4));


%%
figure;
subplot(121); hold on;
plot(squeeze(zacRotCal1Per(:,1,:))')
plot(squeeze(zacRotZ1Per(:,1,:))')
grid on
legend("1 Cal", "2 Cal", "3 Cal", "1 Qual", "2 Qual", "3 Qual")

subplot(122); hold on;
plot(squeeze(zacRotCal2Per(:,1,:))')
plot(squeeze(zacRotS2Per(:,1,:))')
grid on
legend("1 Cal", "2 Cal", "3 Cal", "1 Qual", "2 Qual", "3 Qual")





