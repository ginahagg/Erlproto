-module(proto_handler).
-compile(export_all).
-compile([{parse_transform, lager_transform}]).

handle_msg(factorial, Bin) ->
    Dcoded = math_calcul:decode_msg(Bin, factorial),
    lager:info("Dcoded: ~p ~n",[Dcoded]),
    handle_decoded(factorial,Dcoded);


handle_msg(_MsgName, Bin) ->
    lager:info("I am not interested in this message: ~p~n", [Bin]),
    %erlang:error(stop_sending_me_garbage),
    <<"stop_sending_me_garbage">>.

decode_nested_message(factorial, Bin) ->
    Decoded = math_calcul:decode_msg(Bin, factorial),
    lager:info("Decoded: ~p ~n",[Decoded]),
    Decoded.

handle_decoded(factorial, Dcoded) when is_list(Dcoded) ->
    [handle_decoded(factorial,M) || M <- Dcoded];

handle_decoded(factorial,{factorial,Name, Number, Result}) when Number < 20 ->
     %Prepare next factorial question. Add 2 to prev number.
     lager:info("server answer: factorial of ~p is ~p~n",[Number,Result]),
     NextNumber = Number + 1,
     lager:info("NextNumber: ~p",[NextNumber]),
     NextQ = math_calcul:encode_msg({factorial,Name,NextNumber, 0}),
     lager:info("NextQ: ~p~n",[NextQ]),
     NextQ;

%%if Number reached 20, we will stop sending.
handle_decoded(factorial,{factorial,_Name, _Number, _Result}) ->
     no_more_questions.

encodeFactorialMessage(Number) ->   
    Q = math_calcul:encode_msg({factorial,<<"factorial">>,Number, 0}),
    lager:info("Encoded: {factorial,<<\"factorial\">>,~p, 0} = ~p~n",[Number,Q]),
    M = meta_proto:encode_msg({meta,factorial,Q}),
    lager:info("Encoded with meta for final sendoff: ~p~n",[M]),
    M.

