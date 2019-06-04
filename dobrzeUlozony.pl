% findEnds(Graph, Ends)

findEnd(Graph, End) :- findEnds(Graph, [], [End]).

findEnds([], Ends, Ends).
findEnds([node(V, [], _ ) | L], Ends, Results) :-
    findEnds(L, [V|Ends], Results).

findStart(Graph, Start) :- 
    findStart(Graph, [], [], [], Start),
    \+ is_list(Start),
    write(Start).

findStart([], [], _, [Start], [Start]).

findStart([], [V|L], InEdges, Starts, Results) :-
    \+ member(V, InEdges),
    findStart([], L, InEdges, [V|Starts], Results).

findStart([], [V|L], InEdges, Starts, Results) :-
    \+ member(V, InEdges),
    findStart([], L, InEdges, [Starts], Results).

% findStart(Graph, Vertices, InEdges, Results).
findStart([node(V, E, _) | L], Vertices, InEdges, Starts, Results) :-
    findStart(L, [V | Vertices], [E | InEdges], Starts, Results).