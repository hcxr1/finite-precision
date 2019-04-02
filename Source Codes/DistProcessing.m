function [pdfxi, cdfxi, lbound, ubound] = DistProcessing(moment,xi)
% this function will take in the raw moment as the input, perform
% distribution fitting by using maximum entropy approach to obtain pdf(x)
% and then use it to obtain the cdf(x) plot

% this function will return 4 output
% pdfxi := return the pdf(xi) values after edge refinement
% ycdf := cdf(xcdf) values
% lbound := lowbound position at precision defined by user at cdf plot
% ubound := upperbound position at precision defined by user at cdf plot

% Created by 
% Rivan 21/7/2016
% Last Update 4/8/2016

%% 1. Generating test values used to fit the distribution
% --------------------------------------------------------
%myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfxi,lambda] = myabramem(moment, xi);

%% 2. Estimating the bound
% --------------------------------------------------------
pdfxi = pdfxi/trapz(xi,pdfxi); % normalize the pdf plot
cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points

[min1,ubound] = min(abs(cdfxi - 0.9999));
[min2,lbound] = min(abs(cdfxi - 0.0001));