% Interval Arithmetic Method
% Created By Rivan
% Last Updated 8/8/2016
tic
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
n = 3; % DCT matrix size n x n
d = infsup(1 - 2^-m,1 + 2^-m); % error term bounded by 2^-mantissa
a = infsup(-1, 2);
b = infsup(-2, 3);
e = infsup(- 2^-m, 2^-m);
A = [a b -a;e e e;a b -a];
AT =A';
err = ones(n^3,1) * d;

%% 3. Equation Polynomial P to be solved
% --------------------------------------------------------
P = zeros(n,1)*infsup(-1,1);
count = 1;
% P = A*A'
for i = 1 : n
    for j = 1 : n
        temp = 0;
        for k = 1 : n
                temp = temp + A(i,k) * AT(k,j) * err(count);
                count = count + 1;
        end
        P(i,j) = temp;
    end
end
P
toc