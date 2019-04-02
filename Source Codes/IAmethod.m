% Interval Arithmetic Method
% Created By Rivan
% Last Updated 8/8/2016

%% 1. clearing workspace and command window
% -------------------------------------------------------
clc; 
clear all; 
close all;
format LongE
intvalinit('displayInfsup'); % display the result as infimum/supremum

%% 2. Initialize the parameters
%--------------------------------------------------------
m = 8; % mantissa bit
x = infsup(-1,5);
y = infsup(-2,8);
d = ones(4,1) * infsup(1-2^-m,1+2^-m); % error term bounded by 2^-mantissa

%% 3. Equation Polynomial P to be solved
% --------------------------------------------------------
P =(x^2 * y * d(1) * d(2) - x * y^2 * d(1) * d(3)) *d(4) - (x^2 * y - x * y^2)