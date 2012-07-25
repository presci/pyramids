-module(highpyramid).
-export([get_pyramid_list/1]).
-export([test_h_pyramid/0]).


-include("hpyr.hrl").

test_h_pyramid()->
	get_pyramid_list(48).


get_pyramid_list(_Bricks)->
	H_pyramid=get_h_pyramid(_Bricks,2, 5,[]),
	lists:reverse(H_pyramid).

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


make_h_pyramid_w_base(Base, A) when Base < 1 ->
	A;
make_h_pyramid_w_base(Base, A) ->
	K=Base *Base,
	make_h_pyramid_w_base(Base -1, K+A).
