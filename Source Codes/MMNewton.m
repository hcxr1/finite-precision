% Floating Point Error Model -> Moment method
% Created by Rivan
% April 2016
% Last Edited 20/1/2017
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clc; clear all; close all;
set(0,'DefaultFigureWindowStyle','docked');

format LongE
%% 2. Initialize symbolic terms (numerator)
%--------------------------------------------------------
M = 10; % Moment order (up to sixth moment)
NV = 13;
x = sym('x',[1,NV]); % Parameters in polynomial (x, y, delta[1...4]) is used 
q = 38; % q numerator
mantissa = 8;
prob_lv = 1e-5;

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[1.1, 0.4, q]};

DistType{2}.Sym     = 0;
DistType{2}.Name    = {'pow'};
DistType{2}.Param   = {[1, 2^-mantissa, q]};

DistType{3}.Sym     = 0;
DistType{3}.Name    = {'pow'};
DistType{3}.Param   = {[1, 2^-mantissa, q]};

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

%% 4. Floating Point Model F to be solved
% --------------------------------------------------------
Pnum = (x(1)*(-2 + (3*x(1)^2*x(2)*x(7) + 2*x(1)*x(8))*x(9))*x(10)*x(11)-((x(1)^2*x(2) + x(1)^3*x(2)*x(3))*x(4)-2*x(1)*x(5))*x(6))*x(12)*x(13);

% Polynomial without error terms
% Pnum = x(1)^3 + x(1)^2 - 2*x(1);
% Pden = 3*x(1)^2 + 2*x(1) - 2;

%% 5. Obtain Raw Moment & conversion to central moment
% --------------------------------------------------------
% PolyMoment is a toolbox used to calculate the moment.
EPnum = FastPolyMoment(Pnum,x,DistType,M,NV);

%% 6. Distribution fitting of P
% --------------------------------------------------------
pt = 1e-3;
% a. numerator
limit = getbounds([1;EPnum]',pt);
xinum = linspace(limit(1),limit(2),1e6);
% myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfnum,lambda] = myabramem(EPnum, xinum);

pdfnum = pdfnum/trapz(xinum,pdfnum); % normalize the pdf plot
cdfnum = cumtrapz(xinum,pdfnum);  % find the cdf plot based on the pdf points

[mini,lbound] = min(abs(cdfnum - prob_lv));
[mini,ubound] = min(abs(cdfnum - (1-prob_lv)));
boundnum = [xinum(lbound) xinum(ubound)]
toc

%% 2. Initialize symbolic terms (denominator)
%--------------------------------------------------------
M = 10; % Moment order (up to sixth moment)
NV = 6;
x = sym('x',[1,NV]); % Parameters in polynomial (x, y, delta[1...4]) is used 
q = 25; % q numerator
mantissa = 8;
prob_lv = 1e-4;

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[1.1, 0.4, q]};

DistType{2}.Sym     = 0;
DistType{2}.Name    = {'pow'};
DistType{2}.Param   = {[1, 2^-mantissa, q]};

DistType{3}.Sym     = 0;
DistType{3}.Name    = {'pow'};
DistType{3}.Param   = {[1, 2^-mantissa, q]};

DistType{4}.Sym     = 0;
DistType{4}.Name    = {'pow'};
DistType{4}.Param   = {[1, 2^-mantissa, q]};

DistType{5}.Sym     = 0;
DistType{5}.Name    = {'pow'};
DistType{5}.Param   = {[1, 2^-mantissa, q]};

DistType{6}.Sym     = 0;
DistType{6}.Name    = {'pow'};
DistType{6}.Param   = {[1, 2^-mantissa, q]};

%% 4. Floating Point Model F to be solved
% --------------------------------------------------------
Pden =(-2 + (3*x(1)^2*x(2)*x(3) + 2*x(1)*x(4))*x(5))*x(6);

%% 5. Obtain Raw Moment & conversion to central moment
% --------------------------------------------------------
% PolyMoment is a toolbox used to calculate the moment.
EPden = FastPolyMoment(Pden,x,DistType,M,NV);

%% 6. Distribution fitting of P
% --------------------------------------------------------
% b. denominator
limit = getbounds([1;EPden]',pt);
xiden = linspace(limit(1),limit(2),1e6);
% myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfden,lambda] = myabramem(EPden, xiden);

pdfden = pdfden/trapz(xiden,pdfden); % normalize the pdf plot
cdfden = cumtrapz(xiden,pdfden);  % find the cdf plot based on the pdf points

[mini,lbound] = min(abs(cdfden - prob_lv));
[mini,ubound] = min(abs(cdfden - (1-prob_lv)));
boundden = [xiden(lbound) xiden(ubound)]
toc
% save bounds.mat boundnum boundden
% 
op = [boundnum(1)/boundden(1),boundnum(2)/boundden(1),boundnum(1)/boundden(2),boundnum(2)/boundden(2)];
z3 = [min(op) max(op)]
z3_refined = binsearch(z3,boundnum,boundden,[0.25,1.75])
toc


