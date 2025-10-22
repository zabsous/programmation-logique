liste_triee([]).
liste_triee([_X]).
liste_triee([X,Y | L]) :- liste_triee([Y|L]), Y>=X.

place(X, [], [X]).
place(X, [X | L], [X,X | L]).
place(X, [Y | L], [X,Y | L]) :-
    Y>X. 
place(X, [Y | L], [Y | LX]) :-
    X>Y, place(X, L, LX). 

dpa(_P, [], [], [], []).
dpa(P, [P | L], PPP, PGP, [P | EP]) :-
    dpa(P, L, PPP, PGP, EP).
    
dpa(P, [X | L], PPP, [X | PGP], EP) :-
    X>P, dpa(P, L, PPP, PGP, EP).

dpa(P, [X | L], [X | PPP], PGP, EP) :-
    P>X, dpa(P, L, PPP, PGP, EP).

fusion([], [], []).

fusion([X | L], [], [X | L]).
fusion([], [X | L], [X | L]).

fusion([X | L1], [X | L2], [X, X | L1L2]) :-
    fusion(L1, L2, L1L2).

fusion([X | L1], [Y | L2], [X, Y | L1L2]) :-
    Y>X, fusion(L1, L2, L1L2).

fusion([X | L1], [Y | L2], [Y, X | L1L2]) :-
    X>Y, fusion(L1, L2, L1L2).

insertion(L, X, [X | L]).
insertion([Y | L], X, [Y | LX])
    :- insertion(L, X, LX).

permutation([], []).
permutation([X | L], PX) :- permutation(L, P), insertion(P, X, PX).

tri_permutation(L, T) :-
    permutation(L, T),
    liste_triee(T).

tri_insertion([], []).
tri_insertion([X | L], TX) :-
    tri_insertion(L, T),
    place(X, T, TX).
    
partage([], [], []).
partage([X], [X], []).
partage([X, Y], [X], [Y]).

partage([X,Y | L], [X | L1], [Y | L2])
    :- partage(L, L1, L2).

tri_fusion([], []).
tri_fusion([X], [X]).
tri_fusion(L, T) :-
    partage(L, L1, L2),
    tri_fusion(L1, T1),
    tri_fusion(L2, T2),
    fusion(T1, T2, T). 

tri_rapide([], []).
tri_rapide([X], [X]).
tri_rapide([P | L], T) :- 
    dpa(P, L, PPP, PGP, _EP),
    tri_rapide(PPP, PPPT),
    tri_rapide(PGP, PGPT),
    fusion(PPPT, [P | PGPT], T).
