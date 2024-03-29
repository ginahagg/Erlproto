%% Automatically generated, do not edit
%% Generated by gpb_compile version 3.18.8 on {{2015,8,19},{12,39,16}}
-module(message).

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

-include("message.hrl").
-include("gpb.hrl").


encode_msg(Msg) -> encode_msg(Msg, []).


encode_msg(Msg, Opts) ->
    case proplists:get_bool(verify, Opts) of
      true -> verify_msg(Msg);
      false -> ok
    end,
    case Msg of
      #'Location'{} -> e_msg_Location(Msg);
      #'Person'{} -> e_msg_Person(Msg)
    end.


e_msg_Location(Msg) -> e_msg_Location(Msg, <<>>).


e_msg_Location(#'Location'{region = F1, country = F2},
	       Bin) ->
    B1 = e_type_string(F1, <<Bin/binary, 10>>),
    e_type_string(F2, <<B1/binary, 18>>).

e_msg_Person(Msg) -> e_msg_Person(Msg, <<>>).


e_msg_Person(#'Person'{name = F1, address = F2,
		       phone_number = F3, age = F4, location = F5},
	     Bin) ->
    B1 = e_type_string(F1, <<Bin/binary, 10>>),
    B2 = e_type_string(F2, <<B1/binary, 18>>),
    B3 = e_type_string(F3, <<B2/binary, 26>>),
    B4 = e_type_int32(F4, <<B3/binary, 32>>),
    if F5 == undefined -> B4;
       true -> e_mfield_Person_location(F5, <<B4/binary, 42>>)
    end.

e_mfield_Person_location(Msg, Bin) ->
    SubBin = e_msg_Location(Msg, <<>>),
    Bin2 = e_varint(byte_size(SubBin), Bin),
    <<Bin2/binary, SubBin/binary>>.

e_type_int32(Value, Bin)
    when 0 =< Value, Value =< 127 ->
    <<Bin/binary, Value>>;
e_type_int32(Value, Bin) ->
    <<N:32/unsigned-native>> = <<Value:32/signed-native>>,
    e_varint(N, Bin).

e_type_string(S, Bin) ->
    Utf8 = unicode:characters_to_binary(S),
    Bin2 = e_varint(byte_size(Utf8), Bin),
    <<Bin2/binary, Utf8/binary>>.

e_varint(N, Bin) when N =< 127 -> <<Bin/binary, N>>;
e_varint(N, Bin) ->
    Bin2 = <<Bin/binary, (N band 127 bor 128)>>,
    e_varint(N bsr 7, Bin2).



decode_msg(Bin, MsgName) when is_binary(Bin) ->
    case MsgName of
      'Location' -> d_msg_Location(Bin);
      'Person' -> d_msg_Person(Bin)
    end.



d_msg_Location(Bin) ->
    dfp_read_field_def_Location(Bin, 0, 0, undefined,
				undefined).

dfp_read_field_def_Location(<<10, Rest/binary>>, Z1, Z2,
			    F1, F2) ->
    d_field_Location_region(Rest, Z1, Z2, F1, F2);
dfp_read_field_def_Location(<<18, Rest/binary>>, Z1, Z2,
			    F1, F2) ->
    d_field_Location_country(Rest, Z1, Z2, F1, F2);
dfp_read_field_def_Location(<<>>, 0, 0, F1, F2) ->
    #'Location'{region = F1, country = F2};
dfp_read_field_def_Location(Other, Z1, Z2, F1, F2) ->
    dg_read_field_def_Location(Other, Z1, Z2, F1, F2).

dg_read_field_def_Location(<<1:1, X:7, Rest/binary>>, N,
			   Acc, F1, F2)
    when N < 32 - 7 ->
    dg_read_field_def_Location(Rest, N + 7, X bsl N + Acc,
			       F1, F2);
dg_read_field_def_Location(<<0:1, X:7, Rest/binary>>, N,
			   Acc, F1, F2) ->
    Key = X bsl N + Acc,
    case Key of
      10 -> d_field_Location_region(Rest, 0, 0, F1, F2);
      18 -> d_field_Location_country(Rest, 0, 0, F1, F2);
      _ ->
	  case Key band 7 of
	    0 -> skip_varint_Location(Rest, 0, 0, F1, F2);
	    1 -> skip_64_Location(Rest, 0, 0, F1, F2);
	    2 -> skip_length_delimited_Location(Rest, 0, 0, F1, F2);
	    5 -> skip_32_Location(Rest, 0, 0, F1, F2)
	  end
    end;
dg_read_field_def_Location(<<>>, 0, 0, F1, F2) ->
    #'Location'{region = F1, country = F2}.

