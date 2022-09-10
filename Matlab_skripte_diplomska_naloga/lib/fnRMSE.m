function RMSE = fnRMSE(x, y)

if length(x) == length(y)
%     for i=1:length(x)
%         z = z + (x(i)-y(i))^2;
%     end
%     RMSE = sqrt(z/length(x));
RMSE = sqrt(sum((x-y).^2)/length(x));
else
    disp('x in y morata biti enake dolzine')
end

end