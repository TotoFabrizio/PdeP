canta(megurineLuka,cancion(nightFever,4)).
canta(megurineLuka,cancion(foreverYoung,5)).
canta(hatsuneMiku,cancion(tellYourWorld,4)).
canta(gumi,cancion(foreverYoung,4)).
canta(gumi,cancion(tellYourWorld,5)).
canta(seeU,cancion(novemberRain,6)).
canta(seeU,cancion(nightFever,5)).

%1
sabeDosCanciones(Cantante):-
    canta(Cantante,Cancion),
    canta(Cantante,Cancion2),
    Cancion\=Cancion2.

duracionCanciones(Cantante,Total):-
    findall(Largo,canta(Cantante,cancion(_,Largo)),Largos),
    sumlist(Largos, Total).

cantanteNovedoso(Cantante):-
    sabeDosCanciones(Cantante),
    duracionCanciones(Cantante,Total),
    Total < 15.

%2
esAcelerado(Cantante):-
    not((canta(Cantante,cancion(_,Duracion)),Duracion>4)).

%Parte 2
%1
concierto(mikuExpo,eeuu,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalektVisions,eeuu,1000,mediano(9)).
concierto(mikuFest,argentina,100,pequenio(4)).

%2
cantidadDeCanciones(Vocaloid,Cant):-
    findall(Cancion,canta(Vocaloid,Cancion),Canciones),
    length(Canciones,Cant).

cumpleRequisitos(Vocaloid,gigante(CansMin,DurMin)):-
    duracionCanciones(Vocaloid,Total),
    Total>=DurMin,
    cantidadDeCanciones(Vocaloid,Cant),
    Cant>=CansMin.

cumpleRequisitos(Vocaloid,mediano(DurMax)):-
    duracionCanciones(Vocaloid,Total),
    Total < DurMax.

cumpleRequisitos(Vocaloid,pequenio(DurMin)):-
    canta(Vocaloid,cancion(_,Duracion)),
    Duracion > DurMin.

vocaloid(Vocaloid):-
    canta(Vocaloid,_).

puedePartConcierto(Vocaloid,Concierto):-
    vocaloid(Vocaloid),
    Vocaloid\=hatsuneMiku,
    concierto(Concierto,_,_,Requisitos),
    cumpleRequisitos(Vocaloid,Requisitos).

puedePartConcierto(hatsuneMiku,Concierto):-
    concierto(Concierto,_,_,_).

%3
famaConcierto(Cantante,Fama):-
    puedePartConcierto(Cantante,Concierto),
    concierto(Concierto,_,Fama,_).

nivelFama(Vocaloid,FamaTot):-
    vocaloid(Vocaloid),
    findall(Fama,famaConcierto(Vocaloid,Fama),Famas),
    sumlist(Famas, SumFama),
    cantidadDeCanciones(Vocaloid,CantC),
    FamaTot is SumFama * CantC.

masFamoso(Vocaloid):-
    vocaloid(Vocaloid),
    nivelFama(Vocaloid,Fama),
    forall((vocaloid(Vocaloid2),Vocaloid\=Vocaloid2,nivelFama(Vocaloid2,Fama2)), Fama>Fama2).


%4
conoce(megurineLuka,hatsuneMiku).
conoce(megurineLuka,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).

conocido(Vocaloid1,Vocaloid2):-
    conoce(Vocaloid1,Vocaloid2).

conocido(Vocaloid1,Vocaloid2):-
    conoce(Vocaloid1,VocaloidM),
    conocido(VocaloidM,Vocaloid2).

unicoParticipa(Vocaloid,Concierto):-
    puedePartConcierto(Vocaloid,Concierto),
    not((conocido(Vocaloid,OtroVocaloid),puedePartConcierto(OtroVocaloid,Concierto))).