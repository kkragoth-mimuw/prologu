
jestEFGrafem(Graph) :-
    isEFGGraph(Graph, Graph, []).

% First pass - check for duplicates in vertices declarations
% isEFGGraphCheckDuplicates(OriginalGraph, CopyOfModifiedGraph, GraphVertices)
isEFGGraphCheckDuplicates(Graph, [], Vertices) :- isEFGGraphCheckUndeclared(Graph, Vertices).
isEFGGraphCheckDuplicates(Graph, [ node(V,_,_) | L], Vertices) :- 
    \+ member(V, Vertices),
    isEFGGraphCheckDuplicates(Graph, Graph, L, [V|Vertices]).

% Second pass - check if edges use undeclared vertices
% isEFGGraphCheckUndeclared(Graph, Vertices)
isEFGGraphCheckUndeclared(Graph, [], _) :- isEFGGraphCheckSymmetric(Graph, Graph).
isEFGGraphCheckUndeclared(Graph, [node(_, E, F) | L], Vertices) :-
    containedIn(E, Vertices),
    containedIn(F, Vertices),
    isEFGGraphCheckUndeclared(Graph, L, Vertices).

containedIn([], _).
containedIn([E|L], Vertices) :-
    member(E, Vertices),
    containedIn(L, Vertices).


% 
% isEFGGraphCheckSymmetric(Graph, Graph)