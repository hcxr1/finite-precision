function EP = FastPolyMomentVpa(P_in,x,DistType,M,NV,Pres)
% Copyright (c) 2017, Arvind Rajan & Ye Chow Kuang
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without modification, are permitted provided that 
% the following conditions are met:
%     * Redistributions of source code must retain the above copyright 
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright 
%       notice, this list of conditions and the following disclaimer in 
%       the documentation and/or other materials provided with the distribution
%       
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.
%
% DistType format: 
% ================
% 	symmetrical  two-sided(most useful) : DistType{}.Sym = 0
%   one-sided right                     : DistType{}.Sym = 1
%   one-sided left                      : DistType{}.Sym = 2
%
% Acceptable DistType.Name:
% =========================
% Uniform       DistType{}.Name = {'uni'}];    DistType{}.Param   = {[translation, scale]}
% Trapezoidal   DistType{}.Name = {'tra'}];    DistType{}.Param   = {[translation, scale, beta]}
% Triangular    DistType{}.Name = {'tri'}];    DistType{}.Param   = {[translation, scale]}
% Beta          DistType{}.Name = {'bet'}];    DistType{}.Param   = {[translation, scale, beta1, beta2]}
% Normal        DistType{}.Name = {'nor'}];    DistType{}.Param   = {[translation, scale]}
% Student       DistType{}.Name = {'stu'}];    DistType{}.Param   = {[translation, scale, beta]}
% Laplace       DistType{}.Name = {'lap'}];    DistType{}.Param   = {[translation, scale]}
% Gamma         DistType{}.Name = {'gam'}];    DistType{}.Param   = {[translation, scale, beta]}
% Weibull       DistType{}.Name = {'wei'}];    DistType{}.Param   = {[translation, scale, beta]}
% Maxwell       DistType{}.Name = {'max'}];    DistType{}.Param   = {[translation, scale]}
% 
%
% Note: 
% =====
% 1. DistType{}.Param are all symbolic objects defined by the user external to this function
% 2. Polynomial P is a symbolic object where indepenxdent variables are assumed to be x = sym('x',[N,1])
% 3. DistType{}.Sym = 3 requires parameters to be given in the following form
%           DistType{}.Param  = {[translation, scale_left, (beta1_left), (beta2_left)],[translation, scale_right, (beta1_right), (beta2_right)]}
%
% Last updated by 
% Arvind Rajan & Ye Chow Kuang on 08/03/2017
% Monash University Malaysia
%

% Convert multivariate polynomial into multidimensional matrix
fprintf('Converting multivariate polynomial using sparse matrix indexing... ')

if nargin == 6, digits(Pres), end

P     = expand(P_in);
[b,T] = coeffs(P,x);

imdex = 1;
for index = 1:length(T)
    SymList = symvar(T(index));
    for jndex = 1:length(SymList)
        y  = SymList(jndex);                                
        m  = double(feval(symengine,'degree',T(index),y));
        
        [~, pos]        = ismember(y, x);
        mdex(imdex,pos) = m+1;
    end
    
    mdex(index,NV+1) = b(index);
    imdex = imdex + 1;
    
    if index == length(T), mdex(~mdex) = 1; end
end

for i = 1:NV
    DistType{i}.Param{:} = sym(DistType{i}.Param{:});
end

fprintf('Completed!\n')

fprintf('Moment calculation begins...')
tic
EP = zeros(M,1);
for index = 1:M
    fprintf('.')
    if index == 1
        Emdex = mdex;
    else
        Emdex = FastConvolution(Emdex,mdex,NV);
    end
    EP(index) = CalcMoment(Emdex,DistType,NV);
end
fprintf(' Completed!\n\n')
fprintf('Total time taken was %f seconds\n\n', toc)
end

function Mom = CalcMoment(Emdex,DistType,NV)
imdex = sym(Emdex(:,1:NV)-1);
b = sym(Emdex(:,end));

