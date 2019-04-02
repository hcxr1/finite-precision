function c = dctmodel(n,x,count)
% dctmodel - generate floating point model of Discrete cosine transform matrix.
%   D = dctmodel(N,x,count) returns the N-by-N DCT transform matrix with d is
%   the delta term correspond to 2^-mantissa and count is the counter.  D*A
%   is the DCT of the columns of A and D'*A is the inverse DCT of
%   the columns of A (when A is N-by-N).
%
%   If A is square, the two-dimensional DCT of A can be computed
%   as D*A*D'. This computation is sometimes faster than using
%   DCT2, especially if you are computing large number of small
%   DCT's, because D needs to be determined only once.
%
% Last Modified
% By Rivan
% 20/9/2016

validateattributes(n,{'double'},{'integer' 'scalar'},mfilename,'n',1);

[cc,rr] = meshgrid(0:n-1);

for ind = 1 : n
    for jnd = 1 : n
        c(ind,jnd) = sqrt(2 / n) * cos(pi * (2*cc(ind,jnd) + 1) .* rr(ind,jnd) / (2 * n)) * x(count);
        count = count + 1;
    end
end
c(1,:) = c(1,:) / sqrt(2);