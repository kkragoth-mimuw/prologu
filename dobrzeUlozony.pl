%findEnds(Graph, Ends)

findEnd(Graph, End) :- findEnds(Graph, [], [End]).

findEnds([], Ends, Ends).
findEnds([node(V, [], _ ) | L], Ends, Result) :-
    findEnds(L, [V|Ends], Result).