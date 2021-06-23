colour(red).
colour(blue).
colour(yellow).
colour(green).

diff(X, Y) :- colour(X), colour(Y), X \= Y.

colourDiff(Map) :- diff(C1, C5),
diff(C1, C2),
diff(C1, C4),
diff(C1, C6),
diff(C2, C3),
diff(C2, C7),
diff(C2, C4),
diff(C3, C7),
diff(C3, C8),
diff(C7, C8),
diff(C6, C7),
diff(C6, C8),
diff(C5, C6),
diff(C4, C6),
diff(C4, C7),
print(C1), nl,
print(C2), nl,
print(C3), nl,
print(C4), nl,
print(C5), nl,
print(C6), nl,
print(C7), nl,
print(C8), nl.

solve(Map) :- colourDiff(Map).