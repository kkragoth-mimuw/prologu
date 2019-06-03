%findEnds(Graph, Ends)

findEnd(Graph, End) :- findEnds(Graph, [], [End]).

findEnds([], Ends, Ends).
findEnds([node(V, [], _ ) | L], Ends, Results) :-
    findEnds(L, [V|Ends], Results).

findStart(Graph, Start) :- findStarts(Graph, [], [], [], [Start]).

findStarts([], [], _, Starts, Starts).

findStarts([], [V|L], InEdges, Starts, Results) :-
    \+ member(V, InEdges),
    findStarts([], L, InEdges, [V|Starts], Results).

findStarts([], [V|L], InEdges, Starts, Results) :-
    \+ member(V, InEdges),
    findStarts([], L, InEdges, [Starts], Results).

% findStarts(Graph, Vertices, InEdges, Results).
findStarts([node(V, E, _) | L], Vertices, InEdges, Starts, Results) :-
    findStarts(L, [V | Vertices], [E | InEdges], Starts, Results).