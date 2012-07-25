-module(pyr).
-export([test/1, start/1]).

-include("hpyr.hrl").

test(B)->
	H=highpyramid:get_pyramid_list(B),
	L=lowpyramid:get_pyramid_list(B),
	K=L++H,
	G=util:qsort(K),
	G.

	

start(B)->
	H=highpyramid:get_pyramid_list(B),
	L=lowpyramid:get_pyramid_list(B),
	K=L++H,
	P=util:qsort(K),
	All=start(P, [], B),
	case validate(All, B) of 
		{ok, S} ->
			J=util:calculate(S, B),
			case end_validate(J,J) of
				{nada} ->
					io:format("impossible to build~n");
				{ok, So} ->
					print(So)
				end;
		{nada} ->
			io:format("impossible to build~n")
	end.

start([],M, _)->
	M;
start([H|T], [], G) ->
	A0=util:create_row(H,[],[], G, 0),
	start(T,[A0], G);
start([H|T], [K|M], G) ->
	A0=util:create_row(H,[], K, G, 0),
	start(T, [A0,K|M], G).

validate([],  _) ->
	{nada};
validate ([H|T],B)->
	V0=util:get_cell(H, B),
	case  V0#pyramid.val == B andalso V0#pyramid.ty ==0 of
		true ->
			{ok, [H|T]};
		false ->
			validate(T, B)
	end.

end_validate([], _K) ->
	{nada};
end_validate([H|_T],K) 
	when H#pyramid.ty == 0 ->
	{ok,K};
end_validate([_H|T], K) ->
	end_validate(T, K).

print([])->
	io:format("~n");
print([H|T]) when H#pyramid.ty ==0 ->
	io:format("~wH ", [H#pyramid.base]),
	print(T);
print([H|T]) when H#pyramid.ty ==1 ->
	io:format("~wB ", [H#pyramid.base]),
	print(T).
