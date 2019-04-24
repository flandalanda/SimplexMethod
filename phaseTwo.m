function [bound, obasis, obfs, oval] = phaseTwo(A, b, c, sbasis, sbfs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[Q P r, nbasis] = calcTab(A, b , c, sbasis);


enterVarIndex = minPositiveIndex(r);

while enterVarIndex > 0
    exitVarIndex = getLeavingVar(P,Q,enterVarIndex);
    sbasis(exitVarIndex) = nbasis(enterVarIndex);
    [Q P r, nbasis] = calcTab(A, b, c, sbasis);
end
obasis = sbasis;
bound = 0;
obfs = 1;
oval = 2;
end

