% Piotr Szulc 347277

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Part first
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%jestEFGrafem(+Term)
jestEFGrafem(Graph) :-
    checkNoVertexIsDuplicated(Graph),
    \+ undeclaredVertexExists(Graph),
    \+ asymmetricVertexExists(Graph). % F-edges must be symmetric

%checkNoVertexIsDuplicated1(+Term)
checkNoVertexIsDuplicated(Graph) :-
    checkNoVertexIsDuplicated(Graph, []).

%checkNoVertexIsDuplicated(+Nodes[], +Verices[])
checkNoVertexIsDuplicated([], _).
checkNoVertexIsDuplicated([node(V, _, _ ) | L], Vertices) :-
    \+ member(V, Vertices),
    checkNoVertexIsDuplicated(L, [V | Vertices]).

%undeclaredVertexExists(+Nodes[])
undeclaredVertexExists(Graph) :-
    getGraphVertices(Graph, Vertices),
    member(node(_, E, F), Graph),
    append(E, F, Neighbours),
    member(V, Neighbours),
    \+ member(V, Vertices).

%asymmetricVertexExists(+Nodes[])
asymmetricVertexExists(Graph) :-  % Check if exists asymmetric F-edges
    member(node(V, _, F), Graph),
    member(VSymmetric, F),
    member(node(VSymmetric, _, FSymmetric), Graph),
    \+ member(V, FSymmetric).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Part second - jestDobrzeUlozony
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

jestDobrzeUlozony(EFgraf) :-
    jestEFGrafem(EFgraf),

    \+ fDegreeOverLimit(EFgraf, 3),

    findStart(EFgraf, Start),
    findEnd(EFgraf, Destination),

    Start \= Destination,
    
    length(EFgraf, NumberOfGraphVertices),
    maxEDegreeOfGraph(EFgraf, MaxEDegreeOfGraph),

    % MaxSteps := max(Deg_E_Edges(v) for v in Vertices) * length(Vertices)
    MaxSteps is NumberOfGraphVertices * MaxEDegreeOfGraph,

    dfsE(EFgraf, Start, Destination, 1, MaxSteps, [Start]).

%fDegreeOverLimit(+Node[], +Int)
fDegreeOverLimit(Graph, Limit) :-
    member(node(_, _, F), Graph),
    length(F, FDegree),
    FDegree > Limit.

% Below I need to calculate whole lists of starts and ends
% and check if they contain only one element since I'm not using
% any generators

%findEnd(+Node[], -Term)
findEnd(Graph, End) :- findEnds(Graph, [], [End]).
%findEnds(+Node[], +Term[]: Accumulator, -Term[]: Result)
findEnds([], Ends, Ends).
findEnds([node(V, [], _ ) | L], Ends, Results) :- % no out edges, V is end
    findEnds(L, [V|Ends], Results).
findEnds([node(_, E, _) | L], Ends, Results) :- % V has out edges, skip
    length(E, Len),
    Len > 0,
    findEnds(L, Ends, Results).

%findStart(+Node[], -Term)
findStart(Graph, Start) :- findStarts(Graph, [Start]).
% List vertices not in set of E-edges
%findStarts(+Node[], -Term[])
findStarts(Graph, Starts) :-
    inputEEdges(Graph, [], InputEdges),
    getGraphVertices(Graph, Vertices),
    difference(Vertices, InputEdges, [], Starts).

% List all E-edges
%inputEEdges(+Node[], +Term[]: Accumulator, -Term[]: Result)
inputEEdges([], InputEdges, InputEdges).
inputEEdges([node(_, E, _) | L], InputEdges, Result) :-
    append(E, InputEdges, NewInputEdges),
    inputEEdges(L, NewInputEdges, Result).


