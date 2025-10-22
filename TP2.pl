liste([]).
liste([_|L]) :- liste(L).

dernier(X, [X | []], []).
dernier(X, [Y | L], [Y | L_]) :- dernier(X,L,L_).

rang_pair([], []).
rang_pair([_], []).
rang_pair([_X,Y | L], [Y | L_]) :- rang_pair(L,L_).

insertion(L, X, [X | L]).
insertion([Y | L], X, [Y | LX])
    :- insertion(L, X, LX).

partage([], [], []).
partage([X], [X], []).
partage([X, Y], [X], [Y]).

partage([X,Y | L], [X | L1], [Y | L2])
    :- partage(L, L1, L2).

suppression([X | L], X, L).
suppression([Y | L1], X, [Y | L2])
    :- suppression(L1, X, L2).


permutation([], []).
permutation([X | L], PX) :- permutation(L, P), insertion(P, X, PX).

palindrome([]).
palindrome([_]).
palindrome([X | L]) :- dernier(X, L, L2), palindrome(L2).

%[a,b,c,d,e] :- [a,c,e] | [b,d]