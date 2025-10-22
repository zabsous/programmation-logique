:- ['LISTE'].

:- ['MATRICE'].

:- set_prolog_flag(answer_write_options,  [ quoted(true), portray(true),  max_depth(100), spacing(next_argument)]).

:- set_prolog_flag(debugger_write_options,  [ quoted(true), portray(true),  max_depth(100), spacing(next_argument)]).

mamatrice(matrice([[j1,j2,j3],[j4,j5,j6],[j7,j8,j9]])).

rotation_matrice(matrice_vide, matrice_vide).

rotation_matrice(LM, CMR) :-
    premiere_ligne(PL, M, LM),
    rotation_matrice(M, MR),
    reverse(PL, RPL),
    premiere_colonne(RPL, MR, CMR).

mon_cube(cube(matrice([[j1,j2,j3],[j4,j5,j6],[j7,j8,j9]]),matrice([[o1,o2,o3],[o4,o5,o6],[o7,o8,o9]]),matrice([[v1,v2,v3],[v4,v5,v6],[v7,v8,v9]]),matrice([[b1,b2,b3],[b4,b5,b6],[b7,b8,b9]]),matrice([[m1,m2,m3],[m4,m5,m6],[m7,m8,m9]]),matrice([[r1,r2,r3],[r4,r5,r6],[r7,r8,r9]]))).

r_c(cube(J, O, V, B, M, R), cube(J_, O_, V_, B_, M_, R)) :-
    rotation_matrice(J, J_),
    premiere_ligne(LB, MB, B),
    reverse(LB, CM_),
    premiere_colonne(CM, MM, M), 
    CM = LO_,
    derniere_ligne(MO, LO, O),
    reverse(LO, CV_),
    derniere_colonne(MV, CV, V), 
    CV = LB_,
    premiere_ligne(LB_, MB, B_),
    premiere_colonne(CM_, MM, M_),
    derniere_ligne(MO, LO_, O_),
    derniere_colonne(MV, CV_, V_).