d_field_Location_region(<<1:1, X:7, Rest/binary>>, N,
			Acc, F1, F2)
    when N < 57 ->
    d_field_Location_region(Rest, N + 7, X bsl N + Acc, F1,
			    F2);
d_field_Location_region(<<0:1, X:7, Rest/binary>>, N,
			Acc, _, F2) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_Location(Rest2, 0, 0, NewFValue, F2).


d_field_Location_country(<<1:1, X:7, Rest/binary>>, N,
			 Acc, F1, F2)
    when N < 57 ->
    d_field_Location_country(Rest, N + 7, X bsl N + Acc, F1,
			     F2);
d_field_Location_country(<<0:1, X:7, Rest/binary>>, N,
			 Acc, F1, _) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_Location(Rest2, 0, 0, F1, NewFValue).


skip_varint_Location(<<1:1, _:7, Rest/binary>>, Z1, Z2,
		     F1, F2) ->
    skip_varint_Location(Rest, Z1, Z2, F1, F2);
skip_varint_Location(<<0:1, _:7, Rest/binary>>, Z1, Z2,
		     F1, F2) ->
    dfp_read_field_def_Location(Rest, Z1, Z2, F1, F2).


skip_length_delimited_Location(<<1:1, X:7,
				 Rest/binary>>,
			       N, Acc, F1, F2)
    when N < 57 ->
    skip_length_delimited_Location(Rest, N + 7,
				   X bsl N + Acc, F1, F2);
skip_length_delimited_Location(<<0:1, X:7,
				 Rest/binary>>,
			       N, Acc, F1, F2) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_Location(Rest2, 0, 0, F1, F2).


skip_32_Location(<<_:32, Rest/binary>>, Z1, Z2, F1,
		 F2) ->
    dfp_read_field_def_Location(Rest, Z1, Z2, F1, F2).


skip_64_Location(<<_:64, Rest/binary>>, Z1, Z2, F1,
		 F2) ->
    dfp_read_field_def_Location(Rest, Z1, Z2, F1, F2).


d_msg_Person(Bin) ->
    dfp_read_field_def_Person(Bin, 0, 0, undefined,
			      undefined, undefined, undefined, undefined).

dfp_read_field_def_Person(<<10, Rest/binary>>, Z1, Z2,
			  F1, F2, F3, F4, F5) ->
    d_field_Person_name(Rest, Z1, Z2, F1, F2, F3, F4, F5);
dfp_read_field_def_Person(<<18, Rest/binary>>, Z1, Z2,
			  F1, F2, F3, F4, F5) ->
    d_field_Person_address(Rest, Z1, Z2, F1, F2, F3, F4,
			   F5);
dfp_read_field_def_Person(<<26, Rest/binary>>, Z1, Z2,
			  F1, F2, F3, F4, F5) ->
    d_field_Person_phone_number(Rest, Z1, Z2, F1, F2, F3,
				F4, F5);
dfp_read_field_def_Person(<<32, Rest/binary>>, Z1, Z2,
			  F1, F2, F3, F4, F5) ->
    d_field_Person_age(Rest, Z1, Z2, F1, F2, F3, F4, F5);
dfp_read_field_def_Person(<<42, Rest/binary>>, Z1, Z2,
			  F1, F2, F3, F4, F5) ->
    d_field_Person_location(Rest, Z1, Z2, F1, F2, F3, F4,
			    F5);
dfp_read_field_def_Person(<<>>, 0, 0, F1, F2, F3, F4,
			  F5) ->
    #'Person'{name = F1, address = F2, phone_number = F3,
	      age = F4, location = F5};
dfp_read_field_def_Person(Other, Z1, Z2, F1, F2, F3, F4,
			  F5) ->
    dg_read_field_def_Person(Other, Z1, Z2, F1, F2, F3, F4,
			     F5).

dg_read_field_def_Person(<<1:1, X:7, Rest/binary>>, N,
			 Acc, F1, F2, F3, F4, F5)
    when N < 32 - 7 ->
    dg_read_field_def_Person(Rest, N + 7, X bsl N + Acc, F1,
			     F2, F3, F4, F5);
