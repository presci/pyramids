%%
%% hypr.hrl
%%
%% record for pyramid
%%


%%
%% brick = No of bricks
%% type = [01]
%% base = No of brick at the base
%%


%%
%% Type of pyramid
%% high pyramid =0
%% low pyramid =1
%%

-record(pyramid, {brick, ty, base, row=0,col=0,val=0}).
