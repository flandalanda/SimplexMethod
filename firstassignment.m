%firstassignment.m
%Andrés Cruz y Vera  155899
%Luis Felipe Landa Lizarralde 158228
%Mónica Elizabeth Alba González 160502

%In this file you will find all the functions needed to implement de
%Simplex Method that we have seen in class. We wrote the important
%functions at the begining and in the same order as in the document you 
%gave us, and finally the auxiliary functions.

function [nvac, basis, bfs] = phaseOne(A, b, c)
%PHASEONE
%  First phase of simplex method, we find a basic feasible solution, if 
%  it exists. Here we receive A mxn matrix with m<=n
%  and a rank of m, b column vector with m rows, c column vector with n
%  rows.
%  Output: nvac = 0 if the feasible set is empty; nvac = 1 if the feasible 
%  set is non-empty; basis = a m vector of indices of column vectors
%  for a feasible basis for the problem if the feasible set is
%  non-empty; bfs = a n vector of the basic feasible solution corresponding
%  to this basis.

%We start by asuming non feasibility
nvac = 0;
basis = [];
bfs = [];

%We first convert the problem so that b>=0
for i = 1:size(b,1)
    if b(i) < 0 
        A(i,:) = A(i,:)*(-1);
        b(i) = b(i)*(-1);
    end
end

 %Formulate the auxiliary Linear Program. This means, we add the slack
 %variables to A if needed and then add the corresponding ceros to c and 
 %then build the basis.
 Aprime = [A eye(size(A,1))];
 cPrime = [ zeros(size(A,2),1) ; ones(size(A,1),1)]*(-1);
 sbasisAux = linspace(size(A,2)+1, size(A,2)+size(A,1), size(A,1));
 sbfs = [];
 
 %Run Simplex method to get the auxiliar program
 [bound, obasis, obfs, oval] = phaseTwo(Aprime,b,cPrime,sbasisAux,sbfs);

 %If auxiliary objetive function reaches 0 then it's feasible set is non empty
 %and we obtain a feasible basis by removing auxiliary variables
 if oval == 0
     nvac = 1;
     basis = obasis;
     bfs = obfs(1:size(A,2));
 end
end

function [bound, obasis, obfs, oval] = phaseTwo(A, b, c, sbasis, sbfs)
%PHASETWO
%   This function implements the simplex method starting with a basic 
%   feasible solution. Gets A mxn matrix with m<=n and a rank of m, b 
%   column vector with m rows, c column vector with n rows, sbasis the
%   feasible basis we obtained in the phaseOne. Output: bound = 0 if the
%   problem isn't bounded, 1 if it is bounded; obasis is a m vector of
%   indices that gives an optimal feasible basis; obfs is a n vector which 
%   is the optimal basic feasible solution corresponding to this optimal 
%   basis; oval is the objective value of this optimal basic feasible 
%   solution

%First we obtain the starting tableau of the problem
[Q, P, r, nbasis,cb, invAb] = calcTab(A, b , c, sbasis);

%we calculate the index of the variable that enters to the basis
enterVarIndex = minPositiveIndex(r);
bound = 1;
while enterVarIndex > 0 && bound == 1
    %we calculate the index of the variable that exits the basis
    exitVarIndex = getLeavingVar(P,Q,enterVarIndex);
    if exitVarIndex > 0
        %the problem is bounded, so we change the indices of the basis and
        %we calculate the next tableau
        enterValue = nbasis(enterVarIndex);
        sbasis(exitVarIndex) = enterValue;
        [Q, P, r, nbasis,cb, invAb] = calcTab(A, b, c, sbasis);
        enterVarIndex = minPositiveIndex(r);
    else
        %the problem is unbounded
        bound = 0;
    end

end
%we get the value of the objective function and the basis and the basic
%feasible solution. These values are only valid if the problem is bounded.
z0 = cb'*invAb*b;
obasis = sort(sbasis);
obfs = bfs(P,sbasis,size(A,2));
oval = z0;
end

function [status, obasis , obfs, oval] = bothPhases(A, b, c)
%BOTH PHASES 
% Complete Simplex method implementation. Receives A mxn matrix with m<=n
%  and a rank of m, b column vector with m rows, c column vector with n
%  rows. Output: status = -1 if the problem is infeasible, = 0 if the
%  problem is unbouded, = 1 if the problem is bounded. obasis is a vector 
%  of size m of indices of an optimal feasible basis for the problem 
%  if the feasible set is non-empty and the problem is bounded. obfs is a n
%  vector which is the optimal basic feasible solution corresponding to
%  this optimal basis. oval is the objective value of this optimal basic 
%  feasible solution

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
end

function [Q, P, r, nbasis, cb, invAb] = calcTab(A, b, c, sbasis)
%CALCTAB
%  This function gets the simplex tableau. Input: A mxn matrix, b column
%  vector, c column vector, sbasis row vector.

%First, we get the set of all the indices of the A column.
colSet = linspace(1,size(A,2),size(A,2));
%Calculate the indices of the columns of A that aren't part of the basis,
%then get the indices of c that are basic and the ones that are non-basic.
nbasis = setdiff(colSet,sbasis);
cb = c(sbasis,:);
cn = c(nbasis,:);

%Get the inverse of the submatrix of A with the columns that are basic. 
% Then, the submatrix of A with the columns that are non-basic.
invAb = inv(A(:,sbasis));
An = A(:,nbasis);

%Calculate Q,P and r with the formulas we saw in class.
Q = -invAb*An;

P = invAb*b;

r = cn - (cb'*invAb*An)';
end

function [i] = minPositiveIndex(r)
%MINPOSITIVEINDEX
%   Here we calculate the index that corresponds to the first
%   positive element of r.

i = 1;

while (i < size(r,1)) && (r(i) <= 0)
    i = i +1;
end
if i == size(r,1)
    i = -1;
end
end

function [index] = getLeavingVar(P, Q, enterVarIndex)
%GETLEAVINGVAR
%   We calculate the variable of the basis that most leave in the next step
%   of the Simplex Method. Receives P, Q and the index of the variable
%   that enters the basis regarding the non-basic vector. We return  the 
%   index of the variable that will exit the basis regarding the basic
%   vector.

%We initialize the variables. We first asume that there will be no such
%element.
min = inf;
index = -1; 
%if the index remains -1, then the problem is unbounded
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

function [obasis] = bfs(P, sbasis,n)
%BFS
%   This function returns the basis that gives us the basic feasbile
%   solution. Input: P is a m column vector, sbasis is the basis vector, n
%   is the n corresponding to the number of columns of A.
obasis = zeros(1,n);
for i=1:size(sbasis,2)
    obasis(sbasis(i)) = P(i);
end
end



