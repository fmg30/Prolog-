% various utility functions and list examples
append([], A, A).
append([H|T], A, [H|R]) :- append(T, A, R).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

member2(X, Y) :- append(_, [X|_], Y).

a([]). 
a([H|T]) :- a(T, H). 
a([], _). 
a([H|T], Prev) :- H >= Prev, a(T, H). 

b(X, X) :- a(X).
b(X, Y) :- append(A, [H1, H2|B], X),
		   H1 > H2,
		   append(A, [H2, H1|B], X1),
		   b(X1, Y).

b2(X, X) :- a(X).
b2(X, Y) :- append(A, [H1, H2|B], X),
		   H1 > H2, !,
		   append(A, [H2, H1|B], X1),
		   b2(X1, Y).

% length functions
len([], 0).
len([_|T], N) :- len(T, M), N is M+1.

len2([], Acc, Acc).
len2([_|T], Acc, R) :- B is Acc+1, len2(T, B, R).

len2(List, R) :- len2(List, 0, R).


% B represents A in peano arithmetic
prim(0, z).
prim(A, s(B)) :- A2 is A-1, 
				 A2 >= 0,
				 prim(A2, B).

% if B is zero then the result is just A
plus(A, z, A).
% otherwise, remove an `s` from B and add it to A
plus(A, s(B), C) :- plus(s(A), B, C).

mult(_, z, z).
mult(A, s(B), C) :- mult(A, B, B1), plus(A, B1, C). 

% reversible prim
nat(z).
nat(s(N)) :- nat(N).

prim2(0, z).
prim2(A, s(B)) :- prim2(A2, B), A is A2+1.

prim3(0, z).
prim3(A, s(B)) :- var(A), prim3(A2, B), A is A2+1. 
				  

prim3(A, s(B)) :- integer(A),
				  A2 is A-1, 
				  A2 >= 0, 
				  prim3(A2, B)..

sum([], 0).
sum([H|T], N) :- sum(T, N1), N is H + N1. 

sum2([], Acc, Acc).
sum2([H|T], Acc, N) :- B is Acc + H, sum2(T, B, N).

sum2(List, N) :- sum2(List, 0, N).

ones(0,[]).
ones(N, [H|T]) :- H=1, M is N-1, ones(M, T).

take([H|T], H, T).
take([H|T], R, [H|S]) :- take(T, R, S).

perm([], []).
perm(L, [H|T]) :- take(L, H, R), perm(R, T).

biglist(0,[]).
biglist(N, [H|T]) :- H=1, M is N-1, biglist(M, T).

% generate permutations of input word, test if they are part of the dictionary
anagram(W, R) :- perm(W, R), word(R).

anagramPair(W, X, Y) :- perm(W, Z), append(X, Y, Z), word(X), word(Y).


eval(gnd(A), A).	
eval(mult(A, B), C) :- eval(A, A1), eval(B, B1), C is A1*B1.
eval(plus(A, B), C) :- eval(A, A1), eval(B, B1), C is A1+B1.
