% Monte Carlo Simulation - Matrix Multiplication of a Vector v3.0
% Created By Rivan
% Last Updated 17/1/2017
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;close all;
set(0,'DefaultFigureWindowStyle','docked');

%% 2. Initialize the parameters
%--------------------------------------------------------

d = sym('d',[1,200],'real');
nMC   = 1e7; %number of monte carlo
m = 8; % mantissa bit
n = 10; % n x n DCT matrix size
f = 5; % frequency
Ts = 0.1; % sampling time
DCTmat = dctmodel(n,d,1);
t = linspace(0.5,2.5,n); % time vector
for id = 1 : n
    Wavemodel(id) = (2 * triwavemodel(2*pi*f*Ts*t(id))) * d(n^2+id);
end
FloatModel = DCTmat * Wavemodel' * d(n^2+n+1);
Fmodel = matlabFunction(FloatModel);
% nargin(Fmodel)
%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
for i = 1 : nMC
    err = powrnd(1e6,[1-2^-m,1+2^-m],n^2+n+1,1); % (1+2^-m - (1-2^-m))*rand(n^2+n+1,1) + 1 - 2^-m;
    Pmat = Fmodel(err(1),err(2),err(3),err(4),err(5),err(6),err(7),err(8),err(9),err(10),err(11),err(12),err(13),err(14),err(15),err(16),err(17),err(18),err(19),err(20),err(21),err(22),err(23),err(24),err(25),err(26),err(27),err(28),err(29),err(30),err(31),err(32),err(33),err(34),err(35),err(36),err(37),err(38),err(39),err(40),err(41),err(42),err(43),err(44),err(45),err(46),err(47),err(48),err(49),err(50),err(51),err(52),err(53),err(54),err(55),err(56),err(57),err(58),err(59),err(60),err(61),err(62),err(63),err(64),err(65),err(66),err(67),err(68),err(69),err(70),err(71),err(72),err(73),err(74),err(75),err(76),err(77),err(78),err(79),err(80),err(81),err(82),err(83),err(84),err(85),err(86),err(87),err(88),err(89),err(90),err(91),err(92),err(93),err(94),err(95),err(96),err(97),err(98),err(99),err(100),err(101),err(102),err(103),err(104),err(105),err(106),err(107),err(108),err(109),err(110),err(111));
    
    Pfloat1(i)=Pmat(1);
    Pfloat2(i)=Pmat(2);
    Pfloat3(i)=Pmat(3);
    Pfloat4(i)=Pmat(4);    
    Pfloat5(i)=Pmat(5);
    Pfloat6(i)=Pmat(6);
    Pfloat7(i)=Pmat(7);
    Pfloat8(i)=Pmat(8);
    Pfloat9(i)=Pmat(9);
    Pfloat10(i)=Pmat(10);
end
bound1 = [min(Pfloat1) max(Pfloat1)];
bound2 = [min(Pfloat2) max(Pfloat2)];
bound3 = [min(Pfloat3) max(Pfloat3)];
bound4 = [min(Pfloat4) max(Pfloat4)];
bound5 = [min(Pfloat5) max(Pfloat5)];
bound6 = [min(Pfloat6) max(Pfloat6)];
bound7 = [min(Pfloat7) max(Pfloat7)];
bound8 = [min(Pfloat8) max(Pfloat8)];
bound9 = [min(Pfloat9) max(Pfloat9)];
bound10 = [min(Pfloat10) max(Pfloat10)];
bounds = [bound1;bound2;bound3;bound4;bound5;bound6;bound7;bound8;bound9;bound10]
% for ind = 1 : n
%     Pfloat = zeros(nMC,1);
%     for i = 1 : nMC
%         % Generating Random Number
%         d = (1 + 2^-m - 1 + 2^-m).*rand(n*3,1) + 1 - 2^-m;
%         knd = 1;
%         id = 1;
%         for jnd = 1 : n
%             z(jnd) = DCTmat(ind,jnd) * d(knd)  * (2 * triwavemodel(2*pi*f*Ts*t(id)) - 1) * d(knd+1) * d(knd+2);
%             id = id + 1;
%             knd = knd + 3;
%         end
%         % Model: Matrix Multiplication DCT Matrix
%         Pfloat(i) = sum(z);
%     end
%     DataFloat(:,ind) = Pfloat(:);
%     bound(ind,:) = [min(Pfloat) max(Pfloat)];
% end
% bound

toc