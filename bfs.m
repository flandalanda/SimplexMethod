function [obasis] = bfs(P, sbasis,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
obasis = zeros(1,n);
for i=1:size(sbasis,2)
    obasis(sbasis(i)) = P(i);
end
end

