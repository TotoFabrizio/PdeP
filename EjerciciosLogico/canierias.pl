/*1*/

precio([p|ps],precioT):-
    precio(p,precio1),
    precio(ps,precio2),
    precioT is precio1 + precio2.

precio([],0).

precio(codo(_),5).
precio(canio(_,Longitud),Precio):-
    Precio is Longitud * 3.
precio(canilla(triangular,_,_),20).
precio(canilla(Tipo,_,Ancho),12):-
    Ancho =< 5,
    Tipo \= triangular.
precio(canilla(Tipo,_,Ancho),15):-
    Ancho > 5,
    Tipo \= triangular.

/*2 modificado en el punto 5 */
coloresEnchufables(C,C).
coloresEnchufables(rojo,negro).
coloresEnchufables(azul,rojo).

puedoEnchufar(P1,P2):-
    color(P1,C1),
    color(P2,C2),
    P1 \= extremo(derecho,_),
    P2 \= extremo(izquierdo,_),
    coloresEnchufables(C1,C2).
puedoEnchufar(C,P2):-
    last(C, P1),
    puedoEnchufar(P1,P2).%3
puedoEnchufar(P1,[P2|_]):-
    puedoEnchufar(P1,P2).%3

color(codo(C),C).
color(canio(C,_),C).
color(canilla(_,C,_),C).
color(extremo(_,C),C).%5

/*4 modificado en el punto 6*/

canieriaBienArmada([Pieza]):-color(Pieza,_).
canieriaBienArmada([Canieria]):-canieriaBienArmada(Canieria).
canieriaBienArmada([Pieza|Piezas]):-
    puedoEnchufar(Pieza,Piezas),
    canieriaBienArmada([Pieza]),
    canieriaBienArmada(Piezas).


%7
canieriaLegal(Piezas,Canieria):-
    permutation(Piezas, Canieria),
    canieriaBienArmada(Canieria).