helloworld() :- write('Hello World!'), nl.
/*
inverter(_,_).
inverter([H|T],[Z|H]) :- inverter(T,Z).
inverter(X) :- inverter(X,Y), write(Y).
tipo(rhydon,pedra).
tipo(rhydon,terra).
segundaEvolucao(rhydon).
ultimaEvolucao(rhydon).
cor(rhydon,cinza).

tipo(rhyhorn,pedra).
tipo(rhyhorn,terra).
primeiraEvolucao(rhyhorn).
cor(rhyhorn,cinza).


tipo(charmander,fogo).
cor(charmander,vermelho).
primeiraEvolucao(charmander).

tipo(charmeleon,fogo).
segundaEvolucao(charmeleon).
cor(charmeleon,vermelho).

tipo(charizard,fogo).
tipo(charizard,voador).
terceiraEvolucao(charizard).
ultimaEvolucao(charizard).
cor(charizard,vermelho).

tipo(ponyta,fogo).
primeiraEvolucao(ponyta).
cor(ponyta,amarelo).

tipo(rapidash,fogo).
segundaEvolucao(rapidash).
ultimaEvolucao(rapidash).
cor(rapidash,amarelo).

teste(X,[]) :- !.
teste(X,[Rule|Rest]) :-
    write('Testing rule: '), write(Rule), nl,
    Z=call(Rule,X),
    write('Result: '), write(Z), nl,
    teste(X,Rest).

% Define your rules here
rule1 :- write('Rule 1 executed.\n').
rule2 :- write('Rule 2 executed.\n').
rule3 :- write('Rule 3 executed.\n').

% Define a predicate to run all the rules in a list
run_rules([]). % Base case: Empty list, no rules to run
run_rules([Rule|Rest]) :-
    call(Rule),    % Execute the current rule
    run_rules(Rest). % Recursively call run_rules with the rest of the list

% Example usage:
run_all_rules :-
    Rules = [rule1, rule2, rule3], % Define a list of rules
    run_rules(Rules). % Call the predicate to run all rules

[ultimaEvolucao,terceiraEvolucao]
*/

equals(String, Result) :-
    (String = 's' ->
        Result = true
    ;
        Result = false
    ).



akinator('Rhydon', 'tipo pedra?').
akinator('Geodude','tipo pedra?').
akinator('Charmander', 'tipo fogo?').
%[É vermelho?, [[Tem nove rabos?, [[É uma evolução?, [Ninetales, Vulpix]], Charmander]], [É do tipo água?, [Gyarados, Rhydon]]]]

perguntar(Pergunta,X) :- write(Pergunta) ,nl,read(Resposta),nl, equals(Resposta,X), X.



% solve(Pergunta,Pokemons) :- !.
% solve(Pergunta,Pokemons) :- perguntar(Pergunta,Resposta) ,akinator(X,Pergunta,Resposta is 's')==Pokemons.
solve(Pergunta,Pokemons) :- !.
solve(Pergunta,Pokemons) :- perguntar(Pergunta,Resposta), akinator(Pokemons,Pergunta), (Resposta = true -> akinator(Pokemons,ProximaPergunta); \+ akinator(Pokemons,ProximaPergunta)) , solve(Pokemons,ProximaPergunta).

%swipl