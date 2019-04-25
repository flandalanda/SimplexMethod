function [Q, P, r, nbasis, cb, invAb] = calcTab(A, b, c, sbasis)
%UNTITLED2 Summary of this function goes here
%   
colSet = linspace(1,size(A,2),size(A,2));
nbasis = setdiff(colSet,sbasis);
cb = c(sbasis,:);
cn = c(nbasis,:);

invAb = inv(A(:,sbasis));
An = A(:,nbasis);

Q = -invAb*An;

P = invAb*b;

r = cn - (cb'*invAb*An)';


end

