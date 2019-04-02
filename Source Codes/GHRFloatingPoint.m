% Generalized Handelman Method through Monte Carlo
% Model f(x,y)=x^2*y-x*y^2
% Created By Rivan
% Last Updated 1/10/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;close all;
set(0,'DefaultFigureWindowStyle','docked');
format LongE
%% 2. Initialize the parameters
%--------------------------------------------------------
nGHR   = 1e7; % number of monte carlo
q = 5; % q parameter
m = 8; % mantissa bit
del = 2^-m;

%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
for i=1:nGHR
    % setting variable with range
    x = powrnd(q,[-1 5]);
    y = powrnd(q,[-2 8]);
    
    % Floating Point Error Polynomial Model (Expression for bounds)
    GHR(i)= x^2*y - x*y^2 - 2*x^2*y*del + 2*x*y^2*del + x^2*y*del^2 - x*y^2*del^2;
end

bound = [min(GHR) max(GHR)]
toc