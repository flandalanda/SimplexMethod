%Bounded:
A=[-1 1 1 0 0;1 0 0 1 0;0 1 0 0 1];
b=[1;3;2];
c=[1 1 0 0 0]';
sbasis=[3 4 5];
sbfs=[1 3 2];
[bound, obasis, obfs, oval] = phaseTwo(A,b,c,sbasis,sbfs)

%Unbounded
A=[1 -1 1 0;-1 1 0 1];
b=[1 2]';
c=[1 0 0 0]';
sbasis=[3 4];
sbfs=[1 2];
[bound, obasis, obfs, oval] = phaseTwo(A,b,c,sbasis,sbfs)

%Auxiliary problem example
A = [1 3 1; 0 2 1];
b = [4 2]';
c = [1 2 0]';
[nvac, basis, bfs] = phaseOne(A, b, c)

%Degeneracy
A = [-1 1 1 0; 1 0 0 1];
b = [0 2]';
c = [0 1 0 0]';
[status, obasis , obfs, oval] = bothPhases(A, b, c)

%Infeasibility
A = [1 3 1 1 0; 0 2 1 0 1];
b = [4 2]';
c = [1 2 0 0]';
[status, obasis , obfs, oval] = bothPhases(A, b, c)

