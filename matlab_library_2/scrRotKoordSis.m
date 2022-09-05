% Preprosta rotacija za pi rad koordinatnih sistemov zaradi spremembe
% qualisys modela

RotPi = [-1 0 0; 0 -1 0; 0 0 1];
for i = 1:length(acc1)
    acc1(i,1:3) = (RotPi * acc1(i,1:3)')';
    acc2(i,1:3) = (RotPi * acc2(i,1:3)')';
    om1(i, 1:3) = (RotPi * om1(i, 1:3)')';
    om2(i, 1:3) = (RotPi * om2(i, 1:3)')';
end