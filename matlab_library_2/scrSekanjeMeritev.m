%% Markerji za zacetek signalov + odstevanje offseta :D


%prvi dve tocki sta za kalibracijo, drugi dve pa za zajem signala
fig1 = figure;
subplot(211),plot(acc1)
subplot(212),plot(om1)
[x1, y1] = ginput(4);
x1 = round(x1);
close(fig1)
nCalStart1    = x1(1); nCalEnd1    = x1(2);%odrezi majhno variacijo signala aka gravitacijska komponenta
nStart        = x1(3); nEnd        = x1(4); %zacetek in konec signala

fig2 = figure;
subplot(211),plot(acc2)
subplot(212),plot(om2)
[x2, y2] = ginput(2);
x2 = round(x2);
close(fig2)
nCalStart2    = x2(1); nCalEnd2    = x2(2);

fig3 = figure;
plot(om1(nCalStart1:nCalEnd1,:))
[x3, y3] = ginput(2);
x3 = round(x3);
close(fig3)
nCalStart1    = nCalStart1 + x3(1); nCalEnd1   = nCalStart1 + x3(2);

fig4 = figure;
plot(om2(nCalStart2:nCalEnd2,:))
[x4, y4] = ginput(2);
x4 = round(x4);
close(fig4)
nCalStart2    = nCalStart2 + x4(1); nCalEnd2   = nCalStart2 + x4(2);



acc1s = acc1(nStart:nEnd, :);
acc2s = acc2(nStart:nEnd, :);
om1s = om1(nStart:nEnd, :);
om2s = om2(nStart:nEnd, :);
ts = t(nStart:nEnd);


% Nujno poimenovati datoteke za meritve!
%save("data/meritve_trenazer/25042022Trenazer02/25042022Trenazer02_IMU.mat",'acc1s', 'acc2s', 'om1s', 'om2s','ts')
