% Generalized Handelman Method through Monte Carlo
% Model Newton Method
% Created By Rivan
% Last Updated 1/10/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;close all;
set(0,'DefaultFigureWindowStyle','docked');
format LongE
%% 2. Initialize the parameters
%--------------------------------------------------------
nGHR   = 1e7; % number of monte carlo
q = 5; % q parameter
m = 8; % mantissa bit
del = 2^-m;

%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
for i=1:nGHR
    % setting variable with range
    x = powrnd(q,[0.7 1.5]);
    y = powrnd(q,[0.7 1.5]);
    
    % Floating Point Error Polynomial Model (Equation of the bounds)
    z1(i)= -2*x + x^2 + x^3 -2*x*del - 2*x^2*del - 3*x^3*del + x^2*del^2 + x^3*del^2 + x^3*del^3;
    z2(i)= -2 + 2*x + 3*x^2 - 4*x*del - 9*x^2*del + 2*x*del^2 -3*x^2*del^2 + 9*x^2*del^3;
end

boundz1 = [min(z1) max(z1)]
toc
boundz2 = [min(z2) max(z2)]
toc
x = infsup(boundz1(1),boundz1(2));
y = infsup(boundz2(1),boundz2(2));
d = infsup(1-2^-m,1+2^-m); % error term bounded by 2^-mantissa
z3 = x/y*d
toc

for i=1:nGHR
    % setting variable with range
    x = powrnd(q,[0.7 1.5]);
    z3_1 = powrnd(q,[-6.920243363802767e-001 3.048368083805828e+000]);
    % Floating Point Error Polynomial Model (Equation of the bounds)
    z4(i) = x-z3_1 - x*del + z3_1*del;
    z5(i) = z4(i) - (x - (x^3 + x^2 - 2*x)/(3*x^2 + 2*x - 2));
    z6(i) = (x - (x^3 + x^2 - 2*x)/(3*x^2 + 2*x - 2));
end
boundz4 = [min(z4) max(z4)]
toc
boundz5 = [min(z5) max(z5)]
toc
boundz6 = [min(z6) max(z6)]
toc