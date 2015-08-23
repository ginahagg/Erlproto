-module(proto_handler_tests).
-include_lib("eunit/include/eunit.hrl").

handle_msg_test() ->
    Msg = <<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,2,24,2>>,
    Bin = <<10,9,102,97,99,116,111,114,105,97,108,16,2,24,2>>,
    NextQ = <<10,9,102,97,99,116,111,114,105,97,108,16,4,24,0>>,
    Send = <<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,4,24,0>>,

    ?assertEqual({meta,factorial,Bin} ,
    	meta_proto:decode_msg(Msg,meta)),
	?assertEqual(NextQ ,
    	proto_handler:handle_msg(factorial,Bin)),
	?assertEqual(Send ,
    	meta_proto:encode_msg({meta,factorial,NextQ})).




%handle_decoded_test()->
    %Length is -3,because websocket client adds 5 to the length for square in previous answer, and asks for the next question. So, it should return 2 for square length.
	%Length = -3,
	%Width is -1,because websocket client adds 5 to the width for rectangle in previous answer, and asks for the next question. So, it should return 4 for rect width.		
	%Width = -1,
	%N is -0,because websocket client adds 4 to the number in previous answer, and asks the next question. So, it should return 4 next factorial question.
	%N = 0,
	
	%?assertEqual(<<10,12,97,114,101,97,111,102,115,113,117,97,114,101,16,2,34,4,115,113,102,116>>,
	%	proto_handler:handle_decoded(areaofsquare,{"areaofsquare",Length, undefined,"sqft"})),
	%?assertEqual({areaofsquare,"areaofsquare",2, undefined,"sqft"} ,
	%	math_calcul:decode_msg(<<10,12,97,114,101,97,111,102,115,113,117,97,114,101,16,2,34,4,115,113,102,116>>,areaofsquare)),

    %?assertEqual(<<10,15,97,114,101,97,111,102,114,101,99,116,97,110,103,108,101,16,2,24,4,42,4,115,113,102,116>> ,
    %	proto_handler:handle_decoded(areaofrectangle,{"areaofrectangle",Length, Width, undefined,"sqft"})),

	%?assertEqual({areaofrectangle,"areaofrectangle",2, 4, undefined,"sqft"} , 
	%    math_calcul:decode_msg(<<10,15,97,114,101,97,111,102,114,101,99,116,97,110,103,108,101,16,2,24,4,42,4,115,113,102,116>>,areaofrectangle)),

    %<<10,9,102,97,99,116,111,114,105,97,108,16,2>>
	%?assertEqual(<<10,9,102,97,99,116,111,114,105,97,108,16,2>> ,
    %	proto_handler:handle_decoded(factorial,{"factorial", N, undefined})),

	%?assertEqual({factorial,"factorial",4, undefined},
	%	math_calcul:decode_msg(<<10,9,102,97,99,116,111,114,105,97,108,16,4>>,factorial)).


%%Question = math_calcul:encode({areaofsquare,4,undefined,"sqft"}),
    %%Msg = meta_proto:encode({meta,math_calcul,Question}),

other_tests_() ->
%% protobuf encoding/decoding tests.
[
	?_assertEqual(<<10,12,97,114,101,97,111,102,115,113,117,97,114,101,16,2,34,4,115,113,102,116>>,
		proto_handler:handle_decoded(areaofsquare,{<<"areaofsquare">>,2, undefined,<<"sqft">>})),
	
	?_assertEqual({areaofsquare,<<"areaofsquare">>,2, undefined,<<"sqft">>} ,
		math_calcul:decode_msg(<<10,12,97,114,101,97,111,102,115,113,117,97,114,101,16,2,34,4,115,113,102,116>>,areaofsquare)),

    ?_assertEqual(<<10,15,97,114,101,97,111,102,114,101,99,116,97,110,103,108,101,16,2,24,4,42,4,115,113,102,116>> ,
    	proto_handler:handle_decoded(areaofrectangle,{<<"areaofrectangle">>,2, 4, undefined,<<"sqft">>})),

	?_assertEqual({areaofrectangle,"areaofrectangle",2, 4, undefined,"sqft"} , 
		math_calcul:decode_msg(<<10,15,97,114,101,97,111,102,114,101,99,116,97,110,103,108,101,16,2,24,4,42,4,115,113,102,116>>,areaofrectangle)),

	?_assertEqual(<<10,9,102,97,99,116,111,114,105,97,108,16,4>> ,
    	proto_handler:handle_decoded(factorial,{<<"factorial">>, 4, undefined})),

	?_assertEqual({factorial,"factorial",4, undefined},
		math_calcul:decode_msg(<<10,9,102,97,99,116,111,114,105,97,108,16,4>>,factorial))

].

