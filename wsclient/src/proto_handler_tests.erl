-module(proto_handler_tests).
-include_lib("eunit/include/eunit.hrl").

setup() ->
    ok.
cleanup(_) ->
    ok.

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


