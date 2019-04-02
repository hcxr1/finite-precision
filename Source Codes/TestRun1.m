function [] = TestRun1()
% Arvind 24/2/2017
%
clc; clear; close all;
set(0,'DefaultFigureWindowStyle','docked')

% RUN GP
gp = rungp(@testrun_config);
gppretty(gp,'best')
runtree(gp,'best')
end

function gp = testrun_config(gp)
% run control
gp.runcontrol.pop_size = 100;			
gp.runcontrol.num_gen = 100;			                                 
gp.fitness.minimisation = true;
% gp.fitness.fitfun = @testrun_fitfun;

% data
x1 = random('uniform',-7.5,7.5,ceil(1.5*(2*2+1)),1);
x2 = random('uniform',-7.5,7.5,ceil(1.5*(2*2+1)),1);
gp.userdata.xtrain = [x1 x2];
gp.userdata.ytrain = 0.16*(x1-1).^3 + x2 - 4 + 0.04*cos(x1.*x2); 
gp.userdata.name = 'Nonlinear Function';
gp.nodes.const.range = [-3 3];

%Define the number of inputs
gp.nodes.inputs.num_inp = size(gp.userdata.xtrain,2);

% Enable multiple gene mode, set tree depth and set max number of genes per
% individual.
gp.genes.multigene = true;
gp.genes.max_genes = 4;
gp.treedef.max_depth = 5;

%Define function nodes
gp.nodes.functions.name = {'times','minus','plus','square','cube','add3','mult3','power'};
end