% Monte Carlo Simulation
% Model: Newton Method f(x) = x^3 + x^2 - 2*x (1 iteration)
% Created By Rivan
% Last Updated 8/8/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;close all;
set(0,'DefaultFigureWindowStyle','docked');
format LongE 

%% 2. Initialize the parameters
%--------------------------------------------------------
nMC   = 1e6; %number of monte carlo
m = 8; % mantissa bit
q = 100;
%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
for i=1:nMC
    % Generating Random Number
    
    x = powrnd(q,[0.7,1.5]); %(1.5-0.7).*rand() +0.7;
    err = powrnd(q,[1 - 2^-m,1 + 2^-m],12,1); %(1 + 2^-m - (1 - 2^-m)).*rand(12,1) + 1 - 2^-m; 
    
    % Floating Point Error Polynomial Model (Uniform Distribution)
%     z1 = ((x^2*err(1) + x^3*err(1)*err(2))*err(3) - 2*x*err(4))*err(5);
%     z2 = (-2 + (3*x^2*err(1)*err(2) + 2*x*err(3))*err(4))*err(5);
%     z3 = z1/z2*err(1);
%     z4 = (x-z3)*err(1);
%     z5 = z4 - (x-(x^3+x^2-2*x)/(3*x^2+2*x-2));
%     z6 = x-(x^3+x^2-2*x)/(3*x^2+2*x-2);
    z1 = (x*(-2 + (3*x^2*err(1)*err(6) + 2*x*err(7))*err(8))*err(9)*err(10)-((x^2*err(1) + x^3*err(1)*err(2))*err(3) - 2*x*err(4))*err(5))*err(11)*err(12);
    z2 = (-2 + (3*x^2*err(1)*err(6) + 2*x*err(7))*err(8))*err(9);
    z3 = z1/z2;
    z4 = (x-(x^3+x^2-2*x)/(3*x^2+2*x-2));
    z5 = z3-z4;
    Pfloat(1,i) = z1;
    Pfloat(2,i) = z2;
    Pfloat(3,i) = z3;
    Pfloat(4,i) = z4;
    Pfloat(5,i) = z5;
%     Pfloat(6,i) = z6;
end

[fx1,xi1]=hist(Pfloat(1,:),100);
[fx2,xi2]=hist(Pfloat(2,:),100);
[fx3,xi3]=hist(Pfloat(3,:),100);
[fx4,xi4]=hist(Pfloat(4,:),100);
[fx5,xi5]=hist(Pfloat(5,:),100);
% [fx6,xi6]=hist(Pfloat(6,:),100);

boundz1 = [min(Pfloat(1,:)) max(Pfloat(1,:))]
boundz2 = [min(Pfloat(2,:)) max(Pfloat(2,:))]
boundz3 = [min(Pfloat(3,:)) max(Pfloat(3,:))]
boundz4 = [min(Pfloat(4,:)) max(Pfloat(4,:))]
boundz5 = [min(Pfloat(5,:)) max(Pfloat(5,:))]
% boundz6 = [min(Pfloat(6,:)) max(Pfloat(6,:))]

%% 4. Normalize the pdf
% --------------------------------------------------------
dx1 = diff(xi1(1:2));
pdfmc1 = fx1/sum(fx1*dx1);
dx2 = diff(xi2(1:2));
pdfmc2 = fx2/sum(fx2*dx2);
dx3 = diff(xi3(1:2));
pdfmc3 = fx3/sum(fx3*dx3);
dx4 = diff(xi4(1:2));
pdfmc4 = fx4/sum(fx4*dx4);
dx5 = diff(xi5(1:2));
pdfmc5 = fx5/sum(fx5*dx5);
% dx6 = diff(xi6(1:2));
% pdfmc6 = fx5/sum(fx6*dx6);

%% 5. Plotting of the Distribution
% --------------------------------------------------------
% figure()
% bar(xi1,pdfmc1);
% figure()
% bar(xi2,pdfmc2);
% figure()
% bar(xi3,pdfmc3);
% figure()
% bar(xi4,pdfmc4);
% figure()
% bar(xi5,pdfmc5);
% figure()
% bar(xi6,pdfmc6);
toc