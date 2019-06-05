%OK
:- jestEFGrafem([node(v, [], [])]).
:- jestEFGrafem([node(v4164, [], [v4186]), node(v4186, [], [v4164])]).
:- jestEFGrafem([node(v696, [], []), node(v710, [], [])]).
:- jestEFGrafem([node(v696, [], [v696])]).
:- jestEFGrafem([node(v696, [v696], [])]).
:- jestEFGrafem([node(v696, [v696], [v696])]).
:- jestEFGrafem([node(v700, [], []), node(v714, [], []), node(v728, [], [])]).
:- jestEFGrafem([node(v700, [], []), node(v714, [], [v714])]).
:- jestEFGrafem([node(v700, [], []), node(v714, [v700], [])]).
:- jestEFGrafem([node(v700, [], []), node(v714, [v714], [])]).
:- jestEFGrafem([node(v700, [], []), node(v714, [v700], [v714])]).
:- jestEFGrafem([node(v700, [], []), node(v714, [v714], [v714])]).
:- jestEFGrafem([node(v700, [], [v700]), node(v734, [], [])]).
:- jestEFGrafem([node(v700, [], [v700, v700])]).
:- jestEFGrafem([node(v700, [v700], []), node(v734, [], [])]).
:- jestEFGrafem([node(v700, [v708], []), node(v708, [], [])]).
:- jestEFGrafem([node(v700, [v700, v700], [])]).
:- jestEFGrafem([node(v700, [v700], [v700]), node(v740, [], [])]).
:- jestEFGrafem([node(v700, [v708], [v700]), node(v708, [], [])]).
:- jestEFGrafem([node(v700, [v700], [v700, v700])]).
:- jestEFGrafem([node(v700, [v700, v700], [v700])]).
:- jestEFGrafem([node(v700, [v700, v700], [v700, v700])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], []), node(v732, [], []), node(v746, [], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], []), node(v732, [], [v732])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], []), node(v732, [v704], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], []), node(v732, [v718], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], []), node(v732, [v732], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], []), node(v732, [v704], [v732])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], []), node(v732, [v718], [v732])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], []), node(v732, [v732], [v732])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], [v718]), node(v752, [], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [], [v718, v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704], []), node(v752, [], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718], []), node(v752, [], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v726], []), node(v726, [], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704, v704], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704, v718], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718, v704], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718, v718], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704], [v718]), node(v758, [], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718], [v718]), node(v758, [], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v726], [v718]), node(v726, [], [])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704], [v718, v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718], [v718, v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704, v704], [v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704, v718], [v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718, v704], [v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718, v718], [v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704, v704], [v718, v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v704, v718], [v718, v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718, v704], [v718, v718])]).
:- jestEFGrafem([node(v704, [], []), node(v718, [v718, v718], [v718, v718])]).


%NOK
:- \+ jestEFGrafem([node(v4164, [], [v4188]), node(v4186, [], []),b]).

:- \+ jestEFGrafem([node(v4164, [], [v4188]), node(v4186, [], [])]).
:- \+ jestEFGrafem([node(v4164, [v4188], []), node(v4186, [], [])]).
:- \+ jestEFGrafem([node(v4164, [], []), node(v4186, [v4188], [])]).
:- \+ jestEFGrafem([node(v4164, [], [v4188]), node(v4186, [], [])]).
:- \+ jestEFGrafem([node(v4164, [], [v4186]), node(v4186, [], [v4188])]).

:- \+ jestEFGrafem([node(v4168, [], [v4182]), node(v4182, [], []), node(v4214, [], [])]).
:- \+ jestEFGrafem([node(v4168, [], [v4182]), node(v4182, [v4168], []), node(v4214, [], [])]).
:- \+ jestEFGrafem([node(v4168, [], [v4214,v4182]), node(v4182, [v4168], [v4168]), node(v4214, [], [])]).

:- \+ jestEFGrafem([node(v4168, [], []), node(v4182, [], [v4168]), node(v4214, [], [])]).

:- \+ jestEFGrafem([node(v704, [], []), node(v718, [v718, v718], [v704, v718])]).

:- \+ jestEFGrafem([node(v704, [], []), node(v704, [], []),node(v718, [v718, v718], [v704, v718])]).
:- \+ jestEFGrafem([node(v704, [], []), node(v718, [v718, v718], [v704, v718]),node(v718, [v718, v718], [v704, v718])]).
