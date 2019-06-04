jestEFGrafem(Graph) :-
    getGraphVertices(Graph, Vertices),
    checkNoDuplicates(Graph, []),
    checkNoUndeclared(Graph, Vertices),
    checkGraphSymmetric(Graph).

checkNoDuplicates([], _Vertices).
checkNoDuplicates([node(V, _, _ ) | L], Vertices) :-
    \+ member(V, Vertices),
    checkNoDuplicates(L, [V | Vertices]).

checkNoUndeclared([], _).
checkNoUndeclared([node(_, E, F)|L], Vertices) :-
    listContainedInList(E, Vertices),
    listContainedInList(F, Vertices),
    checkNoUndeclared(L, Vertices).

checkGraphSymmetric(Graph) :- checkGraphSymmetric(Graph, Graph).
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

getGraphVertices(Graph, Vertices) :- computeGraphVertices(Graph, [], Vertices).
computeGraphVertices([], Vertices, Vertices).
computeGraphVertices([node(V, _, _) | L], Vertices, Result) :-
    computeGraphVertices(L, [V|Vertices], Result).

listContainedInList([], _).
listContainedInList([E|L], Vertices) :-
    member(E, Vertices),
    listContainedInList(L, Vertices).

findEnd(Graph, End) :- findEnds(Graph, [], [End]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
findEnds([], Ends, Ends).
findEnds([node(V, [], _ ) | L], Ends, Results) :-
    findEnds(L, [V|Ends], Results).
findEnds([node(_, [_], _) | L], Ends, Results) :-
    findEnds(L, Ends, Results).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


findStart(Graph, Start) :- 
    findStart(Graph, [], [], [], Start).

findStart([], [], _, [Start], [Start]).

findStart([], [V|L], InEdges, Starts, Results) :-
    \+ member(V, InEdges),
    findStart([], L, InEdges, [V|Starts], Results).

findStart([], [V|L], InEdges, Starts, Results) :-
    \+ member(V, InEdges),
    findStart([], L, InEdges, [Starts], Results).

findStart([node(V, E, _) | L], Vertices, InEdges, Starts, Results) :-
    findStart(L, [V | Vertices], [E | InEdges], Starts, Results).



%% UTILS
getVertexFromGraph(Graph, node(V, E, F)) :- computeGetVertexFromGraph(Graph, V, E, F).
computeGetVertexFromGraph([node(V, E, F) | _], V, E, F).
computeGetVertexFromGraph([_|L], V, E, F) :-
    computeGetVertexFromGraph(L, V, E, F).


maxEDegreeOfGraph(Graph, D) :- computeMaxEDegreeOfGraph(Graph, 0, D).
computeMaxEDegreeOfGraph([], D, D).
computeMaxEDegreeOfGraph([node(_, E, _) | L], D, Result) :- 
    length(E, Len),
    Len > D,
    computeMaxEDegreeOfGraph(L, Len, Result).
computeMaxEDegreeOfGraph([node(_, E, _) | L], D, Result) :- 
    length(E, Len),
    Len =< D,
    computeMaxEDegreeOfGraph(L, D, Result). 