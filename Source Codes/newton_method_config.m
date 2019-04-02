function gp = newton_method_config(gp)
%Newton_Method_CONFIG file for y = x - (x^3+x^2-2x)/(3x^2+2x-2)
% run control
gp.runcontrol.pop_size = 100;			
gp.runcontrol.num_gen = 100;			                                 
gp.fitness.minimisation = true;
% gp.fitness.fitfun = @testrun_fitfun;

% data
% q = 0;
mantissa = 8;
% x1 = powrnd(q,[0.7,1.1],2*(2^3+1),1);
x1 =(1.1-0.7)*rand(2*(2^3+1),1)+0.7; % random('uniform',-7.5,7.5,ceil(1.5*(2*2+1)),1);
% x2 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1); % random('uniform',-7.5,7.5,ceil(1.5*(2*2+1)),1);%
x2 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;
% x3 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x3 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x4 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x4 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x5 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x5 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x6 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x6 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x7 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x7 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x8 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x8 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x9 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x9 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x10 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x10 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x11 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x11 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x12 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x12 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%
% x13 = powrnd(q,[1-2^-mantissa,1+2^-mantissa],2*(2^3+1),1);% 
x13 = (1+2^-mantissa-(1-2^-mantissa))*rand(2*(2^3+1),1)+1-2^-mantissa;%

gp.userdata.xtrain = [x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13];
gp.userdata.ytrain = (x1.*(-2 + (3.*x1.^2.*x2.*x7 + 2.*x1.*x8).*x9).*x10.*x11-((x1.^2.*x2 + x1.^3.*x2.*x3).*x4-2.*x1.*x5).*x6).*x12.*x13./((-2 + (3.*x1.^2.*x2.*x7 + 2.*x1.*x8).*x9).*x10) - (x1-(x1.^3+x1.^2-2*x1)./(3*x1.^2+2*x1-2));% 0.16*(x1-1).^3 + x2 - 4 + 0.04*cos(x1.*x2); 
gp.userdata.name = 'Nonlinear Function';
gp.nodes.const.range = [-10 10];

%Define the number of inputs
gp.nodes.inputs.num_inp = size(gp.userdata.xtrain,13);

% Enable multiple gene mode, set tree depth and set max number of genes per
% individual.
gp.genes.multigene = true;
gp.genes.max_genes = 4;
gp.treedef.max_depth = 3;

%Define function nodes
gp.nodes.functions.name = {'times','minus','plus','square','cube','add3','mult3'};
end