dg_read_field_def_Person(<<0:1, X:7, Rest/binary>>, N,
			 Acc, F1, F2, F3, F4, F5) ->
    Key = X bsl N + Acc,
    case Key of
      10 ->
	  d_field_Person_name(Rest, 0, 0, F1, F2, F3, F4, F5);
      18 ->
	  d_field_Person_address(Rest, 0, 0, F1, F2, F3, F4, F5);
      26 ->
	  d_field_Person_phone_number(Rest, 0, 0, F1, F2, F3, F4,
				      F5);
      32 ->
	  d_field_Person_age(Rest, 0, 0, F1, F2, F3, F4, F5);
      42 ->
	  d_field_Person_location(Rest, 0, 0, F1, F2, F3, F4, F5);
      _ ->
	  case Key band 7 of
	    0 -> skip_varint_Person(Rest, 0, 0, F1, F2, F3, F4, F5);
	    1 -> skip_64_Person(Rest, 0, 0, F1, F2, F3, F4, F5);
	    2 ->
		skip_length_delimited_Person(Rest, 0, 0, F1, F2, F3, F4,
					     F5);
	    5 -> skip_32_Person(Rest, 0, 0, F1, F2, F3, F4, F5)
	  end
    end;
dg_read_field_def_Person(<<>>, 0, 0, F1, F2, F3, F4,
			 F5) ->
    #'Person'{name = F1, address = F2, phone_number = F3,
	      age = F4, location = F5}.

d_field_Person_name(<<1:1, X:7, Rest/binary>>, N, Acc,
		    F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_Person_name(Rest, N + 7, X bsl N + Acc, F1, F2,
			F3, F4, F5);
d_field_Person_name(<<0:1, X:7, Rest/binary>>, N, Acc,
		    _, F2, F3, F4, F5) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_Person(Rest2, 0, 0, NewFValue, F2,
			      F3, F4, F5).


d_field_Person_address(<<1:1, X:7, Rest/binary>>, N,
		       Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_Person_address(Rest, N + 7, X bsl N + Acc, F1,
			   F2, F3, F4, F5);
d_field_Person_address(<<0:1, X:7, Rest/binary>>, N,
		       Acc, F1, _, F3, F4, F5) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_Person(Rest2, 0, 0, F1, NewFValue,
			      F3, F4, F5).


d_field_Person_phone_number(<<1:1, X:7, Rest/binary>>,
			    N, Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_Person_phone_number(Rest, N + 7, X bsl N + Acc,
				F1, F2, F3, F4, F5);
d_field_Person_phone_number(<<0:1, X:7, Rest/binary>>,
			    N, Acc, F1, F2, _, F4, F5) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_Person(Rest2, 0, 0, F1, F2,
			      NewFValue, F4, F5).


d_field_Person_age(<<1:1, X:7, Rest/binary>>, N, Acc,
		   F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_Person_age(Rest, N + 7, X bsl N + Acc, F1, F2,
		       F3, F4, F5);
d_field_Person_age(<<0:1, X:7, Rest/binary>>, N, Acc,
		   F1, F2, F3, _, F5) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_Person(Rest, 0, 0, F1, F2, F3,
			      NewFValue, F5).


d_field_Person_location(<<1:1, X:7, Rest/binary>>, N,
			Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_Person_location(Rest, N + 7, X bsl N + Acc, F1,
			    F2, F3, F4, F5);
d_field_Person_location(<<0:1, X:7, Rest/binary>>, N,
			Acc, F1, F2, F3, F4, F5) ->
    Len = X bsl N + Acc,
    <<Bs:Len/binary, Rest2/binary>> = Rest,
    NewFValue = decode_msg(Bs, 'Location'),
    dfp_read_field_def_Person(Rest2, 0, 0, F1, F2, F3, F4,
			      if F5 == undefined -> NewFValue;
				 true -> merge_msg_Location(F5, NewFValue)
			      end).


skip_varint_Person(<<1:1, _:7, Rest/binary>>, Z1, Z2,
		   F1, F2, F3, F4, F5) ->
    skip_varint_Person(Rest, Z1, Z2, F1, F2, F3, F4, F5);
skip_varint_Person(<<0:1, _:7, Rest/binary>>, Z1, Z2,
		   F1, F2, F3, F4, F5) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F1, F2, F3, F4,
			      F5).


skip_length_delimited_Person(<<1:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    skip_length_delimited_Person(Rest, N + 7, X bsl N + Acc,
				 F1, F2, F3, F4, F5);
skip_length_delimited_Person(<<0:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, F4, F5) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_Person(Rest2, 0, 0, F1, F2, F3, F4,
			      F5).


skip_32_Person(<<_:32, Rest/binary>>, Z1, Z2, F1, F2,
	       F3, F4, F5) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F1, F2, F3, F4,
			      F5).


skip_64_Person(<<_:64, Rest/binary>>, Z1, Z2, F1, F2,
	       F3, F4, F5) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F1, F2, F3, F4,
			      F5).




merge_msgs(Prev, New)
    when element(1, Prev) =:= element(1, New) ->
    case Prev of
      #'Location'{} -> merge_msg_Location(Prev, New);
      #'Person'{} -> merge_msg_Person(Prev, New)
    end.

merge_msg_Location(Prev, undefined) -> Prev;
merge_msg_Location(undefined, New) -> New;
merge_msg_Location(#'Location'{region = PFregion,
			       country = PFcountry},
		   #'Location'{region = NFregion, country = NFcountry}) ->
    #'Location'{region =
		    if NFregion =:= undefined -> PFregion;
		       true -> NFregion
		    end,
		country =
		    if NFcountry =:= undefined -> PFcountry;
		       true -> NFcountry
		    end}.

merge_msg_Person(#'Person'{name = PFname,
			   address = PFaddress, phone_number = PFphone_number,
			   age = PFage, location = PFlocation},
		 #'Person'{name = NFname, address = NFaddress,
			   phone_number = NFphone_number, age = NFage,
			   location = NFlocation}) ->
    #'Person'{name =
		  if NFname =:= undefined -> PFname;
		     true -> NFname
		  end,
	      address =
		  if NFaddress =:= undefined -> PFaddress;
		     true -> NFaddress
		  end,
	      phone_number =
		  if NFphone_number =:= undefined -> PFphone_number;
		     true -> NFphone_number
		  end,
	      age =
		  if NFage =:= undefined -> PFage;
		     true -> NFage
		  end,
	      location = merge_msg_Location(PFlocation, NFlocation)}.



