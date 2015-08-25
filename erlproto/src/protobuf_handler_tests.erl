-module(protobuf_handler_tests).
-author("Gina Hagg <ghagg@yahoo.com").
-include_lib("eunit/include/eunit.hrl").


setup() ->
    ok.
cleanup(_) ->
    ok.

handle_msg_test() ->
    %coded below({factorial,<<"factorial">>,4,0})-->factorial of 4 question  
    FactorialMessage = {factorial,<<"factorial">>,4,0}, 
    EncodedFactorial = <<10,9,102,97,99,116,111,114,105,97,108,16,4,24,0>>,
    %Msg = <<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,2,24,2>>,
    %below is encoded (meta,factorial,{factorial,<<"factorial">>,4,0})
    EncodedMeta = <<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,4,24,0>>,
    Answer = <<10,9,102,97,99,116,111,114,105,97,108,16,4,24,24>>,
    EncodedAnswerPayload = <<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,4,24,24>>,
    EncodedQuestion = {factorial,"factorial",4,0},  %{factorial,"factorial",4,0}

    %%Protobuf compiled message classes are math_calcul and meta_proto.
    %%encode
    %%This is the sequence websocket server follows when it receives a payload.

    ?assertEqual({factorial,EncodedFactorial} ,
        protobuf_handler:decode_incoming_payload(EncodedMeta)),
    
    EncodedQ = protobuf_handler:decode_nested_question(EncodedFactorial,factorial),
    io:format("encodedq: ~p~n",[EncodedQ]),
    ?assertEqual(EncodedQ,EncodedQuestion),

    DecodedAnswer = protobuf_handler:decode_nested_question_and_get_answer(factorial,EncodedFactorial),
    ?assertEqual(Answer, DecodedAnswer),
    
    %%reverse
    ?assertEqual(EncodedAnswerPayload ,
        protobuf_handler:encode_outgoing_payload(factorial,DecodedAnswer)).


