% padreDe(Padre,Hijo).
padreDe(granny, buck).
padreDe(buck, tiara).
padreDe(grandpa, buck).
padreDe(clara, fio).

%Caso Recursivo
ancestro(Ancestro, Cocinerito):-
	padreDe(CocineroPadre, Cocinerito),
	ancestro(Ancestro, CocineroPadre).

%Caso Base
ancestro(Ancestro, Cocinerito):-
	padreDe(Ancestro, Cocinerito).

%esMasExperto(Experto,Novato)
% maestroDe(Maestro,Aprendiz).
maestroDe(granny,grandpa).
maestroDe(grandpa, buck).
maestroDe(buck, clara).
maestroDe(clara, fio).
maestroDe(buck, tiara).


gradoDeExperienciaSobre(Experto, Novato, 1):-
    maestroDe(Experto, Novato).

gradoDeExperienciaSobre(Experto, Novato, Grado):-
    maestroDe(Experto, Aprendiz),
    gradoDeExperienciaSobre(Aprendiz, Novato, GradoAnterior),
    Grado is GradoAnterior + 1.


% ingrediente(Nombre, Cantidad)
ingrediente(azucar, 100).
ingrediente(mayonesa, 20).
ingrediente(sal, 40).
ingrediente(carne, 90).

receta(hamburguesa, [ingrediente(carne, 100),ingrediente(lechuga, 40),ingrediente(tomate, 20), ingrediente(pan, 2)]).

receta(ensalada, [ingrediente(lechuga, 90), ingrediente(tomate, 40), ingrediente(queso, 20)]).

receta(chocotorta, [ingrediente(chocolate, 100), ingrediente(azucar, 280)]).


rapida(Nombre):-
    receta(Nombre, Ingredientes),
    length(Ingredientes, Cantidad),
    Cantidad < 4.
    
postre(Nombre):-
    receta(Nombre, Ingredientes),
    member(ingrediente(azucar, Cantidad), Ingredientes),
    Cantidad >= 250.

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