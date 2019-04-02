% Interval Arithmetic Method 
% - z3 Computation (for Moment Newton's Method)
% Created By Rivan
% Last Updated 13/10/2016

%% 1. clearing workspace and command window
% -------------------------------------------------------
clc; 
clear all; 
close all;
format LongE
intvalinit('displayInfsup'); % display the result as infimum/supremum
load bounds.mat
%% 2. Initialize the parameters
%--------------------------------------------------------
m = 8; % mantissa bit
x = infsup(boundnum(1),boundnum(2));
y = infsup(boundden(1),boundden(2));
d = infsup(1-2^-m,1+2^-m); % error term bounded by 2^-mantissa

%% 3. Equation Polynomial P to be solved
% --------------------------------------------------------
P = x/y*d