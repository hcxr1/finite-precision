% Generalized Handelman Method through Monte Carlo
% Created By Rivan
% Last Updated 12/8/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;close all;
set(0,'DefaultFigureWindowStyle','docked');
format LongE
%% 2. Initialize the parameters
%--------------------------------------------------------
nGHR   = 1e7; % number of monte carlo
q = 1e6; % q parameter
m = 8; % mantissa bit

%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
parfor i=1:nGHR
    % setting variable with range
    x = powrnd(q,[-1 5]);
    y = powrnd(q,[-2 8]);
    err = powrnd(q,[-2^-m 2^-m],4,1);
    
    % Floating Point Error Polynomial Model (for lower bound and upper
    % bound)
    GHR(i) = x*y*(1+err(1))*(x-y+x*err(2)-y*err(3))*(1+err(4));
%       GHR(i) = x*y*(-y*err(3) + x*err(4) - y*err(4) - y*err(3)*err(4)+x*err(2)*(1+err(4))+err(1)*(x-y+x*err(2)-y*err(3))*(1+err(4)));
end

bound = [min(GHR) max(GHR)]
toc