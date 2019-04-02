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
M = 2; % Moment order (up to sixth moment)
n = 5; % Matrix model n x n
NV = 2*(n^2);
x = sym('x',[1,NV],'real'); % Parameters in polynomials
q = [6.8;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79;0.79]; % q parameter
mantissa = 8; % number of mantissa bit
prob_lv = [1e-8;1e-10;1e-11;1e-10;1e-10;1e-10;1e-8;1e-9;1e-8;1e-9;1e-11;1e-9;1e-9;1e-9;1e-9;1e-10;1e-8;1e-9;1e-8;1e-9;1e-10;1e-9;1e-9;1e-9;1e-9]; % Probability Level

%% 3. Constructing the distribution struct
% --------------------------------------------------------
for i = 1 : n^2
    DistType{i}.Sym     = 0;
    DistType{i}.Name    = {'pow'};
%     DistType{i}.Param   = {[1, 2^-mantissa, q]};
    
    DistType{n^2+i}.Sym     = 0;
    DistType{n^2+i}.Name    = {'pow'};
%     DistType{n^2+i}.Param   = {[0.5, 0.5, q]};
end

%% 4. Floating Point Model P to be solved
% --------------------------------------------------------
% Generate nxn DCT matrix and input matrix
id = 1;
Mfloat = dctmtx(n);
for i = 1 : n
    for j = 1 : n
        DCTmat(i,j) = Mfloat(i,j) * x(id);
        DataIn(i,j) = x(n^2+id);
        id = id + 1;
    end
end
DCTmatT = DCTmat'; % Transpose of DCT Matrix

% 2-D DCT model: D*A*D'
% B=D*A
for i = 1 : n
    for j = 1 : n
        temp = 0;
        for k = 1 : n
            temp = temp + DCTmat(i,k) * DataIn(k,j);
        end
        NewMat(i,j) = temp;
    end
end

%% 5. Obtain Raw Moment & Central Limit Theorem
% --------------------------------------------------------
id = 1;
idx = 1;
EP = zeros(2,n^3);
% out = B*D'
for i = 1 : n
    for j = 1 : n
        qparam = q(idx);
        for k = 1 : n
            P = NewMat(i,k) * DCTmatT(k,j);
            
            for l = 1 : n^2
                DistType{l}.Param   = {[1, 2^-mantissa, qparam]};
                DistType{n^2+l}.Param   = {[0.5, 0.5, qparam]};
            end
            
            EP(:,id) = FastPolyMoment(P,x,DistType,M,NV);
            id = id + 1;            
        end
        idx = idx + 1;
    end
end
EP = double(EP);

% Convert the moment to Distribution parameter
for i = 1 : size(EP,2)
    distP(1,i) = EP(1,i); % extract the mean
    distP(2,i) = EP(2,i)-EP(1,i)^2; % extract the variance
end
% Apply Central Limit Theorem
id = 1;
for i = 1 : n: size(EP,2)
    distparam(1,id) = sum(distP(1,i:(i+n-1)));
    distparam(2,id) = sum(distP(2,i:(i+n-1)));
    id = id + 1;
end

%% 6. Distribution fitting of P
% --------------------------------------------------------
bound = zeros(n,2);
for i = 1 : n^2
    xi = linspace(distparam(1,i) - 10*sqrt(distparam(2,i)), distparam(1,i) + 10*sqrt(distparam(2,i)), 1e6);
    
    pdfxi = normpdf(xi, distparam(1,i), sqrt(distparam(2,i))); % obtain the pdf plot
    cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points
    
    [mini,lbound] = min(abs(cdfxi - prob_lv(i)));
    [mini,ubound] = min(abs(cdfxi - (1-prob_lv(i))));
    bound(i,:) = [xi(lbound) xi(ubound)];
end
bound
toc