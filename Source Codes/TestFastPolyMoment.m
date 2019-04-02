% This program is to test PolyMomentFFT.m function file

% Clearing workspace and command window
clc; close all;

% Declaration of symbolic terms
% --------------------------------------------------------
NV = 2;               % number of variables
M  = 28;               % number of moments required
x  = sym('x',[1,NV]); % parameters in polynomial
s  = sym('s',[1,NV]); % sigma for corresponding parameter
m  = sym('m',[1,NV]); % miu for corresponding parameter
b  = sym('b',[1,NV]); % beta
% --------------------------------------------------------

% Building the struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'nor'};
DistType{1}.Param   = {[0, 0.01]};

DistType{2}.Sym     = 0;
DistType{2}.Name    = {'nor'};
DistType{2}.Param   = {[0, 0.01]};

% DistType{3}.Sym     = 0;
% DistType{3}.Name    = {'nor'};
% DistType{3}.Param   = {[Mu(3), s(3)]};

% Writing down the equation (make sure only 1 is chosen)
% --------------------------------------------------------
P = 6*(x(1).^2).*4.*(x(2).^2) + (5^6)*x(1).^2 + 12*x(2);

% Process of the results begins
% ________________________________________________________

% obtaining the expected value of the function
EP  = FastPolyMoment(P,x,DistType,M,NV)