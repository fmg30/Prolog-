%% node(V, L, R).
%% lf.

%% node(3, node(2, node(4, lf, lf), lf), node(7, node(2, lf, lf), node(5, lf, lf))).

% bfs(T, R).
% breadth-first traversal of T, unifies resulting list with R

% nothing more to traverse, return result
bfs([], []).
% skip any leaves and continue traversing the queue
bfs([lf|X], Result) :- bfs(X, Result).
% put the first value onto the result list
bfs([node(V, L, R)|T], [V|Result]) :-
	append(T, [L, R], Rem),
	bfs(Rem, Result).

bfsCall(node(V, L, R), X) :- bfs([node(V, L, R)], X).


/* DIFF LISTS YEEEEEAH */

% append for diff lists 
app(A-B, B-C, A-C).

% the second clause has a cut to stop backtracking: 
% this is fine because there's only one intended choice for it,
% and otherwise Prolog uses it to construct weird infinite leaf-lists

% nothing more to traverse, return result
diffbfs([]-[], []-[]).
% skip any leaves and continue traversing the queue
diffbfs([lf|X]-X1, Result-Res1) :- diffbfs(X-X1, Result-Res1), !.
% put the first value onto the result list
diffbfs([node(V, L, R)|T]-T1, [V|Result]-Res1) :-
	app(T-T1, [L, R|LR1]-LR1, Rem-Rem1),
	diffbfs(Rem-Rem1, Result-Res1).

diffbfsCall(node(V, L, R), X) :- diffbfs([node(V, L, R)|Y]-Y, X-[]).

% looking at app: we see the following substitutions work
% Rem = T, T1 = [L, R|LR1], Rem1 = LR1

diffbfs2([]-[], []-[]).

diffbfs2([lf|X]-X1, Result-Res1) :- diffbfs2(X-X1, Result-Res1), !.

diffbfs2([node(V, L, R)|T]-[L, R|LR1], [V|Result]-Res1) :-
	app(T-[L, R|LR1], [L, R|LR1]-LR1, T-LR1),
	diffbfs2(T-LR1, Result-Res1).

diffbfsCall2(node(V, L, R), X) :- diffbfs2([node(V, L, R)|Y]-Y, X-[]).

% app is now not needed

diffbfs3([]-[], []-[]).

diffbfs3([lf|X]-X1, Result-Res1) :- diffbfs3(X-X1, Result-Res1), !.

diffbfs3([node(V, L, R)|T]-[L, R|LR1], [V|Result]-Res1) :-
	diffbfs3(T-LR1, Result-Res1).

diffbfsCall3(node(V, L, R), X) :- diffbfs3([node(V, L, R)|Y]-Y, X-[]).

% tidying up some other stuff

% return a regular list since difflists aren't helpful there
diffbfs4([]-[], []).

diffbfs4([lf|X]-X1, Result) :- diffbfs4(X-X1, Result), !.

diffbfs4([node(V, L, R)|T]-[L, R|LR1], [V|Result]) :-
	diffbfs4(T-LR1, Result).

% ditch all the values that weren't being manipulated here
diffbfsCall4(T, X) :- diffbfs4([T|T1]-T1, X).

