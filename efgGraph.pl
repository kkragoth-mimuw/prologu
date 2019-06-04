jestEFGrafem(Graph) :-
    checkDuplicates(Graph, [], Vertices),
    checkUndeclared(Graph, Vertices),
    checkGraphSymmetric(Graph, Graph).

checkDuplicates([], Vertices, Vertices).
checkDuplicates([node(V, _, _ ) | L], Vertices, Result) :-
    \+ member(V, Vertices),
    checkDuplicates(L, [V | Vertices], Result).

checkUndeclared([], _).
checkUndeclared([node(_, E, F)|L], Vertices) :-
    listContainedInList(E, Vertices),
    listContainedInList(F, Vertices),
    checkUndeclared(L, Vertices).

checkGraphSymmetric(_, []).
checkGraphSymmetric(Graph, [node(V, _E, F)|L]) :-
    checkIfFedgesAreSymmetric(Graph, F, V),
    checkGraphSymmetric(Graph, L).

checkIfFedgesAreSymmetric(_, [], _) :- !.
checkIfFedgesAreSymmetric(Graph, [E|F], V) :-
    checkIfVisInE(Graph, E, V),
    checkIfFedgesAreSymmetric(Graph, F, V).

checkIfVisInE([node(V, _A, F) | _L], V, Vstart) :-
    member(Vstart, F).

checkIfVisInE([_|L], V, Vstart) :-
    checkIfVisInE(L, V, Vstart).

listContainedInList([], _).
listContainedInList([E|L], Vertices) :-
    member(E, Vertices),
    listContainedInList(L, Vertices).

