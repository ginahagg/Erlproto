-module(protobuf_handler).
-export([handle_msg/2,handle_decoded/2]).

handle_msg(areaofsquare, Bin) ->
    Dcoded = math_calcul:decode_msg(Bin, areaofsquare),
    handle_decoded(areaofsquare,Dcoded);

handle_msg(areaofrectangle, Bin) ->
    Dcoded = math_calcul:decode_msg(Bin, areaofrectangle),
    handle_decoded(areaofrectangle,Dcoded);

handle_msg(factorial, Bin) ->
    lager:info("factorial question is asked: ~p~n",[Bin]),
    Dcoded = math_calcul:decode_msg(Bin, factorial),
    handle_decoded(factorial,Dcoded);

handle_msg(short,Bin) ->
    Dcoded = short:decode_msg(Bin,short),
    handle_decoded(short,Dcoded);

handle_msg(_MsgName, Bin) ->
lager:warning("not interested!!: ~p~n", [Bin]),
<<"stop_sending_me_garbage">>.

handle_decoded(short,Dcoded) when is_list(Dcoded) ->
    [handle_decoded(short,M) || M <- Dcoded];

handle_decoded(short,{_Mod, Name, Email}) ->
    lager:info("name and email: ~s, ~s ~n",[Name,Email]),
    Name;

handle_decoded(areaofsquare,Dcoded) when is_list(Dcoded) ->
    [handle_decoded(areaofsquare,M) || M <- Dcoded];

handle_decoded(areaofsquare,{areaofsquare,Name, Length, _Area, Unit}) ->
    lager:info("Question is: What is Area for a square with side length of ~s in ~s?~n",[Length,Unit]),
    Area = Length * Length,
    _Answer = math_calcul:encode_msg({areaofsquare,Name,Length, Area,Unit});

handle_decoded(areaofrectangle,Dcoded) when is_list(Dcoded) ->
    [handle_decoded(areaofrectangle,M) || M <- Dcoded];

handle_decoded(areaofrectangle,{areaofrectangle,Name, Length, Width, _Area, Unit}) ->
    lager:info("Question is: What is Area for a rectangle with sides ~s and ~s in ~s?~n",[Length, Width,Unit]),
    Area = Length * Width,
    _Answer = math_calcul:encode_msg({areaofrectangle,Name,Length, Width, Area, Unit});
    

handle_decoded(factorial, Dcoded) when is_list(Dcoded) ->
    [handle_decoded(factorial,M) || M <- Dcoded];

handle_decoded(factorial,{factorial,Name, Number, _Result}) ->
        io:format("Question is: What is the Factorial of ~p?~n",[Number]),
    Result = factorial(Number),
    io:format("result:~p~n",[Result]),
    _Answer = math_calcul:encode_msg({factorial,Name,Number, Result}).
    

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N-1).