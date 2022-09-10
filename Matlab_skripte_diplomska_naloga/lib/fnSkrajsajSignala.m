function [accV, omV] = fnSkrajsajSignala(acc,om)

ac = acc;
omm = om;

if (length(ac) > length(om))
    ac = ac(1:length(om), :);
else
    omm = omm(1:length(ac),:);
end


accV = ac;
omV = omm;

