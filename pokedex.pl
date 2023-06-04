:- dynamic lista/1.
% lista(['Eh laranja?', ['Charmander', 'Rhydon']]).
% lista(['Eh laranja?', [['Tem nove rabos?', [['Eh uma evolucao?', ['Ninetales', 'Vulpix']], 'Charmander']], ['Eh do tipo agua?', ['Gyarados', 'Rhydon']]]]).

pegaPrim([Head|_], Head). % Retorna o primeiro elemento da lista
pegaSeg([_|[Tail|_]],Tail). % Retorna o segundo elemento da lista

pegaProxPrim(Lista,Prim) :- pegaSeg(Lista,SubLista), pegaPrim(SubLista,Prim).
pegaProxSeg(Lista,Seg) :- pegaSeg(Lista,SubLista), pegaSeg(SubLista,Seg).

addPokemon(Arvore,Destino,Pergunta,NovoValor,S_N,NovaLista) :- (is_list(Arvore)) -> (Arvore=[H,T],addPokemon(T,Destino,Pergunta,NovoValor,S_N,NovaLista2) , addPokemon(H,Destino,Pergunta,NovoValor,S_N,NovaLista3), NovaLista=[NovaLista3,NovaLista2]); 
                                                ((Arvore=Destino) -> ((S_N='n') -> NovaLista=[Pergunta,[Destino,NovoValor]]; NovaLista=[Pergunta,[NovoValor,Destino]]),!; NovaLista=Arvore).

pergunta(Perg,PokemonNovo,S_N) :- write('Que pena...Escreva Pergunta:'),nl, read(Perg), write('Escreva Pokemon:'),nl, read(PokemonNovo), write("Escreva 's' ou 'n'"),nl, read(S_N).

handleNovoPokemon(ListaAtual,Pokemon,NovaLista) :- pergunta(Perg,NovoPokemon,S_N), lista(Lista), addPokemon(Lista,Pokemon,Perg,NovoPokemon,S_N,NovaLista).

save :- tell('pokedex.txt'), listing(lista), told.

pokedex(Lista,NovaArvore) :- nl, read(Input), nl,
            (
                (Input='s', pegaProxPrim(Lista,Pokemon), not(is_list(Pokemon)), write(Pokemon), !);
                (Input='s', pegaProxPrim(Lista,PrimElem), is_list(PrimElem), pegaPrim(PrimElem, Pergunta), not(is_list(Pergunta)), write(Pergunta), pokedex(PrimElem,NovaArvore), !);
                (Input='s', pegaProxPrim(Lista,PrimElem), is_list(PrimElem), pegaPrim(PrimElem, SubLista), is_list(SubLista), pokedex(SubLista,NovaArvore), !);
                
                (Input='n', pegaProxSeg(Lista,Pokemon), not(is_list(Pokemon)), write(Pokemon), !);
                (Input='n', pegaProxSeg(Lista,SegElem), is_list(SegElem), pegaPrim(SegElem, Pergunta), not(is_list(Pergunta)), write(Pergunta), pokedex(SegElem,NovaArvore), !);
                (Input='n', pegaProxSeg(Lista,SegElem), is_list(SegElem), pegaPrim(SegElem, SubLista), is_list(SubLista), pokedex(SubLista,NovaArvore), !)
            ),nl,
            write('Acertei?'),nl,
            read(Resp),
            (
                (Resp='s', write('Yaay'), !, fail);
                (Resp='n', handleNovoPokemon(Lista,Pokemon,NovaLista), retractall(lista(_)), asserta(lista(NovaLista)), save, !, fail)
            ).

run :- retractall(lista(_)), consult('pokedex.txt'), lista(L), pegaPrim(L, Pergunta), write(Pergunta), pokedex(L, Resposta).