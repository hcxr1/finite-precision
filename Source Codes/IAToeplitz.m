% Interval Arithmetic Method
% Toeplitz Matrix n x n model
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
x = sym('x',[1,100],'real');
n = 3; % matrix size n x n
ToepM = toeplitz(x(1:n));
Pfloat = Detmodel(ToepM,x,n+1);
Ptrue = det(ToepM);
P = expand(Pfloat-Ptrue);
ErrB = matlabFunction(P);

m = 8; % mantissa bit
xval = midrad(2,2^-m);
yval = midrad(3,2^-m);
zval = midrad(4,2^-m);
dval = ones(14,1) .*  midrad(1,2^-m); % error term bounded by 2^-mantissa

%% 3. Equation Polynomial P to be solved
% --------------------------------------------------------
Bound = ErrB(xval, yval, zval, dval(1), dval(2), dval(3), dval(4), dval(5), dval(6), dval(7), dval(8), dval(9), dval(10), dval(11), dval(12), dval(13), dval(14))