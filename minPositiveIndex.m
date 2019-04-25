function [i] = minPositiveIndex(r)
%UNTITLED3 Summary of this function goes here
%   Regresamos la posición de r
i = 1;

while (i < size(r,1)) && (r(i) <= 0)
    i = i +1;
end
if i == size(r,1)
    i = -1;
end
end