ET  = sym(ones(length(b),1));
for index = 1:length(b)
    SymList = find(imdex(index,:));
    for jndex = 1:length(SymList)
        ptx = SymList(jndex);
        m = double(imdex(index,ptx));
        p = 0:m;
        coef = zeros(1,length(p));
        Evm = zeros(1,length(p));
        
        SymType = DistType{ptx}.Sym;
        Param   = DistType{ptx}.Param;
        mNV     = Param{1}(1);
        sNV     = Param{1}(2);
        
        for ni = p
            coef(ni+1) = nchoosek(m,ni);
            % Select formula accoding to the distribution type
            switch lower(DistType{ptx}.Name{1})
                case {'uniform','uni'}
                    Evm_temp = (sNV)^ni / ((ni+1)*2);
                case {'lognormal','logn'}
                    Evm_temp = exp((ni^2/2)*(sNV)^2) / 2;
                case {'trapezoidal','tra'}
                    Shape = Param{1}(3);
                    Evm_temp = (sNV)^ni / (ni^2+3*ni+2) * (1-Shape^(ni+2))/(1-Shape^2);
                case {'triangular','tri'}
                    Evm_temp = (sNV)^ni / (ni^2+3*ni+2);
                case {'beta', 'bet'}
                    Shape1 = Param{1}(3);
                    Shape2 = Param{1}(4);
                    gain = 1/2;
                    for ptm = 1 : ni
                        gain = gain*(Shape1+ptm-1)/(Shape1+Shape2+ptm-1);
                    end
                    Evm_temp = (sNV)^ni * gain;
                case {'normal','nor'}
                    if mod(ni,2)==0
                        Evm_temp = (sNV)^ni * prod(1:2:ni-1)/2;
                    else
                        Evm_temp = (sNV)^ni * prod(1:(ni-1)/2)* 2^(ni/2-1)/sqrt(pi);
                    end
                case {'student','stu'}
                    Shape = Param{1}(3);
                    Evm_temp = (sNV)^ni * ( Shape^(ni/2)*gamma((ni+1)/2)*gamma((Shape-ni)/2) )/(2*sqrt(pi)*gamma(Shape/2));
                case {'laplace','lap'}
                    Evm_temp = (sNV)^ni * factorial(ni)/2;
                case {'gamma','gam'}
                    Shape = Param{1}(3);
                    Evm_temp = (sNV)^ni * prod(Shape:Shape+ni-1)/2;
                case {'weibull','wei'}
                    Shape = Param{1}(3);
                    Evm_temp = (sNV)^ni * Shape/2*gamma(ni/Shape+1);
                case {'rayleigh','ray'}
                    Evm_temp = (sNV)^ni * 2^(ni/2-1)*gamma((2+ni)/2);
                case {'maxwell','max'}
                    if mod(ni,2)==0
                        Evm_temp = (sNV)^ni * prod(1:2:ni+1);
                    else
                        Evm_temp = (sNV)^ni * (2^(ni/2+1)/sqrt(pi))*factorial((ni+1)/2);
                    end
                case {'power','pow'}
                    Shape = Param{1}(3);
                    Evm_temp =  (sNV)^ni * (Shape+1)/((ni+Shape+1)*2); % Edited Rivan 14/7/2016
                otherwise
                    error('Unknown distribution type')
            end
            
            % Adjust the moment according to the stated symmetry
            switch SymType
                case 0 % Symmetrical distribution
                    if mod(ni,2)==0
                        Evm(ni+1) = 2*Evm_temp;
                    else
                        Evm(ni+1) = 0;
                    end
                case 1 % One-sided distribution (right)
                    Evm(ni+1) = 2*Evm_temp;
                case 2 % One-sided distribution (left)
                    Evm(ni+1) = ((-1)^ni) * 2*Evm_temp;
            end
        end
        ET(index) = ET(index)*sum(coef.*(mNV.^(m-p).*Evm));
    end
end
Mom = double(sum(b.*ET));
end

function mdex = FastConvolution(EPsparse,Psparse,NV)
Avals     = EPsparse(:,end);
Bvals     = Psparse(:,end);
convVals  = Avals(:)*Bvals(:).';

Acoords   = EPsparse(:,1:NV);
Bcoords   = Psparse(:,1:NV);

convCoords = bsxfun(@plus, reshape(Bcoords.',NV,1,[]) ,Acoords.'-1);
convCoords = reshape(convCoords,NV,[]).';

[UniqueMat,~,ic] = unique(convCoords,'rows');

ActConvVals = zeros(size(UniqueMat,1),1);
for i = 1:size(UniqueMat,1)
    ActConvVals(i) = sum(convVals(ic == i));
end

mdex = [UniqueMat ActConvVals];
end