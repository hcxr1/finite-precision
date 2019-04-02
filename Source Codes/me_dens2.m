function [lambda,p,entr]=me_dens2(mu,x,lambda0)
%ME_DENS2
% [LAMBDA,P,ENTR]=ME_DENS2(MU,X,LAMBDA0)
% This program calculates the Lagrange Multipliers of the ME
% probability density functions p(x) from the knowledge of the
% N moment contstraints in the form:
% E{x^n}=mu(n) n=0:N with mu(0)=1.
%
% INPUTS:
% MU is a table containing the constraints MU(n),n=1:N.
% X is a table defining the range of the variation of x.
% LAMBDA0 is a table containing the first estimate of the LAMBDAs.
% (This argument is optional)
%
% OUTPUTS:
% LAMBDA is a table containing the resulting Lagrange parameters.
% P is a table containing the resulting pdf p(x).
% ENTR is a table containing the entropy values at each
% iteration.
%
% Author: A. Mohammad-Djafari
% Date : 10-01-1991
%
% Edited: Arvind Rajan
% Date : 15-03-2016
%

% Step 1: Define the range and the discretization step of x, typically 
% [mu-10*sigma,mu+10*sigma]
mu = mu(:); mu = [1;mu]; % add mu(0)=1
x = x(:); lx = length(x); % x axis
xmin = x(1); xmax = x(lx); dx = x(2)-x(1);

% Step 2: If the initial estimate of Lambda is not given, Lambda0 =
% log(xmax-xmin). Else, assign the input estimates
if(nargin == 2) % initialize LAMBDA
    lambda = zeros(size(mu)); 
    lambda(1) = log(xmax-xmin);
else
    lambda = lambda0(:);
end

N = length(lambda);
M = 2*N-1;
fin = zeros(length(x),M);

% Calculate the base function, phi(x)=x.^n, in this case
fin(:,1) = ones(size(x)); % fi0(x)=1
for n = 2:M
    fin(:,n) = x.*fin(:,n-1);
end

% Iteration to find lambda begins here
iter = 0;
while 1 % start iterations
    % Display iteration on command window
    iter=iter+1;
    disp('---------------'); 
    disp(['iter = ',num2str(iter)]);
    
    % Step 3: Calculate the (N +1) integrals in equations (4) and the N(N -1)/2
    % distinct elements g_nk of the matrix G by calculating the integrals in
    % the equations(8)
    
    % Calculate p(x)
    p = exp(-(fin(:,1:N)*lambda));
    plot(x,p); % plot it
    pause(0.1) % Arvind added for fun
     
    % Calculate Gn integral (4) in the reference
    G = zeros(M,1);
    for n=1:M
        G(n) = dx*sum(fin(:,n).*p);
    end
    
    % Calculate the entropy value and display it
    entr(iter) = lambda'*G(1:N);
    disp(['Entropy = ',num2str(entr(iter))])
    
    % Calculate gnk whereby Jacobian matrix G in reference is a Hankel 
    % matrix. gnk = G (symmetrical)
    gnk = zeros(N,N); 
    for i = 1:N
        gnk(:,i) = -G(i:N+i-1);
    end
    
    % Step 4: Solve the equation (7) to find delta
    
    % Calculate v
    v = mu-G(1:N);
    
    % Calculate delta
    delta = gnk\v;
    
    % Step 5: Calculate Lambda = Lambda0 + delta and go back to step 3 until
    % delta becomes negligible

    % Calculate lambda
    lambda = lambda+delta;
    
    % Stopping rules
    eps=1e-6;
    
    % Check for convergence
    if(abs(delta./lambda)<eps), break, end
    
    if(iter>2)
        if(abs((entr(iter)-entr(iter-1))/entr(iter))<eps), break, end
    end
end

% Calculate final p(x) and plot it
p=exp(-(fin(:,1:N)*lambda));
% plot(x,p);
entr=entr(:);
disp('----- END -------')
end