verify_msg(Msg) ->
    case Msg of
      #'Location'{} -> v_msg_Location(Msg, ['Location']);
      #'Person'{} -> v_msg_Person(Msg, ['Person']);
      _ -> mk_type_error(not_a_known_message, Msg, [])
    end.


v_msg_Location(#'Location'{region = F1, country = F2},
	       Path) ->
    v_type_string(F1, [region | Path]),
    v_type_string(F2, [country | Path]),
    ok;
v_msg_Location(X, Path) ->
    mk_type_error({expected_msg, 'Location'}, X, Path).

v_msg_Person(#'Person'{name = F1, address = F2,
		       phone_number = F3, age = F4, location = F5},
	     Path) ->
    v_type_string(F1, [name | Path]),
    v_type_string(F2, [address | Path]),
    v_type_string(F3, [phone_number | Path]),
    v_type_int32(F4, [age | Path]),
    if F5 == undefined -> ok;
       true -> v_msg_Location(F5, [location | Path])
    end,
    ok.

v_type_int32(N, _Path)
    when -2147483648 =< N, N =< 2147483647 ->
    ok;
v_type_int32(N, Path) when is_integer(N) ->
    mk_type_error({value_out_of_range, int32, signed, 32},
		  N, Path);
v_type_int32(X, Path) ->
    mk_type_error({bad_integer, int32, signed, 32}, X,
		  Path).

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
    [{{msg, 'Location'},
      [#field{name = region, fnum = 1, rnum = 2,
	      type = string, occurrence = required, opts = []},
       #field{name = country, fnum = 2, rnum = 3,
	      type = string, occurrence = required, opts = []}]},
     {{msg, 'Person'},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = required, opts = []},
       #field{name = address, fnum = 2, rnum = 3,
	      type = string, occurrence = required, opts = []},
       #field{name = phone_number, fnum = 3, rnum = 4,
	      type = string, occurrence = required, opts = []},
       #field{name = age, fnum = 4, rnum = 5, type = int32,
	      occurrence = required, opts = []},
       #field{name = location, fnum = 5, rnum = 6,
	      type = {msg, 'Location'}, occurrence = optional,
	      opts = []}]}].


get_msg_names() -> ['Location', 'Person'].


get_enum_names() -> [].


fetch_msg_def(MsgName) ->
    case find_msg_def(MsgName) of
      Fs when is_list(Fs) -> Fs;
      error -> erlang:error({no_such_msg, MsgName})
    end.


fetch_enum_def(EnumName) ->
    erlang:error({no_such_enum, EnumName}).


find_msg_def('Location') ->
    [#field{name = region, fnum = 1, rnum = 2,
	    type = string, occurrence = required, opts = []},
     #field{name = country, fnum = 2, rnum = 3,
	    type = string, occurrence = required, opts = []}];
find_msg_def('Person') ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = required, opts = []},
     #field{name = address, fnum = 2, rnum = 3,
	    type = string, occurrence = required, opts = []},
     #field{name = phone_number, fnum = 3, rnum = 4,
	    type = string, occurrence = required, opts = []},
     #field{name = age, fnum = 4, rnum = 5, type = int32,
	    occurrence = required, opts = []},
     #field{name = location, fnum = 5, rnum = 6,
	    type = {msg, 'Location'}, occurrence = optional,
	    opts = []}];
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


get_package_name() -> undefined.



gpb_version_as_string() ->
    "3.18.8".

gpb_version_as_list() ->
    [3,18,8].
