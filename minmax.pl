:- debug.


final(((X_E, Y_E), _)):-
    X_E =:= 3, Y_E =:= 3.

final(((X_E, Y_E), (X_U, Y_U))):-
    X_E =:= X_U, Y_E =:= Y_U, !.


eval(((X_E, Y_E), _), +inf):-
    X_E =:= 3, Y_E =:= 3.

eval(((X_E, Y_E), (X_U, Y_U)), -inf):-
    X_E =:= X_U, Y_E =:= Y_U, !.


estimation(((X_E, Y_E), (X_U, Y_U)), VAL):-
    VAL is -((3-X_E) + (3-Y_E)) - (abs(X_E - X_U) + abs(Y_E - Y_U)).


selection_e((VAL0, VP0), (VAL1, VP1), (VAL2, VP2), VAL, VP):-
    VAL is VAL0, append(VP0, "h", VP); 
    VAL is VAL1, append(VP1, "+v", VP); 
    VAL is VAL2, append(VP2, "-v", VP).

selection_u((VAL0, VP0), (VAL1, VP1), (VAL2, VP2), VAL, VP):-
    VAL is VAL0, append(VP0, "h", VP); 
    VAL is VAL1, append(VP1, "up_h", VP); 
    VAL is VAL2, append(VP2, "down_h", VP).
    

e_minMax(_, EtatFinal, VAL, _):- final(EtatFinal), !, eval(EtatFinal, VAL).
e_minMax(0, Etat, VAL, _):- \+ final(Etat), estimation(Etat, VAL).

e_minMax(P, ((X,Y), U), VAL, VP):-
    P > 0, 
    Prof_ is P - 1,
    u_minMax(Prof_, ((X + 1, Y), U), VAL0, VP0),
    u_minMax(Prof_, ((X, Y + 1), U), VAL1, VP1),
    u_minMax(Prof_, ((X, Y - 1), U), VAL2, VP2),

    VAL is max(max(VAL0, VAL1), VAL2),
    selection_e((VAL0, VP0), (VAL1, VP1), (VAL2, VP2), VAL, VP). 

u_minMax(_, EtatFinal, VAL, _):- final(EtatFinal), !, eval(EtatFinal, VAL).
u_minMax(0, Etat, VAL, _):- \+ final(Etat), estimation(Etat, VAL).

u_minMax(P, (E, (X,Y)), VAL, VP):-
    P > 0,
    Prof_ is P - 1,
    e_minMax(Prof_, (E, (X + 1, Y)), VAL0, VP0),
    e_minMax(Prof_, (E, (X + 1, Y + 1)), VAL1, VP1),
    e_minMax(Prof_, (E, (X + 1, Y - 1)), VAL2, VP2),

    VAL is min(min(VAL0, VAL1), VAL2),
    selection_u((VAL0, VP0), (VAL1, VP1), (VAL2, VP2), VAL, VP). 

minmax(P, VAL, VP):-
    e_minMax(P, ((0,0), (-1,2)), VAL, VP).
