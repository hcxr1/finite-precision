% Floating Point Error Model -> Moment method
% Matrix Multiplication 2-Dimension Discrete Cosine Transfrom
% Created by Rivan
% April 2016
% Last Edited 4/10/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clc; clear all; close all;
set(0,'DefaultFigureWindowStyle','docked');

format LongE
%% 2. Initialize symbolic terms
%--------------------------------------------------------
M = 10; % Moment order (up to sixth moment)
NV = 4;
x = sym('x',[1,NV],'real'); % Parameters in polynomials
q = 2.1; % q parameter
mantissa = 8; % number of mantissa bit
prob_lv = 1e-4; % Probability Level
n = 3;

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[0.5, 1.5, q]};

DistType{2}.Sym     = 0;
DistType{2}.Name    = {'pow'};
DistType{2}.Param   = {[0.5, 2.5, q]};

DistType{3}.Sym     = 0;
DistType{3}.Name    = {'pow'};
DistType{3}.Param   = {[0, 2^-mantissa, q]};

DistType{4}.Sym     = 0;
DistType{4}.Name    = {'pow'};
DistType{4}.Param   = {[1, 2^-mantissa, q]};
% DistType{3}.Param   = {[1, 4]};
% DistType{5}.Param   = {[2, 3]};
% DistType{6}.Param   = {[1, 2]};

%% 4. Floating Point Model P to be solved
% --------------------------------------------------------
A = [x(1) x(2) -x(1);x(3) x(3) x(3);x(1) x(2) -x(1)];
% A = [x(1) x(2) x(3) -x(2) -x(1); x(2) x(5) x(6) -x(5) -x(2); x(4) x(4) x(4) x(4) x(4);x(2) x(5) x(6) -x(5) -x(2); x(1) x(2) x(3) -x(2) -x(1)];
AT = A';

%% 5. Obtain Raw Moment & Central Limit Theorem
% --------------------------------------------------------
id = 1;
EP = zeros(M,n^3);
% B = A*A'
for i = 1 : n
    for j = 1 : n
        temp = 0;
        for k = 1 : n
            temp = temp + A(i,k) * AT(k,j) *x(4);          
        end
        P(i,j) = temp;
    end
end

for i = 1 : n^2
    EP(:,i) = FastPolyMoment(P(i),x,DistType,M,NV);
end      
EP = double(EP);

%% 6. Distribution fitting of P
% --------------------------------------------------------
for i = 1 : n^2
    pt = 1e-3;
    limit = getbounds([1;EP(:,i)]',pt);
    xi = linspace(limit(1),limit(2),1e6);
    %myabramem obtains distribution of the moment by using Maximum Entropy approach
    [pdfxi,lambda] = myabramem(EP(:,i), xi);
    
    pdfxi = pdfxi/trapz(xi,pdfxi); % normalize the pdf plot
    cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points
    figure(), plot(xi,pdfxi);
    [mini,lbound] = min(abs(cdfxi - prob_lv));
    [mini,ubound] = min(abs(cdfxi - (1-prob_lv)));
    bound(i,:) = [xi(lbound) xi(ubound)];
end
clc;
bound
toc