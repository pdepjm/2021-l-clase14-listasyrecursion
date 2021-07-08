% maestroDe(Maestro,Aprendiz).
maestroDe(granny, grandpa).
maestroDe(grandpa, buck).
maestroDe(buck, clara).
maestroDe(clara, fio).
maestroDe(buck, tiara).

%Caso Recursivo
ancestro(Ancestro, Cocinerito):-
	maestroDe(Maestro, Cocinerito),
	ancestro(Ancestro, Maestro).

%Caso Base
ancestro(Ancestro, Cocinerito):-
	maestroDe(Ancestro, Cocinerito).


gradoDeExperienciaSobre(Experto, Novato, 1):-
    maestroDe(Experto, Novato).

gradoDeExperienciaSobre(Experto, Novato, Grado):-
    maestroDe(Experto, Aprendiz),
    gradoDeExperienciaSobre(Aprendiz, Novato, GradoAnterior),
    Grado is GradoAnterior + 1.


ancestroV2(Ancestro, Cocinerito):-
    gradoDeExperienciaSobre(Ancestro, Cocinerito,_).



receta(hamburguesa, [pan, carne, pan]).

receta(ensalada, [lechuga, tomate, queso, rucula, couscous]).

receta(chocotorta, [chocolinas, queso, dulceDeLeche, chocolinas]).

tiempo().

simple(Nombre):-
    receta(Nombre, Ingredientes),
    length(Ingredientes, Cantidad),
    Cantidad < 4.
    
necesitaPreparacion(Nombre):-
    receta(Nombre, Ingredientes),
    member(Ingrediente, Ingredientes),
    tiempo(Ingrediente,Tiempo),
    Tiempo >= 60.

% findall(Selector, Consulta, Lista).

carta(Carta):-
    findall(Nombre, receta(Nombre, _), Carta).

cartaComidaRapida(Carta):-
    findall(Nombre, rapida(Nombre), Carta).

cartaPostres(Carta):-
    findall(dulce(Nombre), postre(Nombre), Carta).

gramosTotalesDeUnaReceta(Receta, GramosTotales):-
    receta(Receta, Ingredientes),
    findall(Cantidad, member(ingrediente(_,Cantidad), Ingredientes), ListaGramos),
    sumlist(ListaGramos, GramosTotales).
    

% Primer version
abundante(Ingrediente):-
    findall(Ingrediente, (ingrediente(Ingrediente, Cantidad), Cantidad >= 100) , IngredientesAbundantes),
    member(Ingrediente, IngredientesAbundantes).

% Segunda version
abundante(Ingrediente):-
    ingrediente(Ingrediente, Cantidad),
    Cantidad >= 100.
    
segundo([_ | [Segundo | _]], Segundo).



esSanguche(Ingredientes):-
    first(Ingredientes,pan),
    last(Ingredientes,pan),
    length(Ingredientes,3),
    member(Ingrediente,Ingredientes),
    ingrediente(Ingrediente).

first([Primero|_], Primero).