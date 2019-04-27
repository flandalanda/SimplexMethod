function [nvac, basis, bfs] = phaseOne(A, b, c)
%PHASEONE
%  First phase of simplex method


%We start by asuming non feasibility
nvac = 0;
basis = [];
bfs = [];


%Verify that Ax=b has non-empty solution set
%if norm(A*(A\b) - b, inf) == 0

%We first convert the problem so that b>=0
for i = 1:size(b,1)
    if b(i) < 0 
        A(i,:) = A(i,:)*(-1);
        b(i) = b(i)*(-1);
    end
end

 %Formulate the auxiliary Linear Program
 Aprime = [A eye(size(A,1))];
 cPrime = [ zeros(size(A,2),1) ; ones(size(A,1),1)]*(-1);
 sbasisAux = linspace(size(A,2)+1, size(A,2)+size(A,1), size(A,1));
 sbfs = [];
 %Run Simplex method for aux program
 [bound, obasis, obfs, oval] = phaseTwo(Aprime,b,cPrime,sbasisAux,sbfs);

 %If auxiliary objetive function reaches 0 then it's feasible set is non empty
 %and we obtain a feasible basis by removing auxiliary variables
 if oval == 0
     nvac = 1;
     basis = obasis;
     bfs = obfs(1:size(A,2));
 end
%end

