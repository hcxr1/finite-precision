%% -------------------------------------------------------------------------
clc; clear all;close all;
tic
set(0,'DefaultFigureWindowStyle','docked');
%% -------------------------------------------------------------------------
% format LongE
q=0;
mantissa = 8;
x = sym('x',[1,16],'real');
DistType{1}.Sym     = 0;
DistType{1}.Name    = {'pow'};
DistType{1}.Param   = {[1.1, 0.4, 	q]};
n=8;

DistType{2}.Sym     = 0;
DistType{2}.Name    = {'pow'};
DistType{2}.Param   = {[1, 2^-mantissa, q]};

DistType{3}.Sym     = 0;
DistType{3}.Name    = {'pow'};
DistType{3}.Param   = {[1, 2^-mantissa, q]};

DistType{4}.Sym     = 0;
DistType{4}.Name    = {'pow'};
DistType{4}.Param   = {[1, 2^-mantissa, q]};

DistType{5}.Sym     = 0;
DistType{5}.Name    = {'pow'};
DistType{5}.Param   = {[1, 2^-mantissa, q]};

DistType{6}.Sym     = 0;
DistType{6}.Name    = {'pow'};
DistType{6}.Param   = {[1, 2^-mantissa, q]};

DistType{7}.Sym     = 0;
DistType{7}.Name    = {'pow'};
DistType{7}.Param   = {[1, 2^-mantissa, q]};

DistType{8}.Sym     = 0;
DistType{8}.Name    = {'pow'};
DistType{8}.Param   = {[1, 2^-mantissa, q]};

DistType{9}.Sym     = 0;
DistType{9}.Name    = {'pow'};
DistType{9}.Param   = {[1, 2^-mantissa, q]};

DistType{10}.Sym     = 0;
DistType{10}.Name    = {'pow'};
DistType{10}.Param   = {[1, 2^-mantissa, q]};

DistType{11}.Sym     = 0;
DistType{11}.Name    = {'pow'};
DistType{11}.Param   = {[1, 2^-mantissa, q]};

DistType{12}.Sym     = 0;
DistType{12}.Name    = {'pow'};
DistType{12}.Param   = {[1, 2^-mantissa, q]};

%% -------------------------------------------------------------------------
f0 = x(13)/x(14);
f1 = x(15)/x(16);
Pnum = (x(1)*(-2 + (3*x(1)^2*x(2)*x(7) + 2*x(1)*x(5))*x(8))*x(9)*x(10)-((x(1)^2*x(2) + x(1)^3*x(2)*x(3))*x(4)-2*x(1)*x(5))*x(6))*x(11)*x(12);
Pden =(-2 + (3*x(1)^2*x(2)*x(7) + 2*x(1)*x(5))*x(8))*x(9);
PnumT = x(1)*(3*x(1).^2 + 2*x(1) - 2)-(x(1).^3 + x(1).^2 - 2*x(1));
PdenT = 3*x(1).^2 + 2*x(1) - 2;

x1 = subs(PnumT,x(1),1.1);
y1 = subs(PdenT,x(1),1.1);
x0 = subs(subs(subs(subs(subs(subs(subs(subs(subs(subs(subs(subs(Pnum,x(1),1.1),x(2),1),x(3),1),x(4),1),x(5),1),x(6),1),x(7),1),x(8),1),x(9),1),x(10),1),x(11),1),x(12),1);
y0 = subs(subs(subs(subs(subs(subs(subs(subs(subs(subs(subs(subs(Pden,x(1),1.1),x(2),1),x(3),1),x(4),1),x(5),1),x(6),1),x(7),1),x(8),1),x(9),1),x(10),1),x(11),1),x(12),1);
ftay2 = taylor(f0,[x(13),x(14)],[x0,y0],'Order',3); % 3 Order = order + 1
ftay3 = subs(subs(ftay2,x(13),Pnum),x(14), Pden);
ftay4 = taylor(f1,[x(15),x(16)],[x1,y1],'Order',3);
ftay5 = subs(subs(ftay4,x(15),PnumT),x(16),PdenT);
ftay6 = ftay3 - ftay5;
EP = FastPolyMoment(ftay6,x(1:12),DistType,4,12);

%% -------------------------------------------------------------------------
pt = 1e-3;
prob_lv = 1e-6;
limit = getbounds([1;EP]',pt);

xi = linspace(limit(1),limit(2),1e6);
%myabramem obtains distribution of the moment by using Maximum Entropy approach
[pdfxi,lambda] = myabramem(EP, xi);

pdfxi = pdfxi/trapz(xi,pdfxi); % normalize the pdf plot
cdfxi = cumtrapz(xi,pdfxi);  % find the cdf plot based on the pdf points

[mini,lbound] = min(abs(cdfxi - prob_lv));
[mini,ubound] = min(abs(cdfxi - (1-prob_lv)));
bound = [xi(lbound) xi(ubound)]
















%% -------------------------------------------------------------------------
% g = matlabFunction(ftay);
% h = matlabFunction(ftay3);
% xtay = linspace(0.7,1.5,1e3);

% plot(xtay,g(xtay),'r*'), hold on
% plot(xtay,h(xtay),'b.'), hold on
% actfun = @(x) x-(x.^3 + x.^2 - 2*x)./(3*x.^2 + 2*x - 2);
% plot(xtay,actfun(xtay)), hold off
% legend('Taylor App. - 2nd Order ftay','Taylor App. - 2nd Order ftay3','Actual','Location','Best')



%% -------------------------------------------------------------------------
% syms x y x(1)
% f = x(2)/x(3);
% fx = diff(f,x(2));
% fy = diff(f,x(3));
% fxx = diff(diff(f,x(2)),x(2));
% fyy = diff(diff(f,x(3)),x(3));
% fxy = diff(diff(f,x(2)),x(3));
% fyx = diff(diff(f,x(3)),x(2));
% Pnum = x(1)*(3*x(1).^2 + 2*x(1) - 2)-(x(1).^3 + x(1).^2 - 2*x(1));
% Pden = 3*x(1).^2 + 2*x(1) - 2;
% pt = 1.1;
% x0 = subs(Pnum,x(1),pt);
% y0 = subs(Pden,x(1),pt);

% f0 = x0/y0;
% fx = subs(subs(fx,x(2),x0),x(3),y0);
% fy = subs(subs(fy,x(2),x0),x(3),y0);
% fxx = subs(subs(fxx,x(2),x0),x(3),y0);
% fyy = subs(subs(fyy,x(2),x0),x(3),y0);
% fxy = subs(subs(fxy,x(2),x0),x(3),y0);
%%
% x(2) = x(1).^3 + x(1).^2 - 2*x(1);
% x(3) = 3*x(1).^2 + 2*x(1) - 2;
% ftay = f0 + (x(2) - x0)*fx + (x(3) - y0)*fy + (1/factorial(2))*((x(2) - x0)^2*fxx + 2*(x(2) - x0)*(x(3) - y0)*fxy + (x(3) - y0)^2*fyy)
