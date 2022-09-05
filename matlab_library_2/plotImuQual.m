
s2Z = POZs2(:, 3)/max(POZs2(:,3));

[b,a] = butter(10, [30]/100);
%%RQdown = fnFilterAndDownsample(RQ', Q.FrameRate, 200, 20, (0:length(sQ)-1)/Q.FrameRate);
%%[sQdown, tDown] = fnFilterAndDownsample(sQ, Q.FrameRate, 200, 20, (0:length(sQ)-1)/Q.FrameRate);
k = find(~isnan(s2Z(:,1)));
tValid = zeros(length(tQ),1); tValid(k) = 1; tValid = tValid(1:end-1);
disp(['Qualisys loss: ', num2str(1-length(k)/length(s2Z))]);
s2Zcorr = interp1(tQ(k),s2Z(k,:),tQ(1:end-1));
%tDown = tDown(1:end-1);
% sQdown = filtfilt(b, a, sQdown);
% RQdown = interp1(tDown(k),RQdown(k,:),tDown(1:end-1)); tDown = tDown(1:end-1);
% RQdown = filtfilt(b, a, RQdown);

%%

plot(tQ(1:end-1), s2Zcorr-mean(s2Zcorr))
hold on
plot(tQ, acc1(nStart:nStart+length(tQ)-1, 1) - mean(acc1(nStart:nStart+length(tQ)-1, 1)))
