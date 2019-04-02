% Monte Carlo Simulation
% Toeplitz Matrix Model n x n
% Created By Rivan
% Last Updated 8/8/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;close all;
set(0,'DefaultFigureWindowStyle','docked');

%% 2. Initialize the parameters
%--------------------------------------------------------
x = sym('x',[1,100],'real');
nMC   = 1e9; %number of monte carlo
q = 1e6;
m = 8; % mantissa bit
n = 3; % matrix size n x n
ToepM = toeplitz(x(1:n));
Pdet = Detmodel(ToepM,x,n+1);
Ptrue = det(ToepM);
P = matlabFunction(expand(Pdet-Ptrue));

%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
parfor i=1:nMC
    % Generating Random Number
    xv = (2+2^-m - (2-2^-m)).*rand() + 2 - 2^-m;
    yv = (3+2^-m - (3-2^-m)).*rand() + 3 - 2^-m;
    zv = (4+2^-m - (4-2^-m)).*rand() + 4 - 2^-m;
    d = (1+2^-m - (1- 2^-m)).*rand(14,1) + 1 - 2^-m; 

    % Floating Point Error Polynomial Model (Uniform Distribution)
    Pfloat(i) = P(xv,yv,zv,d(1),d(2),d(3),d(4),d(5),d(6),d(7),d(8),d(9),d(10),d(11),d(12),d(13),d(14));
 end

[fx,xi]=hist(Pfloat,100);
lbound = min(Pfloat);
ubound = max(Pfloat);
bound = [lbound ubound]

%% 4. Normalize the pdf
% --------------------------------------------------------
dx = diff(xi(1:2));
pdfmc = fx/sum(fx*dx);

%% 5. Plotting of the Distribution
% --------------------------------------------------------
figure()
bar(xi,pdfmc);
toc