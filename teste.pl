lista([1,2,3,4]).

addAfter([H|T],Destino,Valor,NewList) :- (Destino=H) -> NewList=[H,Valor|T] ; (addAfter(T,Destino,Valor,NewList2), NewList=[H|NewList2]).

arvore([[1,[4,[5,6]]],[2,3]]).


addArvore2(Arvore,Destino,Valor,NewList) :- (is_list(Arvore)) -> (Arvore=[H,T],addArvore2(T,Destino,Valor,NewList2) , addArvore2(H,Destino,Valor,NewList3), NewList=[NewList3,NewList2]); 
                                                ((Arvore=Destino) -> (NewList=[Valor,Destino],!); NewList=Arvore).

addArvore(Arvore,Destino,Valor,NewList) :- addArvore2(Arvore,Destino,Valor,NewList), write(NewList).
% ['teste.pl'],arvore(L), addArvore(L,3,7,N). 