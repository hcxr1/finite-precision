% Affine Arithmetic Method
% Newton Method, f(x) = x^3 + x^2 - 2x (1 iteration)
% Created By Rivan
% Last Updated 8/8/2016
tic
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
x = infsup(0.7,1.5);
d = ones(12,1) * infsup(1-2^-m, 1+2^-m); % error term bounded by 2^-mantissa

%% 3. Convert IA to AA
% --------------------------------------------------------
x = affari(x);
d = affari(d);

%% 3. Equation Polynomial P to be solved
% --------------------------------------------------------
% z1 = ((x^2*d(1) + x^3*d(1)*d(2))*d(3)-2*x*d(4))*d(5)
% toc
% z2 = (-2 + (3*x^2*d(1)*d(2) + 2*x*d(3))*d(4))*d(5)
% toc
% z3 = z1/z2 * d(1)
% toc
% z4 = (x - z3)*d(1)
% toc
% z5 = z4 - (x- (x^3 + x^2 - 2*x)/(3*x^2+2*x-2)) % Overall Error Bound
% toc
z1 = (x*(-2 + (3*x^2*d(1)*d(6) + 2*x*d(7))*d(8))*d(9)*d(10)-((x^2*d(1) + x^3*d(1)*d(2))*d(3)-2*x*d(4))*d(5))*d(11)*d(12)
toc
z2 = (-2 + (3*x^2*d(1)*d(6) + 2*x*d(7))*d(8))*d(9)
toc
z3 = z1/z2
toc
z4 = z3 - (x- (x^3 + x^2 - 2*x)/(3*x^2+2*x-2)) % Overall Error Bound
toc
