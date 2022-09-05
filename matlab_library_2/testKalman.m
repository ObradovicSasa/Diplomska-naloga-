addpath("lib/");
T = 100;
t = 0:200;
x = sin(2*pi/T*t);
% xn=0.5*sin(10*pi/T*t);z=x+xn;
% xn=0.5*sin(10*pi/T*t);z=x+xn;
xn = 0.5*sin(0.9*pi*t); z=x+xn;

deltaT = 1;
F = 1;
Q = 0.0002; %% kovariancna matrika suma procesa
H = 1; R = 0.1;%R=0.0497; %% kovariancna matrika suma meritve
%Q = -1.5; R = 0.002;
G = 0; u = 0;

x0 = 0;
P0 = 1;

[xOut,K] = fnKalman(z,F,G,H,Q,R,u,x0,P0);

F*(1-K*H)
K
zLI=fnLeakyIntegrator(z,1-K*H);

figure;
plot(z,'r')
hold on
plot(zLI,'b')
plot(xOut,'g')
legend('sumni signal', 'Leaky Integrator', 'Kalman')