%abvide: AB(E)
%ab: E x AB(E) x AB(E)

est_vide(abvide).
racine(ab(R,_G,_D), R).
gauche(ab(_R,G,_D), G).
droite(ab(_R,_G,D), D).

ajout(X, abvide(_), ab(X, abvide(_Y), abvide(_Z))).

ajout(X, ab(X, G, D), ab(X, G, D)).

ajout(X,ab(R, G, D), ab(R, G, DX)) :- 
    X>R, ajout(X, D, DX).

ajout(X,ab(R, G, D), ab(R, GX, D)) :- 
    X<R, ajout(X, G, GX).

ajoutliste([], A, A).

ajoutliste([X | L], A, Res) :-
    ajout(X, A, AX), ajoutliste(L, AX, Res).

appartient(X, ab(X, _G, _D)).
appartient(X, ab(R, G, _D)) :-
    X<R,
    appartient(X, G).

appartient(X, ab(R, _G, D)) :-
    X>R,
    appartient(X, D).

arbre(A) :- ajoutliste([6,2,8,1,7], abvide, A).

nbnoeuds(abvide,0).
nbnoeuds(ab(_, abvide, abvide), 1).
nbnoeuds(ab(_, G, D), N) :-
    nbnoeuds(G, NG),
    nbnoeuds(D, ND),
    N is NG + ND + 1.

hauteur(abvide, 0).
hauteur(ab(_, abvide, abvide), 1).

hauteur(ab(_, G, D), N) :-
    hauteur(G, HG),
    hauteur(D, HD),
    N is max(HG, HD) + 1.

profondeur(ab(X, _, _), X, 0).

profondeur(ab(R, G, _D), X, P) :-
    X<R,
    profondeur(G, X, PG),
    P is PG + 1.

profondeur(ab(R, _G, D), X, P) :-
    X>R,
    profondeur(D, X, PD),
    P is PD + 1.

p_prefixe(abvide, []).
p_prefixe(ab(R, abvide, abvide), [R]).
p_prefixe(ab(X, G, D), L) :-
    p_prefixe(G, LG),
    p_prefixe(D, LD),
    append([X], LG, XLG),
    append(XLG, LD, L).

p_infixe(abvide, []).
p_infixe(ab(R, abvide, abvide), [R]).
p_infixe(ab(X, G, D), L) :-
    p_infixe(G, LG),
    p_infixe(D, LD),
    append(LG, [X], LGX),
    append(LGX, LD, L).

p_postfixe(abvide, []).
p_postfixe(ab(R, abvide, abvide), [R]).
p_postfixe(ab(X, G, D), L) :-
    p_postfixe(G, LG),
    p_postfixe(D, LD),
    append(LG, LD, LGLD),
    append(LGLD, [X], L).

plus_grand(ab(R, _G, abvide), R).
plus_grand(ab(_, _G, D), X) :-
    D = ab(_, _, _),
    plus_grand(D, X).

supprimer(ab(Y, G, D), X, ab(Y, G_, D)) :-
    X<Y,
    supprimer(G, X, G_).

supprimer(ab(Y, G, D), X, ab(Y, G, D_)) :-
    X>Y,
    supprimer(D, X, D_).

supprimer(ab(X, abvide, D), X, D).

supprimer(ab(X, G, D), X, ab(Y, G_, D)) :-
    G=ab(_,_,_),
    plus_grand(G, Y),
    supprimer(Y, G, G_).
    