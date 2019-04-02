% Monte Carlo Simulation - Matrix Multiplication (3x3 testing)
% Created By Rivan
% Last Updated 21/9/2016
tic
%% 1. clearing workspace and command window
% -------------------------------------------------------
clear all;clc;close all;
set(0,'DefaultFigureWindowStyle','docked');

%% 2. Initialize the parameters
%--------------------------------------------------------
x = sym('x',[1,200],'real');
d = sym('d',[1,200],'real');
nMC   = 1e7; %number of monte carlo
m = 8; % mantissa bit
n = 5; % n x n DCT matrix size
id = 1;

DCTmat = dctmodel(n,d,1);
for i = 1 : n
    for j = 1 : n
        DataIn(i,j) = x(n^2+id);
        id = id + 1;
    end
end
DCTmatT = DCTmat'; % Transpose of DCT Matrix

for i = 1 : n
    for j = 1 : n
        temp = 0;
        for k = 1 : n
            temp = temp + DCTmat(i,k) * DataIn(k,j);
        end
        NewMat(i,j) = temp;
    end
end

for i = 1 : n
    for j = 1 : n
        temp = 0;
        for k = 1 : n
            temp = temp + NewMat(i,k) * DCTmatT(k,j);
        end
        PolyModel(i,j) = temp;
    end
end
zmodel = matlabFunction(PolyModel);
% z1 = matlabFunction(PolyModel(1));
% z2 = matlabFunction(PolyModel(2));
% z3 = matlabFunction(PolyModel(3));
% z4 = matlabFunction(PolyModel(4));
% z5 = matlabFunction(PolyModel(5));
% z6 = matlabFunction(PolyModel(6));
% z7 = matlabFunction(PolyModel(7));
% z8 = matlabFunction(PolyModel(8));
% z9 = matlabFunction(PolyModel(9));
% z10 = matlabFunction(PolyModel(10));
% z11 = matlabFunction(PolyModel(11));
% z12 = matlabFunction(PolyModel(12));
% z13 = matlabFunction(PolyModel(13));
% z14 = matlabFunction(PolyModel(14));
% z15 = matlabFunction(PolyModel(15));
% z16 = matlabFunction(PolyModel(16));
% z17 = matlabFunction(PolyModel(17));
% z18 = matlabFunction(PolyModel(18));
% z19 = matlabFunction(PolyModel(19));
% z20 = matlabFunction(PolyModel(20));
% z21 = matlabFunction(PolyModel(21));
% z22 = matlabFunction(PolyModel(22));
% z23 = matlabFunction(PolyModel(23));
% z24 = matlabFunction(PolyModel(24));
% z25 = matlabFunction(PolyModel(25));

%% 3. Simulation to obtain statistical data
% --------------------------------------------------------
% Pfloat = zeros(1e6,9);
parfor i = 1 : nMC
    xval = rand(n^2,1);
    err =(1+2^-m - (1-2^-m))*rand(n^2,1) + 1 - 2^-m;
    
    Pmat = zmodel(err(1),err(2),err(3),err(4),err(5),err(6),err(7),err(8),err(9),err(10),err(11),err(12),err(13),err(14),err(15),err(16),err(17),err(18),err(19),err(20),err(21),err(22),err(23),err(24),err(25),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9),xval(10),xval(11),xval(12),xval(13),xval(14),xval(15),xval(16),xval(17),xval(18),xval(19),xval(20),xval(21),xval(22),xval(23),xval(24),xval(25));
    
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
    Pfloat11(i)=Pmat(11);
    Pfloat12(i)=Pmat(12);
    Pfloat13(i)=Pmat(13);
    Pfloat14(i)=Pmat(14);
    Pfloat15(i)=Pmat(15);
    Pfloat16(i)=Pmat(16);
    Pfloat17(i)=Pmat(17);
    Pfloat18(i)=Pmat(18);
    Pfloat19(i)=Pmat(19);
    Pfloat20(i)=Pmat(20);
    Pfloat21(i)=Pmat(21);
    Pfloat22(i)=Pmat(22);
    Pfloat23(i)=Pmat(23);
    Pfloat24(i)=Pmat(24);
    Pfloat25(i)=Pmat(25);


    
    
