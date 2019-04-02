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
M = 6; % Moment order (up to sixth moment)
NV = 17;
x = sym('x',[1,NV],'real'); % Parameters in polynomial (x, y, delta[1...4]) is used 
q = 0; % q parameter
mantissa = 8;
prob_lv = 1e-6;
n = 3; % Matrix size n x n

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[2, 2^-mantissa, q]};

DistType{2}.Sym     = 0;
DistType{2}.Name    = {'pow'};
DistType{2}.Param   = {[3, 2^-mantissa, q]};

DistType{3}.Sym     = 0;
DistType{3}.Name    = {'pow'};
DistType{3}.Param   = {[4, 2^-mantissa, q]};

DistType{4}.Sym     = 0;
DistType{4}.Name    = {'pow'};
DistType{4}.Param   = {[1, 2^-mantissa, q]};

DistType{5}.Sym     = 0;
DistType{5}.Name    = {'pow'};
DistType{5}.Param   = {[1, 2^-mantissa, q]};

DistType{6}.Sym     = 0;
DistType{6}.Name    = {'pow'};
DistType{6}.Param   = {[1, 2^-mantissa, q]};

DistType{7}.Sym     = 0;
DistType{7}.Name    = {'pow'};
DistType{7}.Param   = {[1, 2^-mantissa, q]};

DistType{8}.Sym     = 0;
DistType{8}.Name    = {'pow'};
DistType{8}.Param   = {[1, 2^-mantissa, q]};

DistType{9}.Sym     = 0;
DistType{9}.Name    = {'pow'};
DistType{9}.Param   = {[1, 2^-mantissa, q]};

DistType{10}.Sym     = 0;
DistType{10}.Name    = {'pow'};
DistType{10}.Param   = {[1, 2^-mantissa, q]};

DistType{11}.Sym     = 0;
DistType{11}.Name    = {'pow'};
DistType{11}.Param   = {[1, 2^-mantissa, q]};

DistType{12}.Sym     = 0;
DistType{12}.Name    = {'pow'};
DistType{12}.Param   = {[1, 2^-mantissa, q]};

DistType{13}.Sym     = 0;
DistType{13}.Name    = {'pow'};
DistType{13}.Param   = {[1, 2^-mantissa, q]};

DistType{14}.Sym     = 0;
DistType{14}.Name    = {'pow'};
DistType{14}.Param   = {[1, 2^-mantissa, q]};

DistType{15}.Sym     = 0;
DistType{15}.Name    = {'pow'};
DistType{15}.Param   = {[1, 2^-mantissa, q]};

DistType{16}.Sym     = 0;
DistType{16}.Name    = {'pow'};
DistType{16}.Param   = {[1, 2^-mantissa, q]};

DistType{17}.Sym     = 0;
DistType{17}.Name    = {'pow'};
DistType{17}.Param   = {[1, 2^-mantissa, q]};

%% 4. Floating Point Model P to be solved
% --------------------------------------------------------
m = toeplitz(x(1:n));
Pfloat = Detmodel(m,x,n+1);
Ptrue = det(m);
P = expand(Pfloat-Ptrue);

%% 5. Obtain Raw Moment & conversion to central moment
% --------------------------------------------------------
EP = FastPolyMoment(P,x,DistType,M,NV);

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