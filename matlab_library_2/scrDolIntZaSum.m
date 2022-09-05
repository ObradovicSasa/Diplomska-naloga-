%% Skripta za dolocitev suma in semi-nakljucno korekcijo, ce je bilo kakrsnihkoli rahlih gibov v mirovanju

offsetEnd = fnVelikostIntZaOffset(om1, 250);

sumEnd = fnVelikostIntZaSum(om1,25);

om1c = om1(1:offsetEnd, :);
om1s = om1(1:sumEnd, :);
for i = 1: length(om1c)-3
    if abs(om1c(i+3,1)-om1c(i,1)) >= 0.5
        rand = randperm(length(om1s), 1);
        om1c(i+1,1) = om1s(rand,1);
    end
end
for i = 1: length(om1c)-3
    if abs(om1c(i+3,2)-om1c(i,2)) >= 0.5
        rand = randperm(length(om1s), 1);
        om1c(i+1,2) = om1s(rand,2);
    end
end
for i = 1: length(om1c)-3
    if abs(om1c(i+3,3)-om1c(i,3)) >= 0.5
        rand = randperm(length(om1s), 1);
        om1c(i+1,3) = om1s(rand,3);
    end
end

plot(om1c)