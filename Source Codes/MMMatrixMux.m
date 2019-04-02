% Floating Point Error Model -> Moment method
% Matrix Multiplication Discrete Cosine Transfrom
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
M = 2; % Moment order (up to sixth moment)
NV = 3;
x = sym('x',[1,100],'real'); % Parameters in polynomials
q = 2.1; % q parameter
mantissa = 8; % number of mantissa bit
prob_lv = 1e-4; % Probability Level
n = 10; % Matrix model n x n

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[1, 2^-mantissa, q]};

DistType{2}.Sym     = 0;
DistType{2}.Name    = {'pow'};
DistType{2}.Param   = {[1, 2^-mantissa, q]};

DistType{3}.Sym     = 0;
DistType{3}.Name    = {'pow'};
DistType{3}.Param   = {[1, 2^-mantissa, q]};

%% 4. Floating Point Model P to be solved
% --------------------------------------------------------
% Generate nxn DCT matrix
Mfloat = dctmtx(n);

%% 5. Obtain Raw Moment & Central Limit Theorem
% --------------------------------------------------------
Ts = 0.1; f=5;id = 1;
EP = zeros(2,n^2);
t = linspace(0.5,2.5,n);
for i = 1 : n
    for j = 1 : n
        P = Mfloat(i,j) * x(1) * (2 * triwavemodel(2*pi*f*Ts*t(j))) * x(2) * x(3);
        EP(:,id) = FastPolyMoment(P,x,DistType,M,NV);
        id = id + 1;
    end
end
EP = double(EP);

% Convert the moment to Distribution parameter
for i = 1 : n^2
    distP(1,i) = EP(1,i); % extract the mean
    distP(2,i) = EP(2,i)-EP(1,i)^2; % extract the variance
end
% Apply Central Limit Theorem
id = 1;
for i = 1 : n: n^2
    distparam(1,id) = sum(distP(1,i:(i+n-1)));
    distparam(2,id) = sum(distP(2,i:(i+n-1)));
    id = id + 1;
end

%% 6. Distribution fitting of P
% --------------------------------------------------------
bound = zeros(n,2);
for i = 1 : n
    xi = linspace(distparam(1,i) - 10*sqrt(distparam(2,i)), distparam(1,i) + 10*sqrt(distparam(2,i)), 1e6);
    
    pdfxi = normpdf(xi, distparam(1,i), sqrt(distparam(2,i))); % obtain the pdf plot
    cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points
    
    [mini,lbound] = min(abs(cdfxi - prob_lv));
    [mini,ubound] = min(abs(cdfxi - (1-prob_lv)));
    bound(i,:) = [xi(lbound) xi(ubound)];
end
bound
toc