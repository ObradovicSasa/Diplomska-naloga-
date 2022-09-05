function [accRef, tRef, accRef0] = fnRotateAcc(accS, R, g0, t, R0)
%% funkcija izracuna usmerjenost vektroja accS v referncnem sistemu
%% accS - vektor podan v senzorskem sistemu
%% R    - rotacija, ki opisuje vrtenje senzorja
%% g0   - usmerjenost vektorja gravitacije v referencnem sistemu

accRef = zeros(size(accS));
for i=1:length(accS)
    accRef(i,:) = (R{i}*accS(i,:)')' - g0;
end

accRef0 = [];
if nargin ==5
    for i=1:length(accRef)
         temp        = [accRef(i,:); zeros(2,3)]*R0;
         accRef0(i,:) = temp(1,:);
         %accRef0(i,:) = R0*accRef0(i,:)';
    end
end

tRef = t;