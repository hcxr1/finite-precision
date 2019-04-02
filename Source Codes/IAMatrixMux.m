% Interval Arithmetic Method
% Matrix Multiplication of a vector v2
% Created By Rivan
% Last Updated 18/1/2017
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
n = 10; % DCT matrix size n x n
% d = ones(3,1) * infsup(1 - 2^-m,1 + 2^-m); % error term bounded by 2^-mantissa
d1 = ones(n) * infsup(1 - 2^-m,1 + 2^-m); % error term bounded by 2^-mantissa
d2 = ones(1,n) * infsup(1 - 2^-m,1 + 2^-m); % error term bounded by 2^-mantissa
d3 = infsup(1 - 2^-m,1 + 2^-m); % error term bounded by 2^-mantissa

f = 5; % frequency
Ts = 0.1; % sampling time
DCTmat = dctmtx(n);

%% 3. Equation Polynomial P to be solved
% --------------------------------------------------------
% P = zeros(n,1)*infsup(-1,1);
t = linspace(0.5,2.5,n);
FDCT = DCTmat .* d1;
DataIn = (2 * triwavemodel(2*pi*f*Ts*t)) .* d2;
Pfloat = FDCT * DataIn' * d3
% for ind = 1 : n
%    for jnd = 1 : n
%        P(ind) = P(ind) + DCTmat(ind,jnd) * d(1) * (2 * triwavemodel(2*pi*f*Ts*t(jnd)) - 1) * d(2) * d(3); 
%    end
% end
% P
toc