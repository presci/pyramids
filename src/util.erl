-module(util).
-export([qsort/1, get_cell/2, create_row/5, calculate/2]).
-export([test01/0, test02/0, test03/0, test04/1, test05/0, test06/0]).
-export([test07/0]).


-include("hpyr.hrl").

%%  record(pyramid, {brick, ty, base, row=0,col=0,val}).


qsort([])->
	[];
qsort([H|T]) ->
	qsort([ X || X <- T, X#pyramid.brick < H#pyramid.brick ]) ++ [H] ++ qsort([ X || X <- T, X#pyramid.brick >= H#pyramid.brick ]).



%% --------------
%% test
%% --------------

test01()->
	A0=#pyramid{brick=5, ty=0, base=0, row=0,col=0, val=0},
	A1=#pyramid{brick=14, ty=0, base=0, row=0,col=5, val=14},
	get_cell([A0,A1], 0).


test02()->
	K=test_data(),
	get_cell(K, 22).

test03()->
	K=test_data(),
	get_cell(K, 5).

test04(B)->
	K=test_data(),
	get_cell(K, B).

test05()->
	get_cell([], 12).

test06()->
	A1=#pyramid{brick=5, ty=0, base=0, row=0,col=0,val=0},
	create_row(A1,[],[],29,0).
test07()->
	A1=#pyramid{brick=5, ty=0, base=0, row=0,col=0, val=0},
	A2=#pyramid{brick=14, ty=0, base=0, row=0,col=0, val=0},
	A3=#pyramid{brick=21, ty=0, base=0, row=0,col=0, val=0},
	K=create_row(A1,[],[],29,0),
	G=create_row(A2,[],K, 29,0),
	H=create_row(A3,[],G,29,0),
	D=[K, G, H],
	D.


test_data()->
	A0=#pyramid{brick=0, ty=0, base=0, row=0,col=0, val=0},
	A1=#pyramid{brick=5, ty=0, base=0, row=0,col=5, val=5},
	A2=#pyramid{brick=14, ty=0, base=0, row=0,col=14, val=14},
	A3=#pyramid{brick=29, ty=0, base=0, row=0,col=29, val=23},
	[A0,A1,A2,A3].



%% -----------------
%% Get Cell function
%% -----------------
get_cell([], _) ->
	A0=#pyramid{brick=0, ty=0, base=0, row=0,col=0, val=0},
	A0;
get_cell([H|T], G)->
    fold( fun(A, B, C) 
		when A#pyramid.col > C -> B; 
		(A, B, C ) when B#pyramid.col > C -> A; 
		(A,B,_C) when B#pyramid.col > A#pyramid.col -> B; 
		(A, B,_C) when A#pyramid.col > B#pyramid.col -> A 
		end, H, G, T).

fold(_, Start, _C, []) -> Start; 
fold(F, Start, C, [H|T]) -> fold ( F, F(H, Start, C),C, T).


%% -----------------
%% Create a row
%% the current pyramid = K
%% Cells  = M
%% The previous row = J
%% The Total Bricks cols maybe 29 = C
%% The current Cell = G
%% -----------------
create_row(K,[],[],C,_G) when C >= K#pyramid.brick->
	V=K#pyramid.brick,
	A0=K#pyramid{col=0, val=0},
	A1=K#pyramid{col=5, val=V},
	[A0,A1];
create_row(K,[],[],C,_G) when K#pyramid.brick > C ->
	{error};
create_row(K,[],J,C,G) ->
	%% ---------  io:format("~wover here~n", [K]),
	A0=K#pyramid{col=0, val=0},
	create_row(K,[A0],J,C, G+1);
create_row(_, M, _, C, G) when G > C ->
	M; 
create_row(K, M, J, C, G) when K#pyramid.brick> G->
	J0=get_cell(J, G),
	K0=get_cell(M, G),
	%% ----- io:format("create row ~w > ~w  ~w~n", [G, K, J0]),
	case J0#pyramid.val /= K0#pyramid.val of
		true ->
			K1=K0#pyramid{col=G,val=J0#pyramid.val},
			create_row(K, [K1|M], J, C, G+1);
		false ->
			create_row(K, M, J, C, G+1)
	end;
create_row(K, M, J, C, G) when G >=K#pyramid.brick ->
	J0=get_cell(J, G),
	J1=get_cell(J, G-K#pyramid.brick),
	T0=J1#pyramid.val + K#pyramid.brick,
	Curr=get_cell(M, G),
	case create_cell(Curr,J0, T0, G) of
		{ok, S} ->
			create_row(K, [S|M], J, C, G+1);
		{none} ->
			create_row(K, M, J, C, G+1)
	end.


%% -----------------
create_cell(CurrM, CurrJ, Cmval, _) when Cmval >= CurrJ#pyramid.val andalso CurrM#pyramid.val == Cmval ->
	{none};
create_cell(CurrM, CurrJ, Cmval, Col) when Cmval >= CurrJ#pyramid.val andalso CurrM#pyramid.val /= Cmval ->
	A0=CurrM#pyramid{val=Cmval, col=Col},
	{ok, A0};
create_cell(CurrM, CurrJ, Cmval, _) when CurrJ#pyramid.val > Cmval andalso CurrM#pyramid.val == Cmval ->
	{none};
create_cell(CurrM, CurrJ, Cmval,  Col) when CurrJ#pyramid.val > Cmval andalso CurrM#pyramid.val /= Cmval ->
	A0=CurrJ#pyramid{val=Cmval, col=Col},
	{ok, A0}.


%% -----------------
calculate(A, B)->
	calculate(A, [], B).

calculate([], G, _) ->
	G;
calculate([H|T], [], B) ->
	case fold1(H, T, B) of
		{ok, S} ->
			%% ------ io:format("calculate 1 ~w~n", [S]),
			calculate(T, [S], B-S#pyramid.brick);
		{na} ->
			calculate(T, [], B)
	end;
calculate([H|T], G, B) ->
	case fold1(H,T, B) of 
		{ok, S} ->
			%% ------ io:format("calculate 2 ~w &   ~w~n", [S, G]),
			calculate(T, [S|G], B-S#pyramid.brick);
		{na} ->
			calculate(T, G, B)
	end.



fold1(Start,[], B) ->
	A0=get_cell(Start, B),
	case A0#pyramid.col >= A0#pyramid.brick of
		true ->
			{ok, A0};
		false ->
			{na}
	end;
fold1(Start, [H|_], B) ->
	A0=get_cell(Start, B),
	H0=get_cell(H, B),
	case A0#pyramid.val /= H0#pyramid.val andalso A0#pyramid.col >= A0#pyramid.brick of
		true ->
			{ok, A0};
		false ->
			{na}
	end.
	
	


	
	
	

	







