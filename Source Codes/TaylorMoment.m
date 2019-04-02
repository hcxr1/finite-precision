function EP = TaylorMoment(EPnum, EPden,EPnumden)
% this function takes input the numerator moment (EPnum), denominator
% moment (EPden) and correlation between numerator and denominator and
% solve division operation through Taylor expansions

noMm = length(EPden)/2;
for i = 1 : noMm
    covXY = EPnumden(i) - EPnum(i)*EPden(i);
    varY = EPden(2*i)-EPden(i)^2;
    EP(i) = EPnum(i)/EPden(i) - covXY/EPden(i)^2 + EPnum(i)/EPden(i)^3*varY;
end