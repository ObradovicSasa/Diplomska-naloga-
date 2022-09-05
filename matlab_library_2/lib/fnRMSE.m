function RMSE = fnRMSE(x, y)

z = 0;

if length(x) == length(y)
    for i=1:length(x)
        z = z + (x(i)-y(i))^2;
    end
    RMSE = sqrt(z/length(x));
else
    disp('x in y morata biti enake dolzine')
end

end