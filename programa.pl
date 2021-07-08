% maestroDe(Maestro,Aprendiz).
maestroDe(granny, grandpa).
maestroDe(grandpa, buck).
maestroDe(buck, clara).
maestroDe(clara, fio).
maestroDe(buck, tiara).

ancestro(Maestro, Aprendiz):-
    maestroDe(Maestro, Aprendiz).

ancestro(Maestro, Aprendiz):-
    maestroDe(Maestro, EslabonPerdido), 
    ancestro(EslabonPerdido, Aprendiz).






























% %Caso Recursivo
% ancestro(Ancestro, Cocinerito):-
% 	maestroDe(Maestro, Cocinerito),
% 	ancestro(Ancestro, Maestro).

% %Caso Base
% ancestro(Ancestro, Cocinerito):-
% 	maestroDe(Ancestro, Cocinerito).


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

%tiempo(Ingrediente, Minutos).
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

simple(Nombre):-
    receta(Nombre, Ingredientes),
    length(Ingredientes, Cantidad),
    Cantidad < 4.
    
necesitaPreparacion(Nombre):-
    receta(Nombre, Ingredientes),
    member(Ingrediente, Ingredientes),
    tiempo(Ingrediente,Tiempo),
    Tiempo >= 60.


esSanguche([pan,Segundo,pan]]):-
    ingrediente(Segundo).

first([Primero|_], Primero).

ingrediente(Ingrediente):-
    tiempo(Ingrediente,_).

% findall(Selector, Consulta, Lista).

carta(Carta):-
    findall(Nombre, receta(Nombre, _), Carta).

duracionTotal(Receta, DuracionTotal):-
    receta(Receta, Ingredientes),
    findall(Tiempo, (member(Ing, Ingredientes), tiempo(Ing, Tiempo)), Tiempos),
    sumlist(Tiempos, DuracionTotal).
    

duracionTotalV2(Receta, DuracionTotal):-
    receta(Receta, Ings),
    findall(Tiempo, tiempoPorIngrediente(Tiempo,Ings), Tiempos),
    sumlist(Tiempos, DuracionTotal).
tiempoPorIngrediente(Tiempo, Ings):-
    member(Ing, Ings),
    tiempo(Ing, Tiempo).



% Primer version
abundante(Ingrediente):-
    findall(Ingrediente, (ingrediente(Ingrediente, Cantidad), Cantidad >= 100) , IngredientesAbundantes),
    member(Ingrediente, IngredientesAbundantes).

% Segunda version
abundante(Ingrediente):-
    ingrediente(Ingrediente, Cantidad),
    Cantidad >= 100.
    
segundo([_ | [Segundo | _]], Segundo).



instantanea(Nombre):-
    receta(Nombre, Ingredientes),
    findall(Tiempo, (member(Ing, Ingredientes), tiempo(Ing, Tiempo), Tiempo > 0), IngredientesLargos),
    length(IngredientesLargos, 0).

instantanea(Nombre):-
    receta(Nombre, Ingredientes),
    findall(Ing, (member(Ing, Ingredientes), tiempo(Ing, 0)), IngredientesCortos),
    length(IngredientesCortos, Cant),
    length(Ingredientes, Cant).

instantaneaV2(Nombre):-
    receta(Nombre,Ingredientes),
    forall(member(Ing, Ingredientes), tiempo(Ing, 0)).