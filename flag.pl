% Dutch national flag solution
% Takes a list of red/white/blue elements and rearranges them into a dutch flag.

flag(In, Out) :- perm(In, Out),
				 checkColours(Out).

% check that at least one blue, red, white element exists 
allColoursPresent(L) :- member(blue, L), member(red, L), member(white, L).

% checkRed: true if H=red & checkRed(Tail), or checkWhite(List) 
checkRed([red|T], _) :- checkRed(T, redSeen).
% use second argument as a flag to check you've seen at least one red
checkRed(L, redSeen) :- checkWhite(L, noWhiteSeen).

% checkWhite: true if H=white & checkWhite(Tail), or checkBlue(List)
checkWhite([white|T], _) :- checkWhite(T, whiteSeen).
% second argument checks you've seen at least one white
checkWhite(L, whiteSeen) :- checkBlue(L).

% checkBlue: true if H=blue & checkBlue(Tail)
checkBlue([blue]).
checkBlue([blue|T]) :- checkBlue(T).

checkColours(L) :- checkRed(L, noRedSeen).


/*--------------------------------------------------------------------*/

% Dutch flag take 2
fl(X, F) :- scanColours(X, R, W, B), append(R, W, RW), append(RW, B, F).

scanColours([], [], [], []).
scanColours([red|X], [red|R], W, B) :- 	scanColours(X, R, W, B).
scanColours([white|X], R, [white|W], B) :- 	scanColours(X, R, W, B).
scanColours([blue|X], R, W, [blue|B]) :- 	scanColours(X, R, W, B).

scanColoursDiff([], R-R, W-W, B-B).
scanColoursDiff([red|X], [red|R]-R1, W, B) :- scanColoursDiff(X, R-R1, W, B).
scanColoursDiff([white|X], R, [white|W]-W1, B) :- scanColoursDiff(X, R, W-W1, B).
scanColoursDiff([blue|X], R, W, [blue|B]-B1) :- scanColoursDiff(X, R, W, B-B1).

fldiff(X, R) :- scanColoursDiff(X, R-W, W-B, B-[]).

% F is RW, RW1 is B, B1 is F1
% W1 is B


%% fldiff(X, F) :- scanColoursDiff(X, R-R1, W-W1, B-B1), 
%% 	app4(R-R1, W-W1, RW-RW1), 
%% 	app4(RW-RW1, B-B1, F-F1).
% RW = R, R1 = W, RW1=W 

% Dutch flag with diff lists
flDiff1(X-X1, F-F1) :- scanColoursDiff(X-X1, R-R1, W-W1, B-B1),
					  append(R-R1, W-W1, RW-RW1),
					  append(RW-RW1, B-B1, F-F1).

%% R1 is W, R is RW, RW1 is W1		
%% W1 is B, R is F, , B1 is F1
flDiff2(X, F-F1) :- scanColoursDiff(X, F-W, W-B, B-F1),
					  append(F-W, W-B, F-B),
					  append(F-B, B-F1, F-F1).

% now our append goals aren't actually changing anything, so remove them
flDiff3(X, F-F1) :- scanColoursDiff(X, F-W, W-B, B-F1).