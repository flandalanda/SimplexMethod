function [i] = minPositiveIndex(x)
%UNTITLED3 Summary of this function goes here
%   Regresamos la posición de r
i = 1;

while (i < size(x,2)) && (x(i) <= 0)
    i = i +1;
end
if i == size(x,2)
    i = -1;
end
end

