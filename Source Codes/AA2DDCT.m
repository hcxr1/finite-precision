% Affine Arithmetic Method
% Floating Point 2 Dimension DCT matrix multiplication
% Created By Rivan
% Last Updated 16/1/2017
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clc; 
clear all; 
close all;
format LongE
intvalinit('displayInfsup'); % display the result as infimum/supremum
affariinit('RoundingErrorsToRnderr');
affariinit('ApproxChebyshev');

%% 2. Initialize the Interval parameters
%--------------------------------------------------------
m = 8; % mantissa bit
n = 5; % DCT matrix size n x n
element_im = infsup(0,1);
d = infsup(1 - 2^-m,1 + 2^-m); % error term bounded by 2^-mantissa
DCTmat = dctmtx(n);
DataIn = affari(element_im * ones(n)); % create input data to be processed

%% 3. Convert IA to AA
% --------------------------------------------------------
d = affari(d);
FDCT = DCTmat * d;
bounds = FDCT * DataIn * FDCT'
toc

%% 4. Equation Polynomial P to be solved
% --------------------------------------------------------
% P = zeros(n,n)*affari(infsup(-1,1));
% DataIn = ones(n,n)*affari(element_im);
% % 1. NewMat = D*A
% for i = 1 : n
%     for j = 1 : n
%         temp = 0;
%         for k = 1 : n
%             temp = temp + DCTmat(i,k) * d * DataIn(k,j);
%         end
%         NewMat(i,j) = temp;
%     end
% end
% % 2. P = D * A * D'
% for i = 1 : n
%     for j = 1 : n
%         temp = 0;
%         for k = 1 : n
%             temp = temp + NewMat(i,k) * d * DCTmatT(k,j) ;
%         end
%         P(i,j) = temp;
%     end
% end
% P
