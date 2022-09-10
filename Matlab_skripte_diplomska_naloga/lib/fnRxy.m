function R = fnRxy(x, y)
%funkcija za racunanje korelacijske funkcije
%x in y morata biti enake velikosti - dolzine

Nx = length(x);
Ny = length(y);%izracunamo dolzino x in y z vgrajeno funkcijo length
R = [];

x = x(:)'; y = y(:)';

if Nx==Ny
    R = zeros(size(x)); %ce sta x in y enako dolga potem bo tudi enake dolzine korelacijsk funkcija
    for m = 1:Nx %lahko dodamo vmes korak npr 1 za zamik 1 od 1 do dolzine
        %for i = 1:Nx
        %    R(i) = x(i) + y(i+m)
        %end
        R(m) = sum((x./var(x)).*(y./var(y)));
        y = [y(2:end) y(1)];
        %ytemp = circshift(y,m)
    end
    R = R/Nx;

else
    disp('x in y morata biti enake dolzine')
end



end