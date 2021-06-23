% solution to 8-queens problem: finding an arrangement for 8 queens to be on a chessboard in unique rows/columns/diagonals

queens(R) :- perm([1, 2, 3, 4, 5, 6, 7, 8], R),
			 checkDiagonals(R).

/* checkDiagonals: a list has no queens sharing a diagonal if
none share a diagonal with the first, and the rest don't share any with each other */
checkDiagonals([]).
checkDiagonals([H|T]) :- checkDiagonals(T), walkDiagonals(H, T, H).

/* walkDiagonals checks if queen X shares a diagonal with any queen in the given list.
At the next column, there can't be queens at +/-1 to the original. */
walkDiagonals(_, [], _).
walkDiagonals(X, [H|T], Y) :- X2 is X+1, 
							  Y2 is Y-1,
						   	  X2 =\= H,
						   	  Y2 =\= H,
						      walkDiagonals(X2, T, Y2).

% generalisation for N queens
queensN(N, R) :- numlist(1, N, L), perm(L, R), checkDiagonals(R).