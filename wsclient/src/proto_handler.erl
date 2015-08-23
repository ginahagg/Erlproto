-module(proto_handler).
-export([handle_decoded/2,handle_msg/2]).

handle_msg(areaofsquare, Bin) ->
    Dcoded = math_calcul:decode_msg(Bin, areaofsquare),
    io:format("Dcoded: ~p ~n",[Dcoded]),
    handle_decoded(areaofsquare,Dcoded);

handle_msg(areaofrectangle, Bin) ->
    Dcoded = math_calcul:decode_msg(Bin, areaofrectangle),
    io:format("Dcoded: ~p ~n",[Dcoded]),
    handle_decoded(areaofrectangle,Dcoded);

handle_msg(factorial, Bin) ->
    Dcoded = math_calcul:decode_msg(Bin, factorial),
    io:format("Dcoded: ~p ~n",[Dcoded]),
    handle_decoded(factorial,Dcoded);

handle_msg(short,Bin) ->
    Dcoded = short:decode_msg(Bin,short),
    io:format("Dcoded: ~p ~n",[Dcoded]),
    handle_decoded(short,Dcoded);

handle_msg(_MsgName, Bin) ->
    io:format("I am not interested in this message: ~p~n", [Bin]),
    %erlang:error(stop_sending_me_garbage),
    <<"stop_sending_me_garbage">>.

handle_decoded(short,Dcoded) when is_list(Dcoded) ->
    [handle_decoded(short,M) || M <- Dcoded];

handle_decoded(short,{_Mod, Name, _Email}) ->
    Name;

handle_decoded(areaofsquare,Dcoded) when is_list(Dcoded) ->
    [handle_decoded(areaofsquare,M) || M <- Dcoded];

handle_decoded(areaofsquare,{_Name, Length, Area, Unit}) ->
     Len4NextQ = Length + 5,
     math_calcul:encode_msg({areaofsquare,<<"areaofsquare">>, Len4NextQ , 0,Unit});
    

handle_decoded(areaofrectangle,Dcoded) when is_list(Dcoded) ->
    [handle_decoded(areaofrectangle,M) || M <- Dcoded];

handle_decoded(areaofrectangle,{_Name, Length, Width, Area, Unit}) ->
    Len4NextQ = Length + 5,
    Wid4NextQ = Width + 5,
    math_calcul:encode_msg({areaofrectangle,<<"areaofrectangle">>,Len4NextQ,Wid4NextQ, 0,Unit});

handle_decoded(factorial, Dcoded) when is_list(Dcoded) ->
    [handle_decoded(factorial,M) || M <- Dcoded];

handle_decoded(factorial,{factorial,Name, Number, Result}) when Number < 50 ->
     %Prepare next factorial question. Add 2 to prev number.
     NextNumber = Number + 2,
     io:format("NextNumber: ~p",[NextNumber]),
     NextQ = math_calcul:encode_msg({factorial,Name,NextNumber, 0}),
     io:format("NextQ: ~p~n",[NextQ]),
     NextQ;

%if Number reached 50, we will stop sending.
handle_decoded(factorial,{factorial,_Name, _Number, _Result}) ->
     no_more_questions.
