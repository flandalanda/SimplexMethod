function [bound, obasis, obfs, oval] = phaseTwo(A, b, c, sbasis, sbfs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[Q, P, r, nbasis,cb, invAb] = calcTab(A, b , c, sbasis);


enterVarIndex = minPositiveIndex(r);
bound = 1;
while enterVarIndex > 0 && bound == 1
    exitVarIndex = getLeavingVar(P,Q,enterVarIndex);
    if exitVarIndex > 0
        enterValue = nbasis(enterVarIndex);
        sbasis(exitVarIndex) = enterValue;
        [Q, P, r, nbasis,cb, invAb] = calcTab(A, b, c, sbasis);
        enterVarIndex = minPositiveIndex(r);
    else
        bound = 0;
    end

end
z0 = cb'*invAb*b;
obasis = sort(sbasis);
obfs = bfs(P,sbasis,size(A,2));
oval = z0;
end

