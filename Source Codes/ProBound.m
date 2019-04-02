% Probabilistic Bounding of Numerical Error
% Created by Rivan
% May 2017
% Last Edited 16/05/2017
clc; clear all; close all;
set(0,'DefaultFigureWindowStyle','docked');
format LongE

M = input('Number of Moment: ');
NV = input('Number of variables: ');
x = sym('x',[1,NV]);
for ind = 1:NV
    DistType{ind}.Sym     = 0;
    DistType{ind}.Name    = {'pow'};
    param = input('Input parameter (format: [mu,sig,q]): ');
    DistType{ind}.Param   = {param};
end
PolyN = input('Polynomial expression (eg. x1^2*x2-x1*x2^2): ','s');
P = sym(PolyN);
prob_lv = input('Probability level (default: 1e-4): ');

tic
if (M < 5)
    EP = FastPolyMoment(P,x,DistType,M,NV);
else
    EP = FastPolyMomentVpa(P,x,DistType,M,NV);
end

pt = 1e-2;
for i = 4:2:M
    pt = pt * 0.1;
end
limit = getbounds([1;EP]',pt);
xi = linspace(limit(1),limit(2),1e6);
%myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfxi,lambda] = myabramem(EP, xi);

pdfxi = pdfxi/trapz(xi,pdfxi); % normalize the pdf plot
cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points

[mini,lbound] = min(abs(cdfxi - prob_lv));
[mini,ubound] = min(abs(cdfxi - (1-prob_lv)));
bound = [xi(lbound) xi(ubound)]

figure (1)
plot(xi,pdfxi);
xlabel('x');
title('Distribution Model');

figure (2)
plot(xi,cdfxi,xi(lbound),prob_lv,'rx',xi(ubound),1-prob_lv,'rx');
xlabel('x');
ylabel('p');
title('CDF model');
toc