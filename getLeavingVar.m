function [index] = getLeavingVar(P, Q, enterVarIndex)
%UNTITLED4 Summary of this function goes here
%   enterVarIndex es el indice de la variable que entra con respecto al
%   vector que tiene las non basics
% Regresamos el indice de la variable que va a salir con respecto al
% vector sbasis

min = inf;
index = -1; 
% si es -1, el problema es unbounded
for i = 1:size(P,1)
    if Q(i,enterVarIndex) < 0
        constraint = -P(i,1)/Q(i,enterVarIndex);
        if min > constraint
            min = constraint;
            index = i;
        end
    end
end
end

