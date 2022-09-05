function [accV, omV] = fnVskladiSignala(acc, om)

ac = acc;
omm = om;

if (size(acc, 1) > size(om))
    for j = 1:size(om,2)
        for i = 1:(size(acc, 1)-size(om, 1))
            omm(size(om,1)+i,j) = 0.1;
        end
    end
else
    for j = 1:size(acc,2)
        for i = 1:(size(om, 1)-size(acc, 1))
            ac(size(acc,1)+i,j) = 0.1;
        end
    end
end


accV = ac;
omV = omm;