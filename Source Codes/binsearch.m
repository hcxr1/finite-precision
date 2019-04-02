function bound = binsearch(start,num,den,delta)
% start [lbound ubound], num [lbound ubound], den [lbound ubound],
% delta[.. ..]: control the tightness of the bound
% Last Edited 20/1/2017
% Search to refine bound (Division operation)

lo = 1; hi = 1e6;
sspace = linspace(start(1),start(2),hi); % searching space

chkl = num(1) - den(1) .* sspace;
chku = den(2) .* sspace - num(2);

% check for strictly positive num - den * bound
vall = find(diff(chkl>=delta(1)),1);
valu = find(diff(chku>=delta(2)),1);

bound = [sspace(vall) sspace(valu)];
