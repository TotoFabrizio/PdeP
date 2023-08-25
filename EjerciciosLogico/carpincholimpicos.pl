/*
Solución TP de logico
Integrantes:
 - Totofabrizio 3-4
 - LucianoB01 5-6
 - luciagandur 7-8
 - santinocarrizoo04 9-10 
*/

%1
atleta(carpincho(kike,[saltar,correr,noLavar],[100,50,40])).
atleta(carpincho(nacho,[olfatear,saltar,noLavar],[60,80,80])).
atleta(carpincho(alancito,[correr,noLavar],[80,80,70])).
atleta(carpincho(gastoncito,[olfatear,noLavar],[100,30,20])).
atleta(carpincho(sofy,[correr,olfatear,saltar,noLavar],[100,90,100])).
atleta(carpincho(dieguito,[trepar,correr,saltar,noLavar],[99,99,80])).
atleta(carpincho(contu,[olfatear,lavar,contabilidadHogarenia,saltar],[60,70,60])).

gAtleta(Nombre):-atleta(carpincho(Nombre,_,_)).

%2
disciplina(saltoRamita,[correr,saltar],[0,0,0]).
disciplina(armadoDeMadriguera,[],[70,0,0]).
disciplina(huidaDeDepredador,[correr,olfatear],[0,0,80]).
disciplina(preparacionDeEnsalada,[olfatear,saltar,contabilidadHogarenia],[0,0,0]).
disciplina(trepadaDeLigustrina,[saltar,trepar,correr],[0,0,0]).
disciplina(invasionDeCasas,[],[50,90,0]).
disciplina(revolverBasura,[olfatear,correr],[0,0,50]).
disciplina(cebarMate,[olfatear,noLavar],[0,0,0]).

gDisciplina(Disciplina):-disciplina(Disciplina,_,_).

%3
esDificil(Disciplina):-
    disciplina(Disciplina,Habilidades,_),
    length(Habilidades, L),
    L>2.
esDificil(Disciplina):-
    disciplina(Disciplina,_,Atributos),
    sum_list(Atributos, Suma),
    Suma >100.

%4
puedeRealizar(Carpincho,Disciplina):-
    atleta(carpincho(Carpincho,H,A)),
    disciplina(Disciplina,HNes,ANes),
    cumpleHabilidades(H,HNes),
    cumpleAtributos(A,ANes).

cumpleHabilidades(Habilidades,HabilidadesNes):-
    subset(HabilidadesNes, Habilidades).

cumpleAtributos([],[]).
cumpleAtributos([A|As],[B|Bs]):-
    A>=B,
    cumpleAtributos(As,Bs).


%Punto 5

carpinchoExtranio(NombreCarpincho):-
    atleta(carpincho(NombreCarpincho, _, _)),
    disciplina(Disciplina, _, _),
    puedeRealizar(NombreCarpincho, Disciplina), 
    esDificil(Disciplina).

%Punto 6

quienGana(Carpi1, Carpi2, Disciplina, Carpi1):-
    
    atleta(carpincho(Carpi1, _, Atributos1)),
    atleta(carpincho(Carpi2, _, Atributos2)),
    gDisciplina(Disciplina),
    puedeRealizar(Carpi1, Disciplina),
    puedeRealizar(Carpi2, Disciplina),
    sum_list(Atributos1, Cant1),
    sum_list(Atributos2, Cant2),
    Cant1 > Cant2.

quienGana(Carpi1, Carpi2, Disciplina, Carpi2):-
    
    atleta(carpincho(Carpi1, _, Atributos1)),
    atleta(carpincho(Carpi2, _, Atributos2)),
    gDisciplina(Disciplina),
    puedeRealizar(Carpi1, Disciplina),
    puedeRealizar(Carpi2, Disciplina),
    sum_list(Atributos1, Cant1),
    sum_list(Atributos2, Cant2),
    Cant1 < Cant2.
    
