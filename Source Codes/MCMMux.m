% Monte Carlo Simulation - Matrix Multiplication (3x3 testing)
% Created By Rivan
% Last Updated 21/9/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;%close all;
set(0,'DefaultFigureWindowStyle','docked');

%% 2. Initialize the parameters
%--------------------------------------------------------
x = sym('x',[1,200],'real');
d = sym('d',[1,200],'real');
nMC   = 1e8; %number of monte carlo
m = 8; % mantissa bit
n = 3; % n x n DCT matrix size
id = 1;
A = [x(1) x(2) -x(1);x(3) x(3) x(3);x(1) x(2) -x(1)];
% A = [x(1) x(2) x(3) -x(2) -x(1); x(2) x(5) x(6) -x(5) -x(2); x(4) x(4) x(4) x(4) x(4);x(2) x(5) x(6) -x(5) -x(2); x(1) x(2) x(3) -x(2) -x(1)];
AT = A';

count = 1;
for i = 1 : n
    for j = 1 : n
        temp = 0;
        for k = 1 : n
            temp = temp + A(i,k) * AT(k,j) * d(count);
            count = count + 1;
        end
        PolyModel(i,j) = temp;
    end
end
zmodel = matlabFunction(PolyModel);
q= 0;
%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
% Pfloat = zeros(1e6,9);
for i = 1 : nMC
    aval = (2 + 1)*rand() -1;
    bval = (3 + 2)*rand() -2;
%     cval = (5 + 3)*rand() -3;
    cval = (2^-m + 2^-m)*rand()  - 2^-m;
%     e_val = (5+1)*rand() -1;
%     fval = (3+ 1)*rand() - 1;
    err = (1+2^-m - (1-2^-m))*rand(n^3,1) + 1 - 2^-m;
    
    Pmat = zmodel(err(1),err(2),err(3),err(4),err(5),err(6),err(7),err(8),err(9),err(10),err(11),err(12),err(13),err(14),err(15),err(16),err(17),err(18),err(19),err(20),err(21),err(22),err(23),err(24),err(25),err(26),err(27),aval,bval,cval);
%     Pmat = zmodel(err(1),err(2),err(3),err(4),err(5),err(6),err(7),err(8),err(9),err(10),err(11),err(12),err(13),err(14),err(15),err(16),err(17),err(18),err(19),err(20),err(21),err(22),err(23),err(24),err(25),err(26),err(27),err(28),err(29),err(30),err(31),err(32),err(33),err(34),err(35),err(36),err(37),err(38),err(39),err(40),err(41),err(42),err(43),err(44),err(45),err(46),err(47),err(48),err(49),err(50),err(51),err(52),err(53),err(54),err(55),err(56),err(57),err(58),err(59),err(60),err(61),err(62),err(63),err(64),err(65),err(66),err(67),err(68),err(69),err(70),err(71),err(72),err(73),err(74),err(75),err(76),err(77),err(78),err(79),err(80),err(81),err(82),err(83),err(84),err(85),err(86),err(87),err(88),err(89),err(90),err(91),err(92),err(93),err(94),err(95),err(96),err(97),err(98),err(99),err(100),err(101),err(102),err(103),err(104),err(105),err(106),err(107),err(108),err(109),err(110),err(111),err(112),err(113),err(114),err(115),err(116),err(117),err(118),err(119),err(120),err(121),err(122),err(123),err(124),err(125),aval,bval,cval,dval,e_val,fval);
    Pfloat1(i)=Pmat(1);
    Pfloat2(i)=Pmat(2);
    Pfloat3(i)=Pmat(3);
    Pfloat4(i)=Pmat(4);
    Pfloat5(i)=Pmat(5);
    Pfloat6(i)=Pmat(6);
    Pfloat7(i)=Pmat(7);
    Pfloat8(i)=Pmat(8);
    Pfloat9(i)=Pmat(9);
%     Pfloat10(i)=Pmat(10);
%     Pfloat11(i)=Pmat(11);
%     Pfloat12(i)=Pmat(12);
%     Pfloat13(i)=Pmat(13);
%     Pfloat14(i)=Pmat(14);
%     Pfloat15(i)=Pmat(15);
%     Pfloat16(i)=Pmat(16);
%     Pfloat17(i)=Pmat(17);
%     Pfloat18(i)=Pmat(18);
%     Pfloat19(i)=Pmat(19);
%     Pfloat20(i)=Pmat(20);
%     Pfloat21(i)=Pmat(21);
%     Pfloat22(i)=Pmat(22);
%     Pfloat23(i)=Pmat(23);
%     Pfloat24(i)=Pmat(24);
%     Pfloat25(i)=Pmat(25);
end

bound1 = [min(Pfloat1) max(Pfloat1)]
bound2 = [min(Pfloat2) max(Pfloat2)]
bound3 = [min(Pfloat3) max(Pfloat3)]
bound4 = [min(Pfloat4) max(Pfloat4)]
bound5 = [min(Pfloat5) max(Pfloat5)]
bound6 = [min(Pfloat6) max(Pfloat6)]
bound7 = [min(Pfloat7) max(Pfloat7)]
bound8 = [min(Pfloat8) max(Pfloat8)]
bound9 = [min(Pfloat9) max(Pfloat9)]
% bound10 = [min(Pfloat10) max(Pfloat10)]
% bound11 = [min(Pfloat11) max(Pfloat11)]
% bound12 = [min(Pfloat12) max(Pfloat12)]
% bound13 = [min(Pfloat13) max(Pfloat13)]
% bound14 = [min(Pfloat14) max(Pfloat14)]
% bound15 = [min(Pfloat15) max(Pfloat15)]
% bound16 = [min(Pfloat16) max(Pfloat16)]
% bound17 = [min(Pfloat17) max(Pfloat17)]
% bound18 = [min(Pfloat18) max(Pfloat18)]
% bound19 = [min(Pfloat19) max(Pfloat19)]
% bound20 = [min(Pfloat20) max(Pfloat20)]
% bound21 = [min(Pfloat21) max(Pfloat21)]
% bound22 = [min(Pfloat22) max(Pfloat22)]
% bound23 = [min(Pfloat23) max(Pfloat23)]
% bound24 = [min(Pfloat24) max(Pfloat24)]
% bound25 = [min(Pfloat25) max(Pfloat25)]
toc