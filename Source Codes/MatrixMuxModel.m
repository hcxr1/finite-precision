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
M = [1:2]; % Moment order (up to sixth moment)
x = sym('x',[1,100]); % Parameters in polynomials
q = 0; % q parameter
mantissa = 8; % number of mantissa bit
prob_lv = 1e-4; % Probability Level
n = 4; % Matrix model n x n

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Param   = {[1, 2^-mantissa]};
DistType{2}.Param   = {[1, 2^-mantissa]};
DistType{3}.Param   = {[1, 2^-mantissa]};
% DistType{4}.Param   = {[1, 2^-mantissa]};
% DistType{5}.Param   = {[1, 2^-mantissa]};
% DistType{6}.Param   = {[1, 2^-mantissa]};
% DistType{7}.Param   = {[1, 2^-mantissa]};
% DistType{8}.Param   = {[1, 2^-mantissa]};
% DistType{9}.Param   = {[1, 2^-mantissa]};
% DistType{10}.Param   = {[1, 2^-mantissa]};
% DistType{11}.Param   = {[1, 2^-mantissa]};
% DistType{12}.Param   = {[1, 2^-mantissa]};
% DistType{13}.Param   = {[1, 2^-mantissa]};
% DistType{14}.Param   = {[1, 2^-mantissa]};
% DistType{15}.Param   = {[1, 2^-mantissa]};
% DistType{16}.Param   = {[1, 2^-mantissa]};
% DistType{17}.Param   = {[1, 2^-mantissa]};

%% 4. Floating Point Model P to be solved
% --------------------------------------------------------
% Generate nxn DCT matrix
Mfloat = dctmodel(n,x,1);

%% 5. Obtain Raw Moment & conversion to central moment
% --------------------------------------------------------
id = 1; Ts = 0.1; f=5;
EP = zeros(2,n^2);
for i = 1 : n
    for j = 1 : n
        P = Mfloat(i,j) * 2 * triwavemodel(2*pi*f*Ts*(j-1)) * x(2) * x(3);
        EP(:,id) = PolyMoment(P,x,DistType,M,q); % PolyMoment is a toolbox used to calculate the moment.
        id = id + 1;
    end
end
EP = double(EP);

% Convert the moment to Distribution parameter
for i = 1 : n^2
    distP(1,i) = EP(1,i); % extract the mean
    distP(2,i) = sqrt(EP(2,i)-EP(1,i)^2); % extract the variance
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
    xi = linspace(distparam(1,i) - 10*distparam(2,i), distparam(1,i) + 10*distparam(2,i), 1e6);
    
    pdfxi = normpdf(xi, distparam(1,i), distparam(2,i)); % obtain the pdf plot
    cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points
    
    [mini,lbound] = min(abs(cdfxi - prob_lv));
    [mini,ubound] = min(abs(cdfxi - (1-prob_lv)));
    bound(i,:) = [xi(lbound) xi(ubound)];
end
bound

%% 7. Plotting of the Distribution
% --------------------------------------------------------
% figure (1)
% plot(xi,pdfxi);
% 
% figure (2)
% plot(xi,cdfxi,xi(lbound),prob_lv,'rx',xi(ubound),1-prob_lv,'rx');
toc