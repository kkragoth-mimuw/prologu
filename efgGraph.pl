%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Part first - jestEFGrafem
jestEFGrafem(Graph) :-
    checkNoVertexIsDuplicated(Graph),
    \+ undeclaredVertexExists(Graph),
    \+ asymmetricVertexExists(Graph).

checkNoVertexIsDuplicated(Graph) :- checkNoVertexIsDuplicated(Graph, []).
checkNoVertexIsDuplicated([], _).
checkNoVertexIsDuplicated([node(V, _, _ ) | L], Vertices) :-
    \+ member(V, Vertices),
    checkNoVertexIsDuplicated(L, [V | Vertices]).

undeclaredVertexExists(Graph) :-
    getGraphVertices(Graph, Vertices),
    member(node(_, E, F), Graph),
    append(E, F, Neighbours),
    member(V, Neighbours),
    \+ member(V, Vertices).

asymmetricVertexExists(Graph) :- 
    member(node(V, _, F), Graph),
    member(VSymmetric, F),
    member(node(VSymmetric, _, FSymmetric), Graph),
    \+ member(V, FSymmetric).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Part second - jestDobrzeUlozony
jestDobrzeUlozony(EFgraf) :-
    jestEFGrafem(EFgraf),

    \+ fDegreeOverLimit(EFgraf, 3),

    findStart(EFgraf, Start),
    findEnd(EFgraf, Destination),

    Start \= Destination,
    
    length(EFgraf, NumberOfGraphVertices),
    maxEDegreeOfGraph(EFgraf, MaxEDegreeOfGraph),
    MaxSteps is NumberOfGraphVertices * MaxEDegreeOfGraph,

    dfsE(EFgraf, Start, Destination, 1, MaxSteps, [Start]).


fDegreeOverLimit(Graph, Limit) :-
    member(node(_, _, F), Graph),
    length(F, FDegree),
    FDegree > Limit.

findEnd(Graph, End) :- findEnds(Graph, [], [End]).
findEnds([], Ends, Ends).
findEnds([node(V, [], _ ) | L], Ends, Results) :-
    findEnds(L, [V|Ends], Results).
findEnds([node(_, E, _) | L], Ends, Results) :-
    length(E, Len),
    Len > 0,
    findEnds(L, Ends, Results).

findStart(Graph, Start) :- findStarts(Graph, [Start]).
findStarts(Graph, Starts) :-
    inputEEdges(Graph, [], InputEdges),
    getGraphVertices(Graph, Vertices),
    difference(Vertices, InputEdges, [], Starts).

inputEEdges([], InputEdges, InputEdges).
inputEEdges([node(_, E, _) | L], InputEdges, Result) :-
    append(E, InputEdges, NewInputEdges),
    inputEEdges(L, NewInputEdges, Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DFS

dfsE(Graph, Destination, Destination, CurrentStep, MaximumSteps, VisitedVerticesSet) :-
    CurrentStep =< MaximumSteps,

    addElementToSet(Destination, VisitedVerticesSet, NewVisitedVerticesSet),

    length(Graph, NumberOfGraphVertices),
    length(NewVisitedVerticesSet, NumberOfGraphVertices).


dfsE(Graph, V, Destination, CurrentStep, MaximumSteps, VisitedVerticesSet) :-
    CurrentStep =< MaximumSteps,

    NewStep is CurrentStep + 1,

    addElementToSet(V, VisitedVerticesSet, NewVisitedVerticesSet),

    member(node(V, F, _), Graph),

    member(Next, F),
    dfsE(Graph, Next, Destination, NewStep, MaximumSteps, NewVisitedVerticesSet).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Part three - jestDobrzePermutujacy
jestDobrzePermutujacy(EFGraf) :-
    jestDobrzeUlozony(EFGraf),
    \+ failsFirstCheck(EFGraf),
    \+ failsSecondCheck(EFGraf).


failsFirstCheck(Graph) :-
    findEnd(Graph, End),

    member(node(V, E, F), Graph),
    length(E, ELength), length(F, FLength),
    ELength > 0, 
    FLength > 0,

    member(V1, E),
    member(W1, F),

    W1 \= End,

    member(node(W1, EW, _), Graph),

    \+ (
            member(U, EW),
            member(node(U, _, FU), Graph),
            member(V1, FU)
    ).

failsSecondCheck(Graph) :-
    findStart(Graph, Start),

    member(node(V1, E1, F1), Graph),
    member(V, E1),
    member(node(V, E, F), Graph),
    member(W1, F),

    W1 \= Start,

    \+ (
        member(U, F1),
        member(node(U, EU, FU, Graph)),
        member(W1, EU)
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Part fourth - jestSucc - this is the Part where Szubert kills you
jestSucc(EFGraf, L1, L2) :-
    \+var(L1),
    \+var(L2),
    length(L1, M),
    length(L2, N),
    M =< N,
    isFPath(EFGraf, L1),
    isFPath(EFGraf, L2),
    jestSucc3(EFGraf, L1, L2).


jestSucc3(_, [], _).
jestSucc3(EFGraf, [E1|L1], [E2|L2]) :-
    member(node(E1, E, _), EFGraf),
    member(E2, E),
    jestSucc3(EFGraf, L1, L2).
    

isFPath(EFGraf, []).
isFPath(EFGraf, [E|L]) :- isFPath(EFGraf, E, L).
isFPath(EFGraf, _, []).
isFPath(EFGraf, V, [E|L]) :-
    member(node(V, _, F), EFGraf),
    member(E, F),
    isFPath(EFGraf, E, L).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EFGraf utils
getGraphVertices(Graph, Vertices) :- computeGraphVertices(Graph, [], Vertices).
computeGraphVertices([], Vertices, Vertices).
computeGraphVertices([node(V, _, _) | L], Vertices, Result) :-
    computeGraphVertices(L, [V|Vertices], Result).


maxEDegreeOfGraph(Graph, D) :- computeMaxEDegreeOfGraph(Graph, 0, D).
computeMaxEDegreeOfGraph([], D, D).
computeMaxEDegreeOfGraph([node(_, E, _) | L], D, Result) :- 
    list_to_set(E, ESet),
    length(ESet, Len),
    Len > D,
    computeMaxEDegreeOfGraph(L, Len, Result).
computeMaxEDegreeOfGraph([node(_, E, _) | L], D, Result) :- 
    list_to_set(E, ESet),
    length(ESet, Len),
    Len =< D,
    computeMaxEDegreeOfGraph(L, D, Result). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% My list utils
difference([], _, List, List).
difference([E|L1], L2, Ends, Result) :-
    \+ member(E, L2),
    difference(L1, L2, [E|Ends], Result).

difference([E|L1], L2, Ends, Result) :-
    member(E, L2),
    difference(L1, L2, Ends, Result).

addElementToSet(Element, Set, Set) :-
    member(Element, Set).

addElementToSet(Element, Set, [Element|Set]) :-
    \+ member(Element, Set).

