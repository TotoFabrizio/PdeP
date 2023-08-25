%parte1 - Sombrero Seleccionador
mago(harry,mestiza,[corajudo,amistoso,orgulloso,inteligente],slytherin).
mago(draco,pura,[inteligente,orgulloso,noCorajudo,noAmistoso],hufflepuff).
mago(hermione,impura,[inteligente,orgulloso,responsable],-).

casa(gryffindor,[coraje]).
casa(slytherin,[orgulloso,inteligente]).
casa(ravenclaw,[inteligente,responsable]).
casa(hufflepuff,[amistoso]).

%1
casaPermiteAMago(_,Casa):-
    casa(Casa,_),
    Casa\=slytherin.
casaPermiteAMago(Mago,Casa):-
    casa(Casa,_),
    Casa=slytherin,
    mago(Mago,Sangre,_,_),
    Sangre\=impura.

%2
tieneCaracterApropiado(Mago,Casa):-
    casa(Casa,Requisitos),
    mago(Mago,_,Caracteristicas,_),
    subset(Requisitos,Caracteristicas).

%3
puedeQuedarEnCasa(Mago,Casa):-
    mago(Mago,_,_,NoCasa),
    casa(Casa,_),
    tieneCaracterApropiado(Mago,Casa),
    casaPermiteAMago(Mago,Casa),
    Casa\=NoCasa.

puedeQuedarEnCasa(hermione,gryffindor).

%4
esAmistoso(Mago):-
    mago(Mago,_,Car1,_),
    subset([amistoso],Car1).

cadenaDeAmistades([Mago1|[Mago2|Magos]]):-
    esAmistoso(Mago1),
    esAmistoso(Mago2),
    casa(Casa,_),
    puedeQuedarEnCasa(Mago1,Casa),
    puedeQuedarEnCasa(Mago2,Casa),
    cadenaDeAmistades([Mago2|Magos]).

cadenaDeAmistades([Mago]):-
    esAmistoso(Mago).

%parte2 La copa de las casas

accionPorAlumn(harry,fueraDeCama).
accionPorAlumn(hermione,tercerPiso).
accionPorAlumn(hermione,secResBibl).
accionPorAlumn(harry,bosque).
accionPorAlumn(harry,tercerPiso).
accionPorAlumn(draco,mazmorras).
accionPorAlumn(ron,ganarAjedrez).
accionPorAlumn(hermione,salvarAmigos).
accionPorAlumn(harry,ganarAVoldemort).

accion(fueraDeCama,-50).
accion(tercerPiso,-75).
accion(secResBibl,-10).
accion(mazmorras,40).
accion(ganarAjedrez,50).
accion(salvarAmigos,50).
accion(ganarAVoldemort,60).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).


%1
%a
hizoAlgunaAccion(Mago):-
    findall(Accion,accionPorAlumn(Mago,Accion),Acciones),
    length(Acciones, Cant),
    Cant>0.
    
magoEsBuenAlumno(Mago):-
    esDe(Mago,_),
    hizoAlgunaAccion(Mago),
    forall((accionPorAlumn(Mago,Accion),accion(Accion,Pun)), Pun>=0).
    
%b
accionRecurrente(Accion):-
    esDe(Mago1,_),
    esDe(Mago2,_),
    accionPorAlumn(Mago1,Accion),
    accionPorAlumn(Mago2,Accion),
    Mago1\=Mago2.

%2
puntajeDeCasa(Casa,PuntajeTot):-
    esDe(_,Casa),
    findall(Puntaje,(esDe(Mago,Casa),accionPorAlumn(Mago,Accion),accion(Accion,Puntaje)),Puntajes),
    sum_list(Puntajes, PuntajeTot).

%3
casaGanadora(Casa):-
    esDe(_,Casa),
    forall(gCasaDis(Casa,Casa2),comparadorPuntajes(Casa,Casa2)).

gCasaDis(Casa,Casa2):-
    esDe(_,Casa2),
    Casa\=Casa2.

comparadorPuntajes(Casa,Casa2):-
    puntajeDeCasa(Casa,Puntaje),
    puntajeDeCasa(Casa2,Puntaje2),
    Puntaje>Puntaje2.

%4
accion(pregunta(Profesor,Dificultad),Dificultad):-Profesor\=snape.
accion(pregunta(snape,Dificultad),Puntaje):-Puntaje is Dificultad/2.

accionPorAlumn(hermione,pregunta(snape,20)).
accionPorAlumn(hermione,pregunta(fliteick,25)).