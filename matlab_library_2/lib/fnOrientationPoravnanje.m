function [orientPoravnana, gRot]= fnOrientationPoravnanje(orientation, g0)

ori = zeros(3, 3, length(orientation));
g = zeros(length(orientation), 3);
g(1,:) = g0;

for i = 1:length(orientation)
    ori(:,:,i) = orientation(:,:,i)*inv(orientation(:,:,1));
    g(i+1,:) = (ori(:,:,i)*g0')';
end

orientPoravnana = ori;
gRot = g(2:length(g),:);