% Affine Arithmetic Method
% Matrix Multiplication Model Discrete Cosine Transform of a vector v2
% Created By Rivan
% Last Updated 18/1/2017
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
n = 10; % DCT matrix size n x n
% d = infsup(1 - 2^-m,1 + 2^-m); % error term bounded by 2^-mantissa
d1 = affari(ones(n) * infsup(1 - 2^-m,1 + 2^-m)); % error term bounded by 2^-mantissa
d2 = affari(ones(1,n) * infsup(1 - 2^-m,1 + 2^-m)); % error term bounded by 2^-mantissa
d3 = affari(infsup(1 - 2^-m,1 + 2^-m)); % error term bounded by 2^-mantissa
f = 5; % frequency
Ts = 0.1; % sampling time
DCTmat = dctmtx(n);

%% 3. Convert IA to AA
% --------------------------------------------------------
% d = ones(n*3,1) * affari(d);

%% 3. Equation Polynomial P to be solved
% --------------------------------------------------------
% P = zeros(n,1)*affari(infsup(-1,1));
t = linspace(0.5,2.5,n);
FDCT = DCTmat .* d1;
DataIn = (2 * triwavemodel(2*pi*f*Ts*t)) .* d2;
Pfloat = FDCT * DataIn' * d3
% for ind = 1 : n
%    knd = 1;
%    for jnd = 1 : n
%        P(ind) = P(ind) + DCTmat(ind,jnd) * d(knd) * (2 * triwavemodel(2*pi*f*Ts*t(jnd)) - 1)* d(knd+1) * d(knd+2); 
%        knd = knd + 3;
%    end
% end
% P
toc