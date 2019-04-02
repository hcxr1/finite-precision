% Monte Carlo Simulation
% Model: f(x,y) = x^2*y - x*y^2
% Created By Rivan
% Last Updated 8/8/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;close all;
set(0,'DefaultFigureWindowStyle','docked');

%% 2. Initialize the parameters
%--------------------------------------------------------
nMC   = 1e9; %number of monte carlo
m = 8; % mantissa bit

%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
parfor i=1:nMC
    % Generating Random Number
    x = (5+3).*rand() - 3;
    y = (8+2).*rand() - 2;
    err = (2^-m + 2^-m).*rand(4,1) - 2^-m; 

    % Floating Point Error Polynomial Model (Uniform Distribution)
    Pfloat(i) = ((x^2*y*(1+err(1))*(1+err(2))-x*y^2*(1+err(1))*(1+err(3))))*(1+err(4)) - (x^2*y - x*y^2);
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