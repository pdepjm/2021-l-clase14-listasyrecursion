% maestroDe(Maestro,Aprendiz).
maestroDe(granny, grandpa).
maestroDe(grandpa, buck).
maestroDe(buck, clara).
maestroDe(clara, fio).
maestroDe(buck, tiara).

ancestro(Maestro, Aprendiz):-
    maestroDe(Maestro, Aprendiz).

ancestro(Maestro, Aprendiz):-
    maestroDe(Maestro, OtroAprendiz), 
    ancestro(OtroAprendiz, Aprendiz).

gradoDeExperienciaSobre(Maestro, Aprendiz, 1):-
    maestroDe(Maestro, Aprendiz).

gradoDeExperienciaSobre(Maestro, Aprendiz, GradoExperiencia):-
    maestroDe(Maestro, OtroAprendiz),
    gradoDeExperienciaSobre(OtroAprendiz, Aprendiz, GradoAnterior),
    is(GradoExperiencia, GradoAnterior + 1).
    
    
    %is(GradoExperiencia, GradoExperiencia + 1). % esto está mal, el is es una pregunta, no una asignación

ancestroV2(Maestro, Aprendiz):-
    gradoDeExperienciaSobre(Maestro, Aprendiz, _).


% Recetas:
% Una hamburguesa tiene pan, carne, y luego pan.
% La ensalada tiene lechuga, tomate, queso, rucula, couscous.
% La chocotorta tiene chocolinas, queso, dulceDeLeche, chocolinas.

/*
%receta(Nombre, UnIngrediente?)
receta(hamburguesa, pan).
receta(hamburguesa, carne).
receta(hamburguesa, pan). % esta verdad yo ya la dije!!
*/



% Tiempos:
% Para cocinar la carne hacen falta 20 minutos. 
% Para cocinar el cous cous necesitamos 10 minutos. 
% Para hacer el pan, 180 minutos.  
% Chocolinas, queso, dulce de leche, tomate, lechuga, rúcula tienen 0 minutos de preparación.

% tiempo(Ingrediente,Tiempo).
tiempo(carne, 20).
tiempo(couscous, 10).
tiempo(pan, 180).
tiempo(chocolinas, 0).
tiempo(queso, 0).
tiempo(dulceDeLeche, 0).
tiempo(rucula, 0).
tiempo(tomate, 0).
tiempo(lechuga, 0).
tiempo(tomate, 0).

%receta (Nombre, Ingredientessssss) <- plural porque es una lista
receta(hamburguesa, [pan, carne, pan]).
receta(ensalada, [lechuga, tomate, queso, rucula, couscous]).
receta(chocotorta, [chocolinas, queso, dulceDeLeche, chocolinas]).
receta(universo, [hidrogeno, 42, empatia]).

% Queremos saber si una receta es simple/1. 
% Esto cumple cuando tiene menos de 4 ingredientes.

simple(Nombre):-
    receta(Nombre, Ingredientes),
    length(Ingredientes, Cantidad),
    Cantidad < 4.

% Si una receta  necesitaPreparacion/1 , que es cuando para cocinar alguno de los ingredientes se necesitan más de 60 minutos.

necesitaPreparacion(Nombre):-
    receta(Nombre, Ingredientes),
    member(Ing, Ingredientes),
    tiempo(Ing, Tiempo),
    Tiempo > 60.

% Quiero saber si una lista de ingredientes esSanguche/1. Una lista de ingredientes es sánguche cuando tiene 3 ingredientes y tiene como primer y último elemento un pan. 

esSanguche([pan, Segundo, pan]):-
    ingrediente(Segundo).


esSangucheVersionFea(Ingredientes):-
    length(Ingredientes, 3),
    first(Ingredientes, pan),
    last(Ingredientes, pan),
    nth1(2, Segundo, Ingredientes),
    ingrediente(Segundo).

ingrediente(Ingrediente):-
    tiempo(Ingrediente, _).

first([Cabeza | _], Cabeza).

% Queremos conocer la carta, que es la lista de platos disponibles.
carta(Carta):-
    findall(Nombre, receta(Nombre, _), Carta).

% Queremos saber si alguien tieneUnaEscuela/1, que es cuando tiene más de 10 discípulos.
tieneUnaEscuela(Maestro):-
    maestroDe(Maestro, _),
    findall(Discipulo, maestroDe(Maestro, Discipulo), Discipulos),
    length(Discipulos, Cantidad),
    Cantidad > 10.
    
% Queremos saber la duración total de una receta. duracionTotal/2 que estará dada por la sumatoria de los tiempos de todos los ingredientes.
duracionTotal(Nombre, DuracionTotal):-
    receta(Nombre, Ingredientes),
    % Estrategia: "agrego" (junto) los tiempos, y los sumo
    findall(Tiempo, (member(Ing, Ingredientes), tiempo(Ing, Tiempo)), Duraciones),
    sum_list(Duraciones, DuracionTotal).
    
