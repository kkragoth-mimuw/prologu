jestEFGrafem(Graph) :-
    checkDuplicates(Graph, [], Vertices),
    checkUndeclared(Graph, Vertices).
    checkIfFareSymmetric(Graph, Graph).

checkDuplicates([], Vertices, Vertices).
checkDuplicates([node(V, _, _ ) | L , Vertices, Result) :-
    \+ member(V, Vertices),
    checkDuplicates(L, [V | Vertices], Result).

checkUndeclared([], _).
checkUndeclared([node(_, E, F)|L], Vertices) :-
    listContainedInList(E, Vertices),
    listContainedInList(F, Vertices)
    checkUndeclared(L, Vertices).

listContainedInList([], _).
listContainedInList([E|L], Vertices) :-
    member(E, Vertices),
    listContainedInList(L, Vertices).