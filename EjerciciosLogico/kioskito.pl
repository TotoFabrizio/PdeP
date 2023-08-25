%1
turno(dodain,lunes,9,15).
turno(dodain,miercoles,9,15).
turno(dodain,viernes,9,15).
turno(lucas,martes,10,20).
turno(juanC,sabado,18,22).
turno(juanC,domingo,18,22).
turno(juanFds,jueves,10,22).
turno(juanFds,viernes,12,20).
turno(leoC,lunes,14,18).
turno(leoC,miercoles,14,18).
turno(martu,miercoles,23,24).

turno(vale,Dia,Hentrada,Hsalida):-turno(dodain,Dia,Hentrada,Hsalida).
turno(vale,Dia,Hentrada,Hsalida):-turno(juanC,Dia,Hentrada,Hsalida).

%2
quienAtiende(Dia,Hora,Persona):-
    turno(Persona,Dia,Hentrada,Hsalida),
    Hentrada =<Hora,
    Hora =< Hsalida.

%3
gPersona(Persona):-turno(Persona,_,_,_).

foreverAlone(Dia,Hora,Persona):-
    quienAtiende(Dia,Hora,Persona),
    not((quienAtiende(Dia,Hora,Persona2),Persona\=Persona2)).

%4
posAtencion(Dia,PosAten):-
    findall(Persona, turno(Persona,Dia,_,_), Personas),
    combinatoria(Personas,PosAten).

combinatoria([],[]).
combinatoria([Persona|Personas],[Persona|Personas2]):-combinatoria(Personas,Personas2).
combinatoria([_|Personas],PosAten):-combinatoria(Personas,PosAten).

%5
venta(dodain,fehca(10,8),[golosinas(1200),cigarillos([jockey]),golosinas(50)]).
venta(dodain,fehca(12,8),[bebidas(true,8),bebidas(false,1),golosinas(10)]).
venta(martu,fehca(12,8),[golosinas(1000),cigarillos([chesterfield,colorado,parisiennes])]).
venta(lucas,fehca(11,8),[golosinas(600)]).
venta(lucas,fehca(18,8),[bebidas(false,2),cigarillos(derby)]).

vendedoraSuertuda(Persona):-
    vendedora(Persona),
    forall(venta(Persona,_,[V|_]),ventaImportante(V)).

vendedora(Persona):-venta(Persona,_,_).

ventaImportante(golosinas(Importe)):-100 < Importe.
ventaImportante(cigarillos(Marcas)):-
    length(Marcas, Cant),
    Cant > 2.
ventaImportante(bebidas(true,_)).
ventaImportante(bebidas(false,Cant)):-
    Cant > 5.