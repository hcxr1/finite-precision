% Floating Point Error Model -> Moment method
% Created by Rivan
% April 2016
% Last Edited 20/9/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clc; clear all; close all;
set(0,'DefaultFigureWindowStyle','docked');

format LongE
%% 2. Initialize symbolic terms
%--------------------------------------------------------
M = [1:6]; % Moment order (up to sixth moment)
x = sym('x',[1,100]); % Parameters in polynomial (x, y, delta[1...4]) is used 
q = 0; % q parameter
mantissa = 8;
prob_lv = 1e-6;

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Param   = {[2, 2^-mantissa]};
DistType{2}.Param   = {[3, 2^-mantissa]};
DistType{3}.Param   = {[4, 2^-mantissa]};
DistType{4}.Param   = {[1, 2^-mantissa]};
DistType{5}.Param   = {[1, 2^-mantissa]};
DistType{6}.Param   = {[1, 2^-mantissa]};
DistType{7}.Param   = {[1, 2^-mantissa]};
DistType{8}.Param   = {[1, 2^-mantissa]};
DistType{9}.Param   = {[1, 2^-mantissa]};
DistType{10}.Param   = {[1, 2^-mantissa]};
DistType{11}.Param   = {[1, 2^-mantissa]};
DistType{12}.Param   = {[1, 2^-mantissa]};
DistType{13}.Param   = {[1, 2^-mantissa]};
DistType{14}.Param   = {[1, 2^-mantissa]};
DistType{15}.Param   = {[1, 2^-mantissa]};
DistType{16}.Param   = {[1, 2^-mantissa]};
DistType{17}.Param   = {[1, 2^-mantissa]};

%% 4. Floating Point Model F to be solved
% --------------------------------------------------------
% Polynomial Model f(x,y) = x^2*y - x*y^2
% P = ((x(1)^2*x(2)-x(1)*x(2)^2)*x(3) + x(1)^2*x(2)*x(4) + x(1)^2*x(2)*x(3)*x(4)-x(1)*x(2)^2*x(5) - x(1)*x(2)^2*x(3)*x(5))*(1+x(6))+(x(1)^2*x(2)-x(1)*x(2)^2)*x(6);

% Toeplitz Matrix Model 3x3
P = 2*x(1)*x(2)^2 + x(1)*x(3)^2 - 2*x(2)^2*x(3) - x(1)^3 + x(1)^3*x(4)*x(6)*x(7)*x(12)*x(17) - x(1)*x(3)^2*x(14)*x(15)*x(16)*x(17) + x(2)^2*x(3)*x(13)*x(15)*x(16)*x(17) - x(1)*x(2)^2*x(5)*x(6)*x(7)*x(12)*x(17) - x(1)*x(2)^2*x(8)*x(10)*x(11)*x(12)*x(17) + x(2)^2*x(3)*x(9)*x(10)*x(11)*x(12)*x(17);

%% 5. Obtain Raw Moment & conversion to central moment
% --------------------------------------------------------
EP = PolyMoment(P,x,DistType,M,q); % PolyMoment is a toolbox used to calculate the moment.

%% 6. Distribution fitting of P
% --------------------------------------------------------
pt = 1e-3;
limit = getbounds([1;EP]',pt);
xi = linspace(limit(1),limit(2),1e6);
%myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfxi,lambda] = myabramem(EP, xi);

pdfxi = pdfxi/trapz(xi,pdfxi); % normalize the pdf plot
cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points

[mini,lbound] = min(abs(cdfxi - prob_lv));
[mini,ubound] = min(abs(cdfxi - (1-prob_lv)));
bound = [xi(lbound) xi(ubound)]

%% 7. Plotting of the Distribution
% --------------------------------------------------------
figure (1)
plot(xi,pdfxi);

figure (2)
plot(xi,cdfxi,xi(lbound),prob_lv,'rx',xi(ubound),1-prob_lv,'rx');
toc