%% Automatically generated, do not edit
%% Generated by gpb_compile version 3.18.8 on {{2015,8,24},{21,16,16}}
-module(short).

-export([encode_msg/1, encode_msg/2]).
-export([decode_msg/2]).
-export([merge_msgs/2]).
-export([verify_msg/1]).
-export([get_msg_defs/0]).
-export([get_msg_names/0]).
-export([get_enum_names/0]).
-export([find_msg_def/1, fetch_msg_def/1]).
-export([find_enum_def/1, fetch_enum_def/1]).
-export([enum_symbol_by_value/2, enum_value_by_symbol/2]).
-export([get_service_names/0]).
-export([get_service_def/1]).
-export([get_rpc_names/1]).
-export([find_rpc_def/2, fetch_rpc_def/2]).
-export([get_package_name/0]).
-export([gpb_version_as_string/0, gpb_version_as_list/0]).

-include("short.hrl").
-include("gpb.hrl").


encode_msg(Msg) -> encode_msg(Msg, []).


encode_msg(Msg, Opts) ->
    case proplists:get_bool(verify, Opts) of
      true -> verify_msg(Msg);
      false -> ok
    end,
    case Msg of #short{} -> e_msg_short(Msg) end.


e_msg_short(Msg) -> e_msg_short(Msg, <<>>).


