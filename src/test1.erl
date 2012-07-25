-module(test1).
-export([start/1]).

start(B)->
	K=[80,90,10,30,20,70,40],
	get_cell(K, B).


get_cell([H|T], G)->
	fold( fun(A, B, C) 
		when 
			A > C ->
			B;
		(A, B, C ) 
			when B > C ->
			A;
		(A,B,C)
		when
			B > A ->
			B;
		(A, B, C)  
			when  
			A > B ->
			A
	end,
	H, G, T).
		
			

fold(_, Start, C, []) -> Start;
fold(F, Start, C, [H|T]) -> fold ( F, F(H, Start, C),C, T).

