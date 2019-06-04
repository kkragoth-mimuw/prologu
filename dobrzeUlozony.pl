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