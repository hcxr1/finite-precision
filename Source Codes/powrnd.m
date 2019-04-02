function R = powrnd(q,itvl,varargin)
%POWRND Random arrays from the test distribution.
%   R = POWRND(q,[a b]) returns an array of random numbers chosen from the
%   test distribution with q parameter and interval parameter. The interval
%   parameter is used in order to obtain the midvalue of the distribution
%   (mean) and the Standard deviation L. The distribution is symmetrical.
%
%   R = POWRND(q,[a b],m,n,...) or  R = POWRND(q,[a b],[m,n,...]) returns an
%   M-by-N-by-... array.
%
%   powrnd uses the inversion method.
%
%   Created by
%   Rivan 14/7/2016
%   Last Update 4/8/2016
%%
if nargin < 2
    error('powrnd: Too Few Inputs')
end

if q < 0
    error('powrnd: q Value Cannot Be Negative')
end

%% Calculate the L value from the interval 
L = (itvl(2)-itvl(1))/2;
midval = (itvl(2) + itvl(1))/2; % mean
p = rand(varargin{:}); % generate uniformly distributed random numbers [0,1]
R = zeros(varargin{:}); % initialize array R
sz = size(p);
totalsz = 1;
for i=1:size(sz,2)
   totalsz = totalsz * sz(i); 
end

%% Generate uniform random values, and apply the inverse CDF 
for indx = 1:totalsz
    % for negative value the result somehow is in imaginary numbers, need to obtain the magnitude
    % different q requires different formula for negative numbers
    % if the center is not at zero, shift it to midval 
    if (p(indx) < 0.5) 
        if (mod(q,2) == 0) 
            R(indx) = - abs( L*(2*p(indx) - 1).^(1/(q+1)) ) + midval; 
        else
            R(indx) = - abs( L*(1-2*p(indx)).^(1/(q+1)) ) + midval;
        end
    else
        R(indx) = L*(2*p(indx) - 1).^(1/(q+1)) + midval;
    end
end