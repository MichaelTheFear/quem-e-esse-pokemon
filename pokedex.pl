% lista(['Eh vermelho?', ['Charmander', 'Rhydon']]).

lista(['Eh vermelho?', [['Tem nove rabos?', [['Eh uma evolucao?', ['Ninetales', 'Vulpix']], 'Charmander']], ['Eh do tipo agua?', ['Gyarados', 'Rhydon']]]]).

pegaPrim([Head|_], Head). % Retorna o primeiro elemento da lista
pegaSeg([_|[Tail|_]],Tail). % Retorna o segundo elemento da lista

replace(_, _, [], []).
replace(O, R, [O|T], [R|T]).
replace(O, R, [H|[O]], [H|[R]]).
replace(O, R, [H|[T|_]], [H|[T2]]) :- dif(O, H), replace(O, R, T, T2).

% [Tem nove rabos?,[[Eh uma evolucao?,[Ninetales,Vulpix]],Charmander]]
% [Tem nove rabos?,[[Eh uma evolucao?,[Ninetales,Vulpix]],['Voa?', [Charizard, Charmander]]]

resposta(A) :- random(0,2,X), ((A=s,X=1,!);(A=n,X=0,!)).

% ['Eh vermelho?', [['Tem nove rabos?', [['Eh uma evolucao?', [['faz parte do naruto?',['Naruto','Ninetales']], 'Vulpix']], 'Charmander']], ['Eh do tipo agua?', ['Gyarados', 'Rhydon']]]]

pegaProxPrim(Lista,Prim) :- pegaSeg(Lista,SubLista), pegaPrim(SubLista,Prim).
pegaProxSeg(Lista,Seg) :- pegaSeg(Lista,SubLista), pegaSeg(SubLista,Seg).

pokedex(Lista) :- nl, read(Input), nl,
            (
                (Input='s', pegaProxPrim(Lista,Pokemon), not(is_list(Pokemon)), write(Pokemon), !);
                (Input='s', pegaProxPrim(Lista,PrimElem), is_list(PrimElem), pegaPrim(PrimElem, Pergunta), not(is_list(Pergunta)), write(Pergunta), pokedex(PrimElem), !);
                (Input='s', pegaProxPrim(Lista,PrimElem), is_list(PrimElem), pegaPrim(PrimElem, SubLista), is_list(SubLista), pokedex(SubLista), !);
                
                (Input='n', pegaProxSeg(Lista,Pokemon), not(is_list(Pokemon)), write(Pokemon), !);
                (Input='n', pegaProxSeg(Lista,SegElem), is_list(SegElem), pegaPrim(SegElem, Pergunta), not(is_list(Pergunta)), write(Pergunta), pokedex(SegElem), !);
                (Input='n', pegaProxSeg(Lista,SegElem), is_list(SegElem), pegaPrim(SegElem, SubLista), is_list(SubLista), pokedex(SubLista), !)
            ),nl,
            write('Acertei?'),nl,write(Lista),
            read(Resp),
            (
                (Resp='s', write('Yaay'), !);
                (Resp='n', write('Que pena...Escreva Pergunta:'),nl, read(Perg), write('Escreva Pokemon:'),nl, read(PokemonNovo), replace(Pokemon, [Perg, [PokemonNovo, Pokemon]], Lista, NovaLista), write(NovaLista), !)
            ).

run :- lista(L), pegaPrim(L, Pergunta), write(Pergunta), pokedex(L).