herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

%1
posee(egon,aspiradora(200)).
posee(egon,trapeador).
posee(peter,trapeador).
posee(winston,varitaDeNeutrones).


%2
tieneHerramienta(Integrante,Herramienta):-
    posee(Integrante,Herramienta).

tieneHerramienta(Integrante,aspiradora(Potencia)):-
    posee(Integrante,aspiradora(Potencia2)),
    Potencia2>=Potencia.

%3
puedeTarea(Integrante,Tarea):-
    posee(Integrante,_),
    tieneHerramienta(Integrante,varitaDeNeutrones),
    herramientasRequeridas(Tarea,_).

puedeTarea(Integrante,Tarea):-
    posee(Integrante,_),
    not(tieneHerramienta(Integrante,varitaDeNeutrones)),
    herramientasRequeridas(Tarea,Herramientas),
    tieneHerramientas(Integrante,Herramientas).

tieneHerramientas(Integrante,[Herramienta|Hs]):-
    tieneHerramienta(Integrante,Herramienta),
    tieneHerramientas(Integrante,Hs).

tieneHerramientas(Integrante,[Herramienta]):-
    tieneHerramienta(Integrante,Herramienta).

%4
cobrarPorPedido(Cliente,Costo):-
    findall(Precio,(tareaPedida(Tarea,Cliente,_),precio(Tarea,Precio)),Precios),
    findall(MetrosTarea,tareaPedida(_,Cliente,MetrosTarea),MetrosTareas),
    costosTotal(Precios,MetrosTareas,Costo).

costosTotal([P|Ps],[M|Ms],Costo):-
    costosTotal(Ps,Ms,CostoAnt),
    Costo is CostoAnt+(P*M).

costosTotal([P],[M],Costo):-
    Costo is P*M.

%5
esCompleja(Tarea):-
    herramientasRequeridas(Tarea,Herramientas),
    length(Herramientas, Cant),
    Cant>2.

esCompleja(limpiarTecho).

puedeRealizarPedido(Integrante,Cliente):-
    posee(Integrante,_),
    tareaPedida(_,Cliente,_),
    forall(tareaPedida(Tarea,Cliente,_), puedeTarea(Integrante,Tarea)).

noHayCompleja(Cliente):-
    forall(tareaPedida(Tarea,Cliente,_),not(esCompleja(Tarea))).

aceptaPedido(Integrante,Cliente):-
    puedeRealizarPedido(Integrante,Cliente),
    estaDispuesto(Integrante,Cliente).

estaDispuesto(ray,Cliente):-
    not(tareaPedida(limpiarTecho,Cliente,_)).

estaDispuesto(winston,Cliente):-
    cobrarPorPedido(Cliente,Costo),
    Costo > 500.

estaDispuesto(egon,Cliente):-
    noHayCompleja(Cliente).

estaDispuesto(peter,_).