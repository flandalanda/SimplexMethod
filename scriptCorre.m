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