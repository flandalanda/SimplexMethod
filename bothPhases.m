function [status, obasis , obfs, oval] = bothPhases(A, b, c)
%BOTH PHASES 
% Complete Simplex method implementation
%We initialize variables
oval = 0;
obfs = [];
obasis = [];

%Start with suposition that problem is infeasible
status = -1;

%PHASE ONE
[nvac, sbasis, sbfs] = phaseOne(A, b, c);
if nvac == 1
    %Feasible set non empty
    %Start phase two
    [bound, obasis, obfs, oval] = phaseTwo(A, b, c, sbasis, sbfs);
    if bound == 0
        %Problem is unbounded
        status = 0;
    else
        %Problem is bounded
        status = 1;
    end


end

