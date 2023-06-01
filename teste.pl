lista([1,2,3,4]).

addAfter([H|T],Destino,Valor,NewList) :- (Destino=H) -> NewList=[H,Valor|T] ; (addAfter(T,Destino,Valor,NewList2), NewList=[H|NewList2]).

arvore([[1,[4,[5,6]]],[2,3]]).


addArvore2(Arvore,Destino,Valor,NewList) :- (is_list(Arvore)) -> (Arvore=[H,T],addArvore2(T,Destino,Valor,NewList2) , addArvore2(H,Destino,Valor,NewList3), NewList=[NewList3,NewList2]); 
                                                ((Arvore=Destino) -> (NewList=[Valor,Destino],!); NewList=Arvore).

addArvore(Arvore,Destino,Valor,NewList) :- addArvore2(Arvore,Destino,Valor,NewList), write(NewList).
% ['teste.pl'],arvore(L), addArvore(L,3,7,N). 


pokemons([['Eh vermelho?', ['Scizor', 'Charmander']], ['Eh do tipo agua?', ['Gyarados', 'Rhydon']]]).


addArvore3(Arvore,Destino,Pergunta,NovoValor,S_N,NovaLista) :- (is_list(Arvore)) -> (Arvore=[H,T],addArvore3(T,Destino,Pergunta,NovoValor,S_N,NovaLista2) , addArvore3(H,Destino,Pergunta,NovoValor,S_N,NovaLista3), NovaLista=[NovaLista3,NovaLista2]); 
                                                ((Arvore=Destino) -> ((S_N='n') -> NovaLista=[Pergunta,[Destino,NovoValor]]; NovaLista=[Pergunta,[NovoValor,Destino]]),!; NovaLista=Arvore).

/*
addPokemons(Pokemons,Pergunta,NovoPokemon,Resposta,QualPokemon,NovaLista):
    if is_list(Pokemons):
        [Pergunta, [Sim, Nao]] = Pokemons
        if is_list(Sim):
            addPokemons(Sim,Pergunta,NovoPokemon,Resposta,QualPokemon,SimArvore)

        if is_list(Nao):
            addPokemons(Nao,Pergunta,NovoPokemon,Resposta,QualPokemon,NaoArvore)

        NovaLista = [Pergunta, [SimArvore, NaoArvore]]
    else:
        if Pokemons == QualPokemon:
            if Resposta == 's':
                NovaLista = [Pergunta, [NovoPokemon, Pokemons]]
            else:
                NovaLista = [Pergunta, [Pokemons, NovoPokemon]]
        else:
            NovaLista = Pokemons
            */
            
addPokemons(Pokemons,Pergunta,NovoPokemon,Resposta,QualPokemon,NovaLista) :- 
    (is_list(Pokemons)) -> 
         (Pokemons=[Pergunta,[Sim,Nao]],write("Aqui"), addPokemons(Sim,Pergunta,NovoPokemon,Resposta,QualPokemon,NovaLista2), addPokemons(Nao,Pergunta,NovoPokemon,Resposta,QualPokemon,NovaLista3), NovaLista=[Pergunta,[NovaLista2,NovaLista3]]); 
         ((Pokemons=QualPokemon) -> 
            ((Resposta='s') -> 
                NovaLista=[Pergunta,[NovoPokemon,Pokemons]];
                NovaLista=[Pergunta,[Pokemons,NovoPokemon]]);
            NovaLista=Pokemons).

runAddPokemons :- pokemons(Pokemons), addPokemons(Pokemons,'Eh um Dragão?','Charizard','s','Charmander',NovaLista), write(NovaLista).

teste(A) :- is_list(A).