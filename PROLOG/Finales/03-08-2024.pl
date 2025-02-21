
% genero(canción, genero)
% toca(Tema,Banda)

genero(el38, rock).
genero(sisters, reggae).
genero(muchoPorHacer, rock).
genero(tusOjos, reggae).
genero(bastara, reggae).

toca(el38,divididos).
toca(sisters,divididos).
toca(muchoPorHacer,riff).
toca(tusOjos,losCafres).
toca(bastara,losCafres).

rockera(Banda):-
    findall(Tema,(toca(Tema,Banda),genero(Tema,Genero),Genero \= rock), Temas),
    length(Temas,0).

rockeraInversible(Banda):-
    toca(_,Banda),
    findall(Tema,(toca(Tema,Banda),genero(Tema,Genero),Genero \= rock), Temas),
    length(Temas,0).

%% 3) 

rockeraMejor(Banda):-
    toca(_,Banda),
    forall(toca(Tema,Banda),(genero(Tema,Genero), Genero = rock)).

/*

?- rockera(42).
true. 

Da true ya que cuando va buscar los temas no encuentra ninguno, entonces si termina dando una lista vacia  

?- rockera(Banda).
false.

Siempre el predicado no sea inversible con el findall, va a dar false.  

2) No funcionan como deberían las consultas de 42 y la de Banda. La de 42 da true cuando no debería 
ya que es una banda que no existe. Y la de Banda da false ya que no es inversible. Para solucionar ambos problemas
deberiamos agregar el predicado:
toca(_,Banda).
Para asegurarnos que es una banda la que preguntamos si es rockera. 


*/



