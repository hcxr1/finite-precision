% Copyright (c) 2013, Ye Chow Kuang
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
%%
function EP = PolyMoment(P_in,x,DistType,M,q)

% DistType format: 
% ================
% 	symmetrical  two-sided(most useful) : DistType{}.Sym = 0
%   asymmetrical two-sided(most general): DistType{}.Sym = 3

% Acceptable DistType.Name:
% =========================
% Uniform       DistType{}.Name = {'uni'}];    DistType{}.Param   = {[translation, scale]}
% 

% Note: 
% =====
% 1. DistType{}.Param are all symbolic objects defined by the user external to this function
% 2. Polynomial P is a symbolic object where indepenxdent variables are assumed to be x = sym('x',[N,1])
% 3. DistType{}.Sym = 3 requires parameters to be given in the following form
%           DistType{}.Param  = {[translation, scale_left, (beta1_left), (beta2_left)],[translation, scale_right, (beta1_right), (beta2_right)]}
%           DistType{}.w      = [weight_left, weight_right]
%
% Last updated by 
% Ye Chow Kuang on 21/02/2013
% Monash University Sunway campus

%% Start derivation
MuPad   = symengine;

N       = length(DistType);
v       = sym('v',[N,1]);           % Untranslated standard variable
EP      = sym('EP',[length(M),1]);  % M-th moments of the input polynomial
EvalCount   = 1;
                        
%% Main loop
for ptM = 1 : length(M)
    
    P       = expand(P_in^M(ptM));
    [b,T]   = coeffs(P,x);    
    ET      = sym(ones(length(T),1));      % Expectation of each monomial in P

    for index = 1 : length(T)
        SymList     = symvar(T(index));     % Decouple the product terms
        for jndex = 1 : length(SymList)     % Find moment of each independent variable
            y       = SymList(jndex);       % Isolate independent variable
            m       = double(feval(MuPad,'degree',T(index),y));
            
            ptx     = find(y==x);           % Identify the variable being isolated              
            Param   = DistType{ptx}.Param;  % Extract relevant distribution parameters

                % Check the feasibility of analytic expansion
                if (m<0 || rem(m,1)~=0) && Trans(ptx)~=0
                    fprintf('Error at evaluating moment of ');disp(x(ptp))
                    error('No known finite expression for this type of distribution')
                end                
                
                for kndex = 1 : EvalCount
                    Q           = expand((v(ptx)+Param{kndex}(1))^m);
                    [coef,vm]   = coeffs(Q,v(ptx));
                    Evm         = sym('Evm',[length(vm),1]);
                    
                    for lndex = 1 : length(vm)
                        ni  = feval(MuPad,'degree',vm(lndex));

                                if mod(ni,2)==0
                                    Evm(lndex) = 2*(Param{kndex}(2))^ni * (q+1)/((ni+q+1)*2); % Edited Rivan 14/7/2016
                                else
                                    Evm(lndex) = 0;
                                end

                    end % loop through vm
                end % EvalCount
                ET(index)	= ET(index) * coef*Evm;            
        end %loop through SymList
    end %loop through T
    EP(ptM) = b*ET;
    
end % ptM