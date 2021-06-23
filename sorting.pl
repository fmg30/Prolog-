% helpful stuff
take([H|T], H, T).
take([H|T], R, [H|S]) :- take(T, R, S).

append([], L, L).
append([X|T], L, [X|R]) :- append(T, L, R).

/* SELECTION SORT */
% Finding the minimum element from the list and recursively sorting the remainder.
min([X], X).
min([H|T], H) :- min(T, X), H=<X.
min([H|T], X) :- min(T, X), X<H.

% empty list is sorted
selsort([], []).
% find Y, the smallest element in X, add it to the head of the result list, remove it from X
selsort(X, [Y|T]) :- 
	min(X, Y), 
	take(X, Y, R),
	selsort(R, T). 

/* QUICKSORT */

% partition [H|T] into Left and Right lists based on the Pivot value
partition([], [], [], _). 
partition([H|T], [H|Left], Right, Pivot) :- H =< Pivot, partition(T, Left, Right, Pivot).
partition([H|T], Left, [H|Right], Pivot) :- H > Pivot, partition(T, Left, Right, Pivot).

% empty list is sorted
quicksort([], []).
quicksort([H|T], X) :- partition(T, Left, Right, H), % partition around pivot
					   quicksort(Left, QLeft),		 % recurse
					   quicksort(Right, QRight),
					   append(QLeft, [H|QRight], X). % rebuild


% quicksort with a three-way pivot (<, =, >)

partition2([], [], [], [], _).
partition2([H|T], [H|Left], Middle, Right, Pivot) :- 
	H < Pivot, partition2(T, Left, Middle, Right, Pivot).
partition2([H|T], Left, [H|Middle], Right, Pivot) :- 
	H = Pivot, partition2(T, Left, Middle, Right, Pivot).
partition2([H|T], Left, Middle, [H|Right], Pivot) :- 
	H > Pivot, partition2(T, Left, Middle, Right, Pivot).

% same as above, but the append has to be done in two steps, 
% and we don't have to sort the middle list since it's just one element repeated
quicksort2([], []).
quicksort2([H|T], X) :- partition2(T, Left, Middle, Right, H),
					    quicksort2(Left, QLeft),
					    quicksort2(Right, QRight),
					    append(QLeft, [H|Middle], QLeftMid),
					    append(QLeftMid, QRight, X).

% quicksort using diff lists woooooo
% diff lists: A-B: [....|B]-B


%% % empty diff list
%% diffsort([], []).
%% diffsort([A]-A, [A]-A).
%% diffsort([H|T], X) :- partition(T, [Left|L1]-L1, [Right|R1]-R1, H),
%% 					  diffsort(Left, [QLeft|QL]-QL),		 
%% 					  diffsort(Right,[QRight|QR]-QR),
%% 					  ([QLeft|H]-H, [H|QRight]-QRight, [QRight|QR]-QR). 

diffsortwrap(L, X) :- diffsort(L, X-[]).

diffsort([], X-X).

% partition etc. happens as normal

% but when returning the recursive value, it's a diff list, and so we can slot the pivot
% element into the tail part

% then for the RHS recursion, we link the tail of the pivot element to Y

% so we have X-Y = X -> [H|Z] -> Y,  
diffsort([H|T], X-Y) :- partition(T, Left, Right, H), 
					    diffsort(Left, X-[H|Z]),		 
					    diffsort(Right,Z-Y). 

/* MERGE SORT -------------------- */

len([], Acc, Acc).
len([_|T], Acc, R) :- B is Acc+1, len(T, B, R).

mergesort([], []) :- !.
mergesort([X], [X]) :- !.
% split the list in half, sort each recursively, merge
% includes testing the length of the list: otherwise backtracking never ends
mergesort(L, X) :- len(L, 0, Length), Length>1,
				   split(L, Left, Right),
				   mergesort(Left, LeftSorted),
				   mergesort(Right, RightSorted),
				   merge(LeftSorted, RightSorted, X).					

% pick the smallest of the head of each list, recurse
merge([], R, R).
merge(L, [], L).
merge([H1|L], [H2|R], [H1|X]) :- H1 =< H2, merge(L, [H2|R], X).				   
merge([H1|L], [H2|R], [H2|X]) :- H1 > H2, merge([H1|L], R, X).				   

% split X into L and R sublists
split([], [], []).
split([X], [X], []).
split([H1, H2|X], [H1|L], [H2|R]) :- split(X, L, R).

