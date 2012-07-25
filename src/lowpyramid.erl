-module(lowpyramid).
-export([test_l_even_base/0, test_l_odd_base/0, test_pyramid/1]).
-export([get_pyramid_list/1]).

-include("hpyr.hrl").

test_l_even_base()->
	make_l_pyramid_w_base(4,0).
test_l_odd_base()->
	make_l_pyramid_w_base(3,0).

test_pyramid(B)->
    get_pyramid_list(B).

%%
%% low pyramid = 1
%%
%%
get_pyramid_list(_Bricks) when _Bricks > 0 ->
    L=get_l_pyramid(_Bricks, 3, 10,[]),
	lists:reverse(L).


get_l_pyramid(_Bricks, _, _Brick, Acc)
	when _Brick > _Bricks ->
	Acc;
get_l_pyramid(_Bricks, Base, _Brick, [])
	when _Bricks >= _Brick ->
	K=#pyramid{brick=_Brick, ty=1, base=Base},
	G=make_l_pyramid_w_base(Base+1, 0),
	get_l_pyramid(_Bricks, Base+1, G, [K]);
get_l_pyramid(_Bricks, Base, _Brick, Acc)
	when Base > 2 andalso _Bricks >= _Brick->
	Py=#pyramid{brick=_Brick, ty=1, base=Base},
	G=make_l_pyramid_w_base(Base+1,0),
	get_l_pyramid(_Bricks, Base+1, G, [Py|Acc]).


make_l_pyramid_w_base(Base, A)
	when Base > 1 andalso (Base rem 2 == 0)->
	make_l_pyramid_w_base(even, Base, A);
make_l_pyramid_w_base(Base, A)
	when Base > 1 andalso (Base rem 2 /= 0)->
	make_l_pyramid_w_base(odd, Base, A).

make_l_pyramid_w_base(even, Base, A)
	when Base =< 1 ->
	A;
make_l_pyramid_w_base(even, Base, A)
	when Base > 1 ->
	K=Base * Base,
	make_l_pyramid_w_base(even,Base -2, K+A);
make_l_pyramid_w_base(odd, Base, A)
	when Base =< 0 ->
	A;
make_l_pyramid_w_base(odd, Base, A)
	when Base > 0 ->
	K=Base * Base,
	make_l_pyramid_w_base(odd, Base -2, K+A).