% dfs Over E-edges that has limit of MaximumSteps of how many steps it's allowed to take
% limit exists in order not to get stuck infinitely on cycle
%dfsE(+Node[], +Term, +Term, +Int, +Int, +Term[])
dfsE(Graph, Destination, Destination, CurrentStep, MaximumSteps, VisitedVerticesSet) :- 
    % We reached destination in limit and we visited all vertices of graph, we're good!
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%jestDobrzePermutujacy(+EFGraf)
jestDobrzePermutujacy(EFGraf) :-
    jestDobrzeUlozony(EFGraf),
    \+ failsFirstCheck(EFGraf),
    \+ failsSecondCheck(EFGraf). 


%failsFirstCheck(+Node[])
failsFirstCheck(Graph) :- % doesn't pass first implication of task
    findEnd(Graph, End),

    member(node(_V, E, F), Graph),
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

%failsSecondCheck(+Node[])
failsSecondCheck(Graph) :-  % doesn't pass second implication of task
    findStart(Graph, Start),

    member(node(_V1, E1, F1), Graph),
    member(V, E1),
    member(node(V, _, F), Graph),
    member(W1, F),

    W1 \= Start,

    \+ (
        member(U, F1),
        member(node(U, EU, _), Graph),
        member(W1, EU)
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Part fourth - jestSucc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%jestSucc(+EFGraf, +Term[], +Term[])
jestSucc(EFGraf, L1, L2) :-
    % According to moodle's forum no need to check here if first argument is EFGraf

    length(L1, M),
    length(L2, N),

    M =< N,

    isFPath(EFGraf, L1),
    isFPath(EFGraf, L2),

    checkIfEEdgesExistBetween(EFGraf, L1, L2).

%checkIfEEdgesExistBetween(+EFGraf, +Term[], +Term[])
checkIfEEdgesExistBetween(_, [], _).
checkIfEEdgesExistBetween(EFGraf, [E1|L1], [E2|L2]) :-
    member(node(E1, E, _), EFGraf),
    member(E2, E),
    checkIfEEdgesExistBetween(EFGraf, L1, L2).
    
%isFPath(+Node[], +Term[])
isFPath(_, []).
isFPath(EFGraf, [V]) :-
    member(node(V, _, _), EFGraf).
isFPath(EFGraf, [V1, V2|L]) :- 
    member(node(V1, _, F), EFGraf),
    member(V2, F),
    isFPath(EFGraf, [V2|L]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EFGraf utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%getGraphVertices(+Node[], -Term[])
getGraphVertices(Graph, Vertices) :- computeGraphVertices(Graph, [], Vertices).
%computeGraphVertices(+Node[], +Term[]: tmp, -Term[]: result)
computeGraphVertices([], Vertices, Vertices).
computeGraphVertices([node(V, _, _) | L], Vertices, Result) :-
    computeGraphVertices(L, [V|Vertices], Result).


%maxEDegreeOfGraph(+Node[], -Int)
maxEDegreeOfGraph(Graph, D) :- computeMaxEDegreeOfGraph(Graph, 0, D).
%computeMaxEDegreeOfGraph(+Node, +Int: tmp, -Int: result)
computeMaxEDegreeOfGraph([], D, D).
computeMaxEDegreeOfGraph([node(_, E, _) | L], D, Result) :- 
    list_to_set(E, ESet), % this is trivial, easily done with member and accumulator
    length(ESet, Len),
    Len > D,
    computeMaxEDegreeOfGraph(L, Len, Result).
computeMaxEDegreeOfGraph([node(_, E, _) | L], D, Result) :- 
    list_to_set(E, ESet), % this is trivial, easily done with member and accumulator
    length(ESet, Len),
    Len =< D,
    computeMaxEDegreeOfGraph(L, D, Result). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% My list utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%difference(+List: L1, +List: L2, +List: tmp, -List: L1 - L2)
difference([], _, List, List).
difference([E|L1], L2, Ends, Result) :-
    \+ member(E, L2),
    difference(L1, L2, [E|Ends], Result).

difference([E|L1], L2, Ends, Result) :-
    member(E, L2),
    difference(L1, L2, Ends, Result).

%addElementToSet(+Term, +List, -List: result)
addElementToSet(Element, Set, Set) :-
    member(Element, Set).

addElementToSet(Element, Set, [Element|Set]) :-
    \+ member(Element, Set).

