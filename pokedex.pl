% lista(['Eh vermelho?', ['Charmander', 'Rhydon']]).


lista(['Eh vermelho?', [['Tem nove rabos?', [['Eh uma evolucao?', ['Ninetales', 'Vulpix']], 'Charmander']], ['Eh do tipo agua?', ['Gyarados', 'Rhydon']]]]).


pegaPrim([Head|Tail], Head). % Retorna o primeiro elemento da lista
pegaSeg([Head|[Tail|_]],Tail). % Retorna o segundo elemento da lista

resposta(A) :- random(0,2,X), ((A=s,X=1,!);(A=n,X=0,!)).

% [H|T]

insereNovo(Pergunta, PokemonResp, PokemonNovo, [Pergunta, [PokemonResp, PokemonNovo]]).

ola([Pergunta,[Sim,Nao]]) :- resposta(A), 
        nl,
        write('Advinhe minha resposta, responderei sim ou nao? (s p/ sim, n para nao e q para sair)'),nl,
        
        write('Nao esqueca de finalizar sua resposta com . ex: s. ou n.'),nl,
        read(X),
        nl,
        (
            (X = 'q', write("ate breve!"), !, fail);
            (A = X, write("Voce acertou!"), nl, ola(Sim),!);
            (A \= X, write("Voce errou!"), nl, ola(Nao),!)
         ).

% ['Eh vermelho?', [['Tem nove rabos?', [['Eh uma evolucao?', [['faz parte do naruto?',['Naruto','Ninetales']], 'Vulpix']], 'Charmander']], ['Eh do tipo agua?', ['Gyarados', 'Rhydon']]]]

pegaProxPrim(Lista,Prim) :- pegaSeg(Lista,SubLista), pegaPrim(SubLista,Prim).
pegaProxSeg(Lista,Seg) :- pegaSeg(Lista,SubLista), pegaSeg(SubLista,Seg).

pokedex(Lista) :- nl, read(Input), nl,
            (
                (Input='s', pegaProxPrim(Lista,Pokemon), not(is_list(Pokemon)), write(Pokemon), !, fail);
                (Input='s', pegaProxPrim(Lista,PrimElem), is_list(PrimElem), pegaPrim(PrimElem, Pergunta), not(is_list(Pergunta)), write(Pergunta), pokedex(PrimElem), !);
                (Input='s', pegaProxPrim(Lista,PrimElem), is_list(PrimElem), pegaPrim(PrimElem, SubLista), is_list(SubLista), pokedex(SubLista), !);
                
                (Input='n', pegaProxSeg(Lista,Pokemon), not(is_list(Pokemon)), write(Pokemon), !, fail);
                (Input='n', pegaProxSeg(Lista,SegElem), is_list(SegElem), pegaPrim(SegElem, Pergunta), not(is_list(Pergunta)), write(Pergunta), pokedex(SegElem), !);
                (Input='n', pegaProxSeg(Lista,SegElem), is_list(SegElem), pegaPrim(SegElem, SubLista), is_list(SubLista), pokedex(SubLista), !)
            ).

run :- lista(L), pegaPrim(L, Pergunta), write(Pergunta), pokedex(L).