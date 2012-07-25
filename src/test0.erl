-module(test0).
-export([test01/0, test02/0,test03/0, test04/0]).


test01()->
	K=[8,3,4,7,5,9,8,4,75],
	K.


test02()->
	K=[20],
	blizz(K).


test03()->
	K=20,
	blizz(K).
test04()->
	K=[2,93,48,03,29,48],
	blizz(K).

blizz([K])->
	io:format("with array~n"),
	K;
blizz(K)->
	io:format("without array~n"),
	K.