e_msg_short(#short{name = F1, email = F2}, Bin) ->
    B1 = e_type_string(F1, <<Bin/binary, 10>>),
    if F2 == undefined -> B1;
       true -> e_type_string(F2, <<B1/binary, 18>>)
    end.

e_type_string(S, Bin) ->
    Utf8 = unicode:characters_to_binary(S),
    Bin2 = e_varint(byte_size(Utf8), Bin),
    <<Bin2/binary, Utf8/binary>>.

e_varint(N, Bin) when N =< 127 -> <<Bin/binary, N>>;
e_varint(N, Bin) ->
    Bin2 = <<Bin/binary, (N band 127 bor 128)>>,
    e_varint(N bsr 7, Bin2).



decode_msg(Bin, MsgName) when is_binary(Bin) ->
    case MsgName of short -> d_msg_short(Bin) end.



d_msg_short(Bin) ->
    dfp_read_field_def_short(Bin, 0, 0, undefined,
			     undefined).

dfp_read_field_def_short(<<10, Rest/binary>>, Z1, Z2,
			 F1, F2) ->
    d_field_short_name(Rest, Z1, Z2, F1, F2);
dfp_read_field_def_short(<<18, Rest/binary>>, Z1, Z2,
			 F1, F2) ->
    d_field_short_email(Rest, Z1, Z2, F1, F2);
dfp_read_field_def_short(<<>>, 0, 0, F1, F2) ->
    #short{name = F1, email = F2};
dfp_read_field_def_short(Other, Z1, Z2, F1, F2) ->
    dg_read_field_def_short(Other, Z1, Z2, F1, F2).

dg_read_field_def_short(<<1:1, X:7, Rest/binary>>, N,
			Acc, F1, F2)
    when N < 32 - 7 ->
    dg_read_field_def_short(Rest, N + 7, X bsl N + Acc, F1,
			    F2);
dg_read_field_def_short(<<0:1, X:7, Rest/binary>>, N,
			Acc, F1, F2) ->
    Key = X bsl N + Acc,
    case Key of
      10 -> d_field_short_name(Rest, 0, 0, F1, F2);
      18 -> d_field_short_email(Rest, 0, 0, F1, F2);
      _ ->
	  case Key band 7 of
	    0 -> skip_varint_short(Rest, 0, 0, F1, F2);
	    1 -> skip_64_short(Rest, 0, 0, F1, F2);
	    2 -> skip_length_delimited_short(Rest, 0, 0, F1, F2);
	    5 -> skip_32_short(Rest, 0, 0, F1, F2)
	  end
    end;
dg_read_field_def_short(<<>>, 0, 0, F1, F2) ->
    #short{name = F1, email = F2}.

d_field_short_name(<<1:1, X:7, Rest/binary>>, N, Acc,
		   F1, F2)
    when N < 57 ->
    d_field_short_name(Rest, N + 7, X bsl N + Acc, F1, F2);
d_field_short_name(<<0:1, X:7, Rest/binary>>, N, Acc, _,
		   F2) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_short(Rest2, 0, 0, NewFValue, F2).


d_field_short_email(<<1:1, X:7, Rest/binary>>, N, Acc,
		    F1, F2)
    when N < 57 ->
    d_field_short_email(Rest, N + 7, X bsl N + Acc, F1, F2);
d_field_short_email(<<0:1, X:7, Rest/binary>>, N, Acc,
		    F1, _) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_short(Rest2, 0, 0, F1, NewFValue).


skip_varint_short(<<1:1, _:7, Rest/binary>>, Z1, Z2, F1,
		  F2) ->
    skip_varint_short(Rest, Z1, Z2, F1, F2);
skip_varint_short(<<0:1, _:7, Rest/binary>>, Z1, Z2, F1,
		  F2) ->
    dfp_read_field_def_short(Rest, Z1, Z2, F1, F2).


skip_length_delimited_short(<<1:1, X:7, Rest/binary>>,
			    N, Acc, F1, F2)
    when N < 57 ->
    skip_length_delimited_short(Rest, N + 7, X bsl N + Acc,
				F1, F2);
skip_length_delimited_short(<<0:1, X:7, Rest/binary>>,
			    N, Acc, F1, F2) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_short(Rest2, 0, 0, F1, F2).


skip_32_short(<<_:32, Rest/binary>>, Z1, Z2, F1, F2) ->
    dfp_read_field_def_short(Rest, Z1, Z2, F1, F2).


skip_64_short(<<_:64, Rest/binary>>, Z1, Z2, F1, F2) ->
    dfp_read_field_def_short(Rest, Z1, Z2, F1, F2).




merge_msgs(Prev, New)
    when element(1, Prev) =:= element(1, New) ->
    case Prev of #short{} -> merge_msg_short(Prev, New) end.

merge_msg_short(#short{name = PFname, email = PFemail},
		#short{name = NFname, email = NFemail}) ->
    #short{name =
	       if NFname =:= undefined -> PFname;
		  true -> NFname
	       end,
	   email =
	       if NFemail =:= undefined -> PFemail;
		  true -> NFemail
	       end}.



verify_msg(Msg) ->
    case Msg of
      #short{} -> v_msg_short(Msg, [short]);
      _ -> mk_type_error(not_a_known_message, Msg, [])
    end.


v_msg_short(#short{name = F1, email = F2}, Path) ->
    v_type_string(F1, [name | Path]),
    if F2 == undefined -> ok;
       true -> v_type_string(F2, [email | Path])
    end,
    ok.

v_type_string(S, Path) when is_list(S); is_binary(S) ->
    try unicode:characters_to_binary(S) of
      B when is_binary(B) -> ok;
      {error, _, _} ->
	  mk_type_error(bad_unicode_string, S, Path)
    catch
      error:badarg ->
	  mk_type_error(bad_unicode_string, S, Path)
    end;
v_type_string(X, Path) ->
    mk_type_error(bad_unicode_string, X, Path).

mk_type_error(Error, ValueSeen, Path) ->
    Path2 = prettify_path(Path),
    erlang:error({gpb_type_error,
		  {Error, [{value, ValueSeen}, {path, Path2}]}}).


prettify_path([]) -> top_level;
prettify_path(PathR) ->
    list_to_atom(string:join(lists:map(fun atom_to_list/1,
				       lists:reverse(PathR)),
			     ".")).



get_msg_defs() ->
    [{{msg, short},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = required, opts = []},
       #field{name = email, fnum = 2, rnum = 3, type = string,
	      occurrence = optional, opts = []}]}].


get_msg_names() -> [short].


get_enum_names() -> [].


fetch_msg_def(MsgName) ->
    case find_msg_def(MsgName) of
      Fs when is_list(Fs) -> Fs;
      error -> erlang:error({no_such_msg, MsgName})
    end.


fetch_enum_def(EnumName) ->
    erlang:error({no_such_enum, EnumName}).


find_msg_def(short) ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = required, opts = []},
     #field{name = email, fnum = 2, rnum = 3, type = string,
	    occurrence = optional, opts = []}];
find_msg_def(_) -> error.


find_enum_def(_) -> error.


enum_symbol_by_value(E, V) ->
    erlang:error({no_enum_defs, E, V}).


enum_value_by_symbol(E, V) ->
    erlang:error({no_enum_defs, E, V}).



get_service_names() -> [].


get_service_def(_) -> error.


get_rpc_names(_) -> error.


find_rpc_def(_, _) -> error.



fetch_rpc_def(ServiceName, RpcName) ->
    erlang:error({no_such_rpc, ServiceName, RpcName}).


get_package_name() -> 'erproto.short'.



gpb_version_as_string() ->
    "3.18.8".

gpb_version_as_list() ->
    [3,18,8].
