-module(pyramid).
-export([start/0, test_h_base/0, test_h_pyramid/0, test_l_even_base/0, test_l_odd_base/0]).



-record(pyramid, {brick, ty, base}).


start() ->
	Bricks=28,
	_P=get_pyramid_list(Bricks),
	_P.

test_h_base()->
	make_h_pyramid_w_base(4, 0).
test_l_even_base()->
	make_l_pyramid_w_base(4,0).
test_l_odd_base()->
	make_l_pyramid_w_base(3,0).


test_h_pyramid()->
	get_pyramid_list(48).



get_pyramid_list(_Bricks)->
	H_pyramid=get_h_pyramid(_Bricks,2, 5,[]),
	H_pyramid.

get_h_pyramid(_Bricks, _, _Brick, Acc)
	when _Brick > _Bricks ->
	Acc;
get_h_pyramid(_Bricks, Base, _Brick, Acc)
	when Base == 2 andalso _Bricks> _Brick->
	Py=#pyramid{brick=5, ty=0, base=Base},
	K= Acc ++[Py],
	G=make_h_pyramid_w_base(Base+1, 0),
	get_h_pyramid(_Bricks, Base+1, G, K);
get_h_pyramid(_Bricks, Base, _Brick, Acc)
	when Base > 2 andalso _Bricks > _Brick->
	Py=#pyramid{brick=_Brick, ty=0, base=Base},
	K=Acc++[Py],
	G=make_h_pyramid_w_base(Base+1,0),
	get_h_pyramid(_Bricks, Base+1, G, K).


get_l_pyramid(_Bricks, _, _Brick, Acc)
	when _Brick > _Bricks ->
	Acc;
get_l_pyramid(_Bricks, Base, _Brick, Acc)
	when Base==0 andalso _Bricks >= 10 ->
	K=Acc ++[10],
	G=make_l_pyramid_w_base(Base+4, 0),
	get_l_pyramid(_Bricks, 4, G, K);
get_l_pyramid(_Bricks, Base, _Brick, Acc)
	when Base > 2 andalso _Bricks > _Brick->
	K=Acc ++[_Brick],
	G=make_l_pyramid_w_base(Base+1,0),
	get_l_pyramid(_Bricks, Base+1, G, K).





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



make_h_pyramid_w_base(Base, A) when Base < 1 ->
	A;
make_h_pyramid_w_base(Base, A) ->
	K=Base *Base,
	make_h_pyramid_w_base(Base -1, K+A).