quienGana(Carpi1, Carpi2, Disciplina, Carpi1):-
    gAtleta(Carpi1),
    gAtleta(Carpi2),
    gDisciplina(Disciplina),
    puedeRealizar(Carpi1, Disciplina),
    not(puedeRealizar(Carpi2, Disciplina)).

quienGana(Carpi1, Carpi2, Disciplina, Carpi2):-
    gAtleta(Carpi1),
    gAtleta(Carpi2),
    gDisciplina(Disciplina),
    puedeRealizar(Carpi2, Disciplina),
    not(puedeRealizar(Carpi1, Disciplina)).
    

%Punto 7 

% a - Aumenta la fuerza de un carpincho un cuarto de la cantidad de peso que levantaron.

pesasCarpinchas(PesoLevantado, Carpincho, CarpinchoEntrenado):-
    atleta(carpincho(Carpincho,H,[Fuerza,D,V])),
    FuerzaAumentada is Fuerza + (PesoLevantado/4),
    CarpinchoEntrenado = atleta(carpincho(CarpinchoEntrenado,H,[FuerzaAumentada,D,V])).
    
% b - aumenta la destreza en igual cantidad que las ranas atrapadas.

atrapaLaRana(RanasAtrapadas, Carpincho, CarpinchoEntrenado):-
    atleta(carpincho(Carpincho,H,[F,Destreza,V])),
    DestrezaAumentada is Destreza + RanasAtrapadas,
    CarpinchoEntrenado = atleta(carpincho(CarpinchoEntrenado,H,[F,DestrezaAumentada,V])).
    
% c - aumenta la velocidad el doble de los kilómetros recorridos.

cardiopincho(Kilometros, Carpincho, CarpinchoEntrenado):-
    atleta(carpincho(Carpincho,H,[F,D,Velocidad])),
    VelocidadAumentada is Velocidad + Kilometros,
    CarpinchoEntrenado = atleta(carpincho(CarpinchoEntrenado,H,[F,D,VelocidadAumentada])).

% d - aumenta la destreza y la fuerza en la cantidad de minutos que se entrena, pero también baja la velocidad el doble de esa cantidad.

carssfit(Minutos, Carpincho, CarpinchoEntrenado):-
    atleta(carpincho(Carpincho,H,[Fuerza,Destreza,Velocidad])),
    FuerzaAumentada is Fuerza + Minutos,
    DestrezaAumentada is Destreza + Minutos,
    VelocidadDisminuida is Velocidad - Minutos*2,
    CarpinchoEntrenado = atleta(carpincho(CarpinchoEntrenado,H,[FuerzaAumentada,DestrezaAumentada,VelocidadDisminuida])).


%Punto 8 

aCuantosLesGana(Carpincho,Disciplina,Cantidad):-
    atleta(carpincho(Carpincho,_,_)),
    findall(Carpincho2, quienGana(Carpincho, Carpincho2, Disciplina, Carpincho),CarpinchosPerdedores),
    length(CarpinchosPerdedores,Cantidad).


%Punto 9

laRompe(Disciplina, Carpi):-
    gAtleta(Carpi),
    gDisciplina(Disciplina),
    aCuantosLesGana(Carpi, Disciplina, Cant),
    Cant = 6.


%Punto 10 

generarDreamTeam(Diciplinas, [C]):-
    gAtleta(C),
    laRompeMultiple(Diciplinas,C).

generarDreamTeam([D1|[D2|Ds]],[C|Cs]):-
    gAtleta(C),
    gDisciplina(D1),
    gDisciplina(D2),
    laRompe(D1,C),
    not(laRompe(D2,C)),
    generarDreamTeam([D2|Ds],Cs).

laRompeMultiple([D|Ds],C):-
    gAtleta(C),
    gDisciplina(D),
    laRompe(D,C),
    laRompeMultiple(Ds,C).

laRompeMultiple([D],C):-
    gAtleta(C),
    gDisciplina(D),
    laRompe(D,C).