% camino(GymA, GymB, DuracionViajeMin, CantidadPokeparadas).
camino(plaza_de_mayo, congreso, 9, 15).
camino(plaza_de_mayo, teatro_colon, 11, 15).
camino(plaza_de_mayo, abasto_shopping, 19, 28).
camino(plaza_de_mayo, cementerio_recoleta, 26, 36).
camino(congreso, teatro_colon, 10, 11).
camino(congreso, cementerio_recoleta, 15, 16).
camino(teatro_colon, abasto_shopping, 13, 20).
camino(teatro_colon, cementerio_recoleta, 17, 24).
camino(abasto_shopping, cementerio_recoleta, 27, 32).

tramo(GymA, GymB, DuracionViajeMin, CantidadPokeparadas):- camino(GymA, GymB, DuracionViajeMin, CantidadPokeparadas).
tramo(GymB, GymA, DuracionViajeMin, CantidadPokeparadas):- camino(GymA, GymB, DuracionViajeMin, CantidadPokeparadas).

gGym(Gym):-tramo(Gym,_,_,_).

tour(TiempoMax,[GymA,GymB],Paradas):-
    tramo(GymA,GymB,Tiempo,Paradas),
    Tiempo =< TiempoMax.

tour(TiempoMax,[GymA|[GymB|Gyms]],ParadasTot):-
    tramo(GymA,GymB,Tiempo,Paradas),
    Tiempo =< TiempoMax,
    TiempoMax2 is TiempoMax - Tiempo,
    tour(TiempoMax2,[GymB|Gyms],Paradas2),
    ParadasTot is Paradas2 + Paradas.

recorrido(Recorrido):-
    findall(Gym,gGym(Gym),Gyms),
    list_to_set(Gyms, GymsF),
    permutation(GymsF, Recorrido).
    
mejorTour(TiempoMax,Tour):-
    recorrido(Tour),
    tour(TiempoMax,Tour,Paradas),
    recorrido(Tour2),
    not(tour(TiempoMax,Tour2,Paradas)).

color(abasto_shopping,rojo).
color(congreso,azul).
color(cementerio_recoleta,amarillo).
color(plaza_de_mayo,amarillo).
color(teatro_colon,amarillo).

estaSitiado(Gym):-
    gGym(Gym),
    color(Gym,ColorA),
    tramo(Gym,GymB,_,_),
    color(GymB,ColorB),
    ColorA \= ColorB,
    forall(tramo(Gym,GymV,_,_),color(GymV,ColorB)).