% Affine Arithmetic Method
% Floating Point f(x,y) = x^2*y - x*y^2
% Created By Rivan
% Last Updated 8/8/2016

%% 1. clearing workspace and command window
% -------------------------------------------------------
clc; 
clear all; 
close all;
format LongE
affariinit('RoundingErrorsToRnderr');
affariinit('ApproxChebyshev');

%% 2. Initialize the Interval parameters
%--------------------------------------------------------
m = 8; % mantissa bit
x = infsup(-1,5);
y = infsup(-2,8);
d = ones(4,1) * infsup(-2^-m, 2^-m); % error term bounded by 2^-mantissa

%% 3. Convert IA to AA
% --------------------------------------------------------
x = affari(x);
y = affari(y);
d = affari(d);

%% 3. Equation Polynomial P to be solved
% --------------------------------------------------------
P =(x^2 * y * (1+d(1)) * (1+d(1)) - x * y^2 * (1+d(1)) * (1+d(1)))*(1+d(1)) - (x^2*y - x*y^2)
