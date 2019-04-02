% Created by Rivan
% Last Edited 24/8/2016
% Generate Polynomial model
clc;
clear all;
close all;

% Generate Poly Matrix Determinant
x = sym('x',[1,100],'real');
n = 3;
m = toeplitz(x(1:n));%sym(ones(n));
Pfloat = Detmodel(m,x,n+1);
Ptrue = det(m);
P = expand(Pfloat-Ptrue)
