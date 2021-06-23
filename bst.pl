n(L, X, R).  
n(lf, 1, lf).

%% insert(N, n(lf, X, lf), n(N, X, lf)) :- N < X.
%% insert(N, n(lf, X, lf), n(lf, X, N)) :- N < X.
insert(N, lf, n(lf, N, lf)).
insert(N, n(L, X, R), n(L1, X, R)) :- N < X, 
									  insert(N, L, L1).  
insert(N, n(L, X, R), n(L, X, R1)) :- N > X,
									  insert(N, R, R1).
insert(N, n(L, X, R), n(L, X, R)) :- N =:= X.


%% 

insert(N, lf, n(lf, N, lf)).

insert(N, n(L, C, R), n(P, C, R)) :- N =< C, insert(N, L, P).

insert(N, n(L, C, R), n(L, C, P)) :- N > C, insert(N, R, P).


