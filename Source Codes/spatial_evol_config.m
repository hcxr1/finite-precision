function gp = spatial_evol_config(gp)
%SPATIAL_EVO_CONFIG Multigene config file for y = 1/(1+x1^-4) + 1/(1+x2^-4)

%run control
gp.runcontrol.pop_size = 250; %population of 250 models		  			   
gp.runcontrol.runs = 2; %perform 2 runs that are merged at the end
gp.runcontrol.timeout = 60; %each run terminates after 60 seconds
gp.runcontrol.parallel.auto = true; %enable Parallel Computing if installed

%selection
gp.selection.tournament.size = 20; 
gp.selection.tournament.p_pareto = 0.3; %encourages less complex models 
gp.selection.elite_fraction = 0.3; % approx. 1/3 models copied to next gen

%genes
gp.genes.max_genes = 10;  

%2d training grid in range -5 to 5 (676 points)
[x1,x2] = meshgrid(-5:0.4:5,-5:0.4:5);
x1 = x1(:); x2 = x2(:); %convert grid to vectors
y = (1./(1+x1.^-4)) + (1./(1+x2.^-4));
gp.userdata.ytrain = y;
gp.userdata.xtrain = [x1 x2];


%test grid in range -5 to 5 (2601 points)
[x1,x2] = meshgrid(-5:0.2:5,-5:0.2:5);
x1 = x1(:); x2 = x2(:); 
y = (1./(1+x1.^-4)) + (1./(1+x2.^-4));
gp.userdata.ytest = y;
gp.userdata.xtest = [x1 x2];

%function nodes
gp.nodes.functions.name = {'times','minus','plus','rdivide','square',...
    'sin','cos','exp','mult3','add3','sqrt','cube','power','negexp',...
    'neg','abs','log'};
