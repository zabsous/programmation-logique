homme("Henri II").
homme("Francois I").
homme("Francois II").
homme("Charles IX").
homme("Henri III").
homme("Victor-Amedee").
homme("Charles Emmanuel").

femme("Madeleine").
femme("Marguerite").
femme("Margot").
femme("Elisabeth").

parent("Francois I", "Henri II").
parent("Francois I", "Madeleine").
parent("Francois I", "Marguerite").

parent("Henri II", "Francois II").
parent("Henri II", "Charles IX").
parent("Henri II", "Henri III").
parent("Henri II", "Margot").

parent("Charles IX", "Elisabeth").

parent("Charles Emmanuel", "Victor-Amedee").

pere(X,Y) :- homme(X),parent(X,Y).
mere(X,Y) :- femme(X),parent(X,Y).

fille(X,Y) :- femme(X),parent(Y,X).

gdparent(X,Y) :- parent(X,Z),parent(Z,Y).

ancetre(X,Y) :- parent(Z,Y);parent(X,Z).

gdpere(X,Y) :- homme(X),gdparent(X,Y).
gdmere(X,Y) :- femme(X),gdparent(X,Y).

frere(X,Y) :- parent(Z,X),parent(Z,Y),homme(X).
soeur(X,Y) :- fille(X,Z),fille(Y,Z).

oncle(X,Y) :- parent(Z,Y),frere(X,Z).
tante(X,Y) :- parent(Z,Y),soeur(X,Z).

cousins_1(X,Y) :- parent(Z,X),oncle(Z,Y);parent(Z,X),tante(Z,Y).
