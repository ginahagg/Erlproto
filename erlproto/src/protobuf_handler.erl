-module(protobuf_handler).
-author("Gina Hagg <ghagg@yahoo.com").
-export([decode_nested_question_and_get_answer/2,calculate_answer_and_decode/2, decode_incoming_payload/1, encode_outgoing_payload/2,
	decode_nested_question/2]).
-compile([{parse_transform, lager_transform}]).


decode_nested_question_and_get_answer(factorial, Bin) ->
    lager:info("factorial question is asked: ~p~n",[Bin]),
    DcodedQuestion = decode_nested_question(Bin, factorial),
    calculate_answer_and_decode(factorial,DcodedQuestion);


decode_nested_question_and_get_answer(_MsgName, Bin) ->
lager:warning("not interested!!: ~p~n", [Bin]),
<<"stop_sending_me_garbage">>.
 
decode_nested_question(Bin,factorial) ->
	math_calcul:decode_msg(Bin, factorial). 

calculate_answer_and_decode(factorial, Dcoded) when is_list(Dcoded) ->
    [calculate_answer_and_decode(factorial,M) || M <- Dcoded];

calculate_answer_and_decode(factorial,{factorial,Name, Number, _Result}) ->
    lager:info("Question is: What is the Factorial of ~p?~n",[Number]),
    Result = factorial(Number),
    lager:info("result:~p~n",[Result]),
    %Answer is below.
    math_calcul:encode_msg({factorial,Name,Number, Result}).

 decode_incoming_payload(Msg) ->
 	{meta, MsgName, Bin} = meta_proto:decode_msg(Msg,meta),
    lager:info("~p question: {~p}~n", [MsgName,Msg]),
    {MsgName,Bin}.

 encode_outgoing_payload(MsgName, Recvd) ->
 	Resp = meta_proto:encode_msg({meta,MsgName,Recvd}),
    lager:info("answer: ~p~n", [Resp]),
    Resp.
    

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N-1).