%%% jestEFGrafem
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

% Check dobrzeUlozony
jestDobrzeUlozony(EFgraf) :-
    findStart(EFgraf, Start),
    findEnd(EFgraf, Destination),
    
    length(EFgraf, NumberOfGraphVertices),
    maxEDegreeOfGraph(EFgraf, MaxEDegreeOfGraph),

    MaxSteps is NumberOfGraphVertices * MaxEDegreeOfGraph,

    dfs(EFgraf, Start, Destination, 1, MaxSteps, [Start]).


findEnd(Graph, End) :- findEnds(Graph, [], [End]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
findEnds([], Ends, Ends).
findEnds([node(V, [], _ ) | L], Ends, Results) :-
    findEnds(L, [V|Ends], Results).
findEnds([node(_, [_], _) | L], Ends, Results) :-
    findEnds(L, Ends, Results).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

findStart(Graph, Start) :- findStarts(Graph, [Start]).

inputEEdges([], InputEdges, InputEdges).
inputEEdges([node(_, E, _) | L], InputEdges, Result) :-
    append(E, InputEdges, NewInputEdges),
    inputEEdges(L, NewInputEdges, Result).

findStarts(Graph, Starts) :-
    inputEEdges(Graph, [], InputEdges),
    getGraphVertices(Graph, Vertices),
    difference(Vertices, InputEdges, [], Starts).

difference([], _, List, List).
difference([E|L], L2, Ends, Result) :-
    \+ member(E, L2),
    difference(L, L2, [E|Ends], Result).

difference([E|L], L2, Ends, Result) :-
    member(E, L2),
    difference(L, L2, Ends, Result).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DFS

dfs(Graph, Destination, Destination, CurrentStep, MaximumSteps, VisitedVerticesSet) :-
    CurrentStep =< MaximumSteps,

    addVertexToVisitedVerticesSet(Destination, VisitedVerticesSet, NewVisitedVerticesSet),

    length(Graph, NumberOfGraphVertices),
    length(NewVisitedVerticesSet, NumberOfGraphVertices),

    write(Destination),
    write(' Destination reached'),
    nl.

dfs(Graph, V, Destination, CurrentStep, MaximumSteps, VisitedVerticesSet) :-
    CurrentStep =< MaximumSteps,
    NewStep is CurrentStep + 1,

    write(V),
    nl,

    addVertexToVisitedVerticesSet(V, VisitedVerticesSet, NewVisitedVerticesSet),
    getVertexFromGraph(Graph, node(V, F, _)),
    forEachNeighbourLaunchDfs(Graph, F, Destination, NewStep, MaximumSteps, NewVisitedVerticesSet).


addVertexToVisitedVerticesSet(V, VisitedVerticesSet, VisitedVerticesSet) :-
    member(V, VisitedVerticesSet).

addVertexToVisitedVerticesSet(V, VisitedVerticesSet, [V|VisitedVerticesSet]) :-
    \+ member(V, VisitedVerticesSet).

forEachNeighbourLaunchDfs(Graph, [V|L], Destination, NewStep, MaximumSteps, VisitedVerticesSet) :-
    dfs(Graph, V, Destination, NewStep, MaximumSteps, VisitedVerticesSet),
    forEachNeighbourLaunchDfs(Graph, L, Destination, NewStep, MaximumSteps, VisitedVerticesSet).








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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