%     Pfloat(i) = z1(err(1),err(2),err(3),err(4),err(5),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9),xval(10),xval(11),xval(12),xval(13),xval(14),xval(15),xval(16),xval(17),xval(18),xval(19),xval(20),xval(21),xval(22),xval(23),xval(24),xval(25));
%     Qfloat(i) = z2(err(1),err(2),err(3),err(4),err(5),err(6),err(7),err(8),err(9),err(10),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9),xval(10),xval(11),xval(12),xval(13),xval(14),xval(15),xval(16),xval(17),xval(18),xval(19),xval(20),xval(21),xval(22),xval(23),xval(24),xval(25));
%     Rfloat(i) = z3(err(1),err(2),err(3),err(4),err(5),err(11),err(12),err(13),err(14),err(15),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9),xval(10),xval(11),xval(12),xval(13),xval(14),xval(15),xval(16),xval(17),xval(18),xval(19),xval(20),xval(21),xval(22),xval(23),xval(24),xval(25));
%     Sfloat(i) = z4(err(1),err(2),err(3),err(4),err(5),err(16),err(17),err(18),err(19),err(20),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9),xval(10),xval(11),xval(12),xval(13),xval(14),xval(15),xval(16),xval(17),xval(18),xval(19),xval(20),xval(21),xval(22),xval(23),xval(24),xval(25));
%     Tfloat(i) = z5(err(1),err(2),err(3),err(4),err(5),err(21),err(22),err(23),err(24),err(25),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9),xval(10),xval(11),xval(12),xval(13),xval(14),xval(15),xval(16),xval(17),xval(18),xval(19),xval(20),xval(21),xval(22),xval(23),xval(24),xval(25));
%     Ufloat(i) = z6(err(1),err(2),err(3),err(4),err(5),err(6),err(7),err(8),err(9),err(10),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9),xval(10),xval(11),xval(12),xval(13),xval(14),xval(15),xval(16),xval(17),xval(18),xval(19),xval(20),xval(21),xval(22),xval(23),xval(24),xval(25));
%     Vfloat(i) = z7(err(6),err(7),err(8),err(9),err(10),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9),xval(10),xval(11),xval(12),xval(13),xval(14),xval(15),xval(16),xval(17),xval(18),xval(19),xval(20),xval(21),xval(22),xval(23),xval(24),xval(25));
%     Wfloat(i) = z8(err(4),err(5),err(6),err(7),err(8),err(9),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9));
%     Xfloat(i) = z9(err(7),err(8),err(9),xval(1),xval(2),xval(3),xval(4),xval(5),xval(6),xval(7),xval(8),xval(9));
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
bound10 = [min(Pfloat10) max(Pfloat10)]
bound11 = [min(Pfloat11) max(Pfloat11)]
bound12 = [min(Pfloat12) max(Pfloat12)]
bound13 = [min(Pfloat13) max(Pfloat13)]
bound14 = [min(Pfloat14) max(Pfloat14)]
bound15 = [min(Pfloat15) max(Pfloat15)]
bound16 = [min(Pfloat16) max(Pfloat16)]
bound17 = [min(Pfloat17) max(Pfloat17)]
bound18 = [min(Pfloat18) max(Pfloat18)]
bound19 = [min(Pfloat19) max(Pfloat19)]
bound20 = [min(Pfloat20) max(Pfloat20)]
bound21 = [min(Pfloat21) max(Pfloat21)]
bound22 = [min(Pfloat22) max(Pfloat22)]
bound23 = [min(Pfloat23) max(Pfloat23)]
bound24 = [min(Pfloat24) max(Pfloat24)]
bound25 = [min(Pfloat25) max(Pfloat25)]

toc