%% 2. Initialize symbolic terms (numerator without error term)
%--------------------------------------------------------
M = 10; % Moment order (up to sixth moment)
NV = 1;
x = sym('x',[1,NV]); % Parameters in polynomial (x, y, delta[1...4]) is used 
q = 0; % q numerator
mantissa = 8;
prob_lv = 1e-5;

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[1.1, 0.4, q]};

%% 4. Floating Point Model F to be solved
% --------------------------------------------------------
PnumT = x(1)*(3*x(1)^2 + 2*x(1) - 2)-(x(1)^3 + x(1)^2 - 2*x(1));
%% 5. Obtain Raw Moment & conversion to central moment
% --------------------------------------------------------
% PolyMoment is a toolbox used to calculate the moment.
EPnumT = FastPolyMoment(PnumT,x,DistType,M,NV);

%% 6. Distribution fitting of P
% --------------------------------------------------------
pt = 1e-3;
% a. numerator
limit = getbounds([1;EPnumT]',pt);
xinum = linspace(limit(1),limit(2),1e6);
% myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfnum,lambda] = myabramem(EPnumT, xinum);

pdfnum = pdfnum/trapz(xinum,pdfnum); % normalize the pdf plot
cdfnum = cumtrapz(xinum,pdfnum);  % find the cdf plot based on the pdf points

[mini,lbound] = min(abs(cdfnum - prob_lv));
[mini,ubound] = min(abs(cdfnum - (1-prob_lv)));
boundnumT = [xinum(lbound) xinum(ubound)]
toc

%% 2. Initialize symbolic terms (denominator without error term)
%--------------------------------------------------------
M = 10; % Moment order (up to sixth moment)
NV = 1;
x = sym('x',[1,NV]); % Parameters in polynomial (x, y, delta[1...4]) is used 
q = 0; % q numerator
mantissa = 8;
prob_lv = 1e-4;

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[1.1, 0.4, q]};

%% 4. Floating Point Model F to be solved
% --------------------------------------------------------
PdenT = 3*x(1)^2 + 2*x(1) - 2;
%% 5. Obtain Raw Moment & conversion to central moment
% --------------------------------------------------------
% PolyMoment is a toolbox used to calculate the moment.
EPdenT = FastPolyMoment(PdenT,x,DistType,M,NV);

%% 6. Distribution fitting of P
% --------------------------------------------------------
% b. denominator
limit = getbounds([1;EPdenT]',pt);
xiden = linspace(limit(1),limit(2),1e6);
% myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfden,lambda] = myabramem(EPdenT, xiden);

pdfden = pdfden/trapz(xiden,pdfden); % normalize the pdf plot
cdfden = cumtrapz(xiden,pdfden);  % find the cdf plot based on the pdf points

[mini,lbound] = min(abs(cdfden - prob_lv));
[mini,ubound] = min(abs(cdfden - (1-prob_lv)));
bounddenT = [xiden(lbound) xiden(ubound)]
toc
% save bounds.mat boundnum boundden
% 
op = [boundnumT(1)/bounddenT(1),boundnumT(2)/bounddenT(1),boundnumT(1)/bounddenT(2),boundnumT(2)/bounddenT(2)];
z3T = [min(op) max(op)]
z3_refinedT = binsearch(z3T,boundnumT,bounddenT,[0.2,1.5])
toc

%% 2. Initialize symbolic terms (error model)
%--------------------------------------------------------
M = 12; % Moment order (up to sixth moment)
NV = 2;
x = sym('x',[1,NV]); % Parameters in polynomial (x, y, delta[1...4]) is used 
q = 0; % q numerator
prob_lv = 1e-4;

%% 3. Constructing the distribution struct
% --------------------------------------------------------
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[(z3_refined(1)+z3_refined(2))/2, (z3_refined(2)-z3_refined(1))/2, q]};

DistType{2}.Sym     = 0;
DistType{2}.Name    = {'pow'};
DistType{2}.Param   = {[(z3_refinedT(1)+z3_refinedT(2))/2, (z3_refinedT(2)-z3_refinedT(1))/2, q]};

%% 4. Floating Point Model F to be solved
% --------------------------------------------------------
P = x(1)-x(2);
%% 5. Obtain Raw Moment & conversion to central moment
% --------------------------------------------------------
% PolyMoment is a toolbox used to calculate the moment.
EP = FastPolyMoment(P,x,DistType,M,NV);
%% 6. Distribution fitting of P
% --------------------------------------------------------
limit = getbounds([1;EP]',pt);
xi = linspace(limit(1),limit(2),1e6);
% myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfxi,lambda] = myabramem(EP, xi);

pdfxi = pdfxi/trapz(xi,pdfxi); % normalize the pdf plot
cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points

[mini,lbound] = min(abs(cdfxi - prob_lv));
[mini,ubound] = min(abs(cdfxi - (1-prob_lv)));
bound = [xi(lbound) xi(ubound)]
toc