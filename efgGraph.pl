%%% jestEFGrafem
jestEFGrafem(Graph) :-
    checkNoDuplicates(Graph),
    \+ undeclaredExists(Graph),
    \+ asymmetricExists(Graph).

checkNoDuplicates(Graph) :- checkNoDuplicates(Graph, []).
checkNoDuplicates([], _Vertices).
checkNoDuplicates([node(V, _, _ ) | L], Vertices) :-
    \+ member(V, Vertices),
    checkNoDuplicates(L, [V | Vertices]).

undeclaredExists(Graph) :-
    getGraphVertices(Graph, Vertices),
    member(node(_, E, F), Graph),
    append(E, F, Neighbours),
    member(V, Neighbours),
    \+ member(V, Vertices).

asymmetricExists(Graph) :- 
    member(node(V, _, F), Graph),
    member(VSymmetric, F),
    member(node(VSymmetric, _, FSymmetric), Graph),
    \+ member(V, FSymmetric).

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
    jestEFGrafem(EFgraf),

    \+ fDegreeOverLimit(EFgraf),

    findStart(EFgraf, Start),
    findEnd(EFgraf, Destination),

    Start \= Destination,
    
    length(EFgraf, NumberOfGraphVertices),
    maxEDegreeOfGraph(EFgraf, MaxEDegreeOfGraph),

    MaxSteps is NumberOfGraphVertices * MaxEDegreeOfGraph,

    dfsE(EFgraf, Start, Destination, 1, MaxSteps, [Start]).


fDegreeOverLimit(Graph) :-
    member(node(_, _, F), Graph),
    length(F, FDegree),
    FDegree > 3.

findEnd(Graph, End) :- findEnds(Graph, [], [End]).

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

dfsE(Graph, Destination, Destination, CurrentStep, MaximumSteps, VisitedVerticesSet) :-
    CurrentStep =< MaximumSteps,

    addVertexToVisitedVerticesSet(Destination, VisitedVerticesSet, NewVisitedVerticesSet),

    length(Graph, NumberOfGraphVertices),
    length(NewVisitedVerticesSet, NumberOfGraphVertices).


dfsE(Graph, V, Destination, CurrentStep, MaximumSteps, VisitedVerticesSet) :-
    CurrentStep =< MaximumSteps,

    NewStep is CurrentStep + 1,

    addVertexToVisitedVerticesSet(V, VisitedVerticesSet, NewVisitedVerticesSet),

    member(node(V, F, _), Graph),

    member(Next, F),
    dfsE(Graph, Next, Destination, NewStep, MaximumSteps, NewVisitedVerticesSet).

addVertexToVisitedVerticesSet(V, VisitedVerticesSet, VisitedVerticesSet) :-
    member(V, VisitedVerticesSet).

addVertexToVisitedVerticesSet(V, VisitedVerticesSet, [V|VisitedVerticesSet]) :-
    \+ member(V, VisitedVerticesSet).








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