/*Q1*/

vin1(100, 'Chablis', 1974, 12).
vin1(110, 'Mercurey', 1978, 13).
vin1(120, 'Macon', 1977, 12).

vin2(100, 'Chablis', 1974, 12).
vin2(200, 'Sancerre', 1979, 11).
vin2(210, 'Pouilly', 1980, 12).
vin2(230, 'Pouilly', 1981, 12).

viticultureurs('Nicolas', 'Pouilly', 'Bourgogne').
viticultureurs('Martin', 'Bordeaux', 'Borderlais').

/*Q2*/

/*vin1(N,C,M,12).*/

/*Q3*/

vin3(N,C,M,D) :- vin1(N,C,M,D), vin2(N,C,M,D).

/*Q4.1*/

vin4(N,C,M,D) :- vin1(N,C,M,D); vin2(N,C,M,D).

/*

ou

vin4(N,C,M,D) :- vin1(N,C,M,D).
vin4(N,C,M,D) :- vin2(N,C,M,D).*/

/*Q4.2*/

vin5(110, 'Mercurey', 1978, 13).
vin5(120, 'Macon', 1977, 12).

vin5(N,C,M,D) :- vin1(N,C,M,D) , \+ vin2(N,C,M,D).

/*Q5*/

vignoble(A,B,C,D,E,F,G) :- vin5(A,B,C,D), viticultureurs(E,F,G).

/*Q6*/

vin6(C,M) :- vin5(_N,C,M,_D).

%Q7

vin8(N,C,M,D,P,C,R) :- vin4(N,C,M,D), viticultureurs(P,C,R).

