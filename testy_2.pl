%OK
:- jestDobrzeUlozony([node(v1926, [], []), node(v1940, [v1926, v1926],[])]).
:- jestDobrzeUlozony([node(v988, [v1002], []), node(v1002, [v1016], []), node(v1016, [v1002,v1030], []), node(v1030, [v1044], []), node(v1044, [], [])]).
:- jestDobrzeUlozony([node(v988, [v1002], []), node(v1002, [v1016,v1030], []), node(v1016, [], []), node(v1030, [v1002], [])]).
:- jestDobrzeUlozony([node(v984, [v998,v1026], [v998,v1026]), node(v998, [v1012,v1026], [v984]), node(v1012, [v1026], []), node(v1026, [], [v984])]).
:- jestDobrzeUlozony([node(v984, [v998,v1026], [v998,v1026]), node(v998, [v1012,v1026], [v984]), node(v1012, [v1026,v998], []), node(v1026, [], [v984])]).
:- jestDobrzeUlozony([node(v984, [v998,v1026], [v998,v1026,v1012]), node(v998, [v1012,v1026,v1012,v1012], [v984]), node(v1012, [v1026,v998], [v984]), node(v1026, [], [v984])]).

%NOK
:- \+ jestDobrzeUlozony([node(v1926, [v1940], []), node(v1940, [v1926, v1926],[])]).
:- \+ jestDobrzeUlozony([node(v988, [], []), node(v1002, [], []), node(v1016, [], []), node(v1030, [v988], [])]).
:- \+ jestDobrzeUlozony([node(v1926, [v1940], []), node(v1940, [v1926],[])]).
:- \+ jestDobrzeUlozony([node(v984, [v998,v1012], []), node(v998, [v1026], []), node(v1012, [v1026], []), node(v1026, [], [])]).
:- \+ jestDobrzeUlozony([node(v984, [v998,v1026], [v998,v1026]), node(v998, [v1012,v1026,v984], [v984]), node(v1012, [v1026], []), node(v1026, [], [v984])]).
:- \+ jestDobrzeUlozony([node(v984, [v998,v1026], [v998,v1026,v1012]), node(v998, [v1012,v1026,v1012,v1012], [v984]), node(v1012, [v1026,v998], []), node(v1026, [], [v984])]).
