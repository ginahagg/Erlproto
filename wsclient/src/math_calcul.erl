%% Automatically generated, do not edit
%% Generated by gpb_compile version 3.18.8 on {{2015,8,22},{22,20,32}}
-module(math_calcul).

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

-include("math_calcul.hrl").
-include("gpb.hrl").


encode_msg(Msg) -> encode_msg(Msg, []).


encode_msg(Msg, Opts) ->
    case proplists:get_bool(verify, Opts) of
      true -> verify_msg(Msg);
      false -> ok
    end,
    case Msg of
      #areaofcircle{} -> e_msg_areaofcircle(Msg);
      #areaofsquare{} -> e_msg_areaofsquare(Msg);
      #areaofrectangle{} -> e_msg_areaofrectangle(Msg);
      #factorial{} -> e_msg_factorial(Msg)
    end.


e_msg_areaofcircle(Msg) ->
    e_msg_areaofcircle(Msg, <<>>).


e_msg_areaofcircle(#areaofcircle{name = F1, radius = F2,
				 area = F3, unit = F4},
		   Bin) ->
    B1 = e_type_string(F1, <<Bin/binary, 10>>),
    B2 = e_type_int32(F2, <<B1/binary, 16>>),
    B3 = if F3 == undefined -> B2;
	    true -> e_type_int32(F3, <<B2/binary, 24>>)
	 end,
    if F4 == undefined -> B3;
       true -> e_type_string(F4, <<B3/binary, 34>>)
    end.

e_msg_areaofsquare(Msg) ->
    e_msg_areaofsquare(Msg, <<>>).


e_msg_areaofsquare(#areaofsquare{name = F1, side = F2,
				 area = F3, unit = F4},
		   Bin) ->
    B1 = e_type_string(F1, <<Bin/binary, 10>>),
    B2 = e_type_int32(F2, <<B1/binary, 16>>),
    B3 = if F3 == undefined -> B2;
	    true -> e_type_int32(F3, <<B2/binary, 24>>)
	 end,
    if F4 == undefined -> B3;
       true -> e_type_string(F4, <<B3/binary, 34>>)
    end.

e_msg_areaofrectangle(Msg) ->
    e_msg_areaofrectangle(Msg, <<>>).


e_msg_areaofrectangle(#areaofrectangle{name = F1,
				       height = F2, width = F3, area = F4,
				       unit = F5},
		      Bin) ->
    B1 = e_type_string(F1, <<Bin/binary, 10>>),
    B2 = e_type_int32(F2, <<B1/binary, 16>>),
    B3 = e_type_int32(F3, <<B2/binary, 24>>),
    B4 = if F4 == undefined -> B3;
	    true -> e_type_int32(F4, <<B3/binary, 32>>)
	 end,
    if F5 == undefined -> B4;
       true -> e_type_string(F5, <<B4/binary, 42>>)
    end.

e_msg_factorial(Msg) -> e_msg_factorial(Msg, <<>>).


e_msg_factorial(#factorial{name = F1, number = F2,
			   result = F3},
		Bin) ->
    B1 = e_type_string(F1, <<Bin/binary, 10>>),
    B2 = e_type_int32(F2, <<B1/binary, 16>>),
    if F3 == undefined -> B2;
       true -> e_type_int32(F3, <<B2/binary, 24>>)
    end.

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
      areaofcircle -> d_msg_areaofcircle(Bin);
      areaofsquare -> d_msg_areaofsquare(Bin);
      areaofrectangle -> d_msg_areaofrectangle(Bin);
      factorial -> d_msg_factorial(Bin)
    end.



d_msg_areaofcircle(Bin) ->
    dfp_read_field_def_areaofcircle(Bin, 0, 0, undefined,
				    undefined, undefined, undefined).

dfp_read_field_def_areaofcircle(<<10, Rest/binary>>, Z1,
				Z2, F1, F2, F3, F4) ->
    d_field_areaofcircle_name(Rest, Z1, Z2, F1, F2, F3, F4);
dfp_read_field_def_areaofcircle(<<16, Rest/binary>>, Z1,
				Z2, F1, F2, F3, F4) ->
    d_field_areaofcircle_radius(Rest, Z1, Z2, F1, F2, F3,
				F4);
dfp_read_field_def_areaofcircle(<<24, Rest/binary>>, Z1,
				Z2, F1, F2, F3, F4) ->
    d_field_areaofcircle_area(Rest, Z1, Z2, F1, F2, F3, F4);
dfp_read_field_def_areaofcircle(<<34, Rest/binary>>, Z1,
				Z2, F1, F2, F3, F4) ->
    d_field_areaofcircle_unit(Rest, Z1, Z2, F1, F2, F3, F4);
dfp_read_field_def_areaofcircle(<<>>, 0, 0, F1, F2, F3,
				F4) ->
    #areaofcircle{name = F1, radius = F2, area = F3,
		  unit = F4};
dfp_read_field_def_areaofcircle(Other, Z1, Z2, F1, F2,
				F3, F4) ->
    dg_read_field_def_areaofcircle(Other, Z1, Z2, F1, F2,
				   F3, F4).

dg_read_field_def_areaofcircle(<<1:1, X:7,
				 Rest/binary>>,
			       N, Acc, F1, F2, F3, F4)
    when N < 32 - 7 ->
    dg_read_field_def_areaofcircle(Rest, N + 7,
				   X bsl N + Acc, F1, F2, F3, F4);
dg_read_field_def_areaofcircle(<<0:1, X:7,
				 Rest/binary>>,
			       N, Acc, F1, F2, F3, F4) ->
    Key = X bsl N + Acc,
    case Key of
      10 ->
	  d_field_areaofcircle_name(Rest, 0, 0, F1, F2, F3, F4);
      16 ->
	  d_field_areaofcircle_radius(Rest, 0, 0, F1, F2, F3, F4);
      24 ->
	  d_field_areaofcircle_area(Rest, 0, 0, F1, F2, F3, F4);
      34 ->
	  d_field_areaofcircle_unit(Rest, 0, 0, F1, F2, F3, F4);
      _ ->
	  case Key band 7 of
	    0 ->
		skip_varint_areaofcircle(Rest, 0, 0, F1, F2, F3, F4);
	    1 -> skip_64_areaofcircle(Rest, 0, 0, F1, F2, F3, F4);
	    2 ->
		skip_length_delimited_areaofcircle(Rest, 0, 0, F1, F2,
						   F3, F4);
	    5 -> skip_32_areaofcircle(Rest, 0, 0, F1, F2, F3, F4)
	  end
    end;
dg_read_field_def_areaofcircle(<<>>, 0, 0, F1, F2, F3,
			       F4) ->
    #areaofcircle{name = F1, radius = F2, area = F3,
		  unit = F4}.

d_field_areaofcircle_name(<<1:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, F4)
    when N < 57 ->
    d_field_areaofcircle_name(Rest, N + 7, X bsl N + Acc,
			      F1, F2, F3, F4);
d_field_areaofcircle_name(<<0:1, X:7, Rest/binary>>, N,
			  Acc, _, F2, F3, F4) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_areaofcircle(Rest2, 0, 0, NewFValue,
				    F2, F3, F4).


d_field_areaofcircle_radius(<<1:1, X:7, Rest/binary>>,
			    N, Acc, F1, F2, F3, F4)
    when N < 57 ->
    d_field_areaofcircle_radius(Rest, N + 7, X bsl N + Acc,
				F1, F2, F3, F4);
d_field_areaofcircle_radius(<<0:1, X:7, Rest/binary>>,
			    N, Acc, F1, _, F3, F4) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_areaofcircle(Rest, 0, 0, F1,
				    NewFValue, F3, F4).


d_field_areaofcircle_area(<<1:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, F4)
    when N < 57 ->
    d_field_areaofcircle_area(Rest, N + 7, X bsl N + Acc,
			      F1, F2, F3, F4);
d_field_areaofcircle_area(<<0:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, _, F4) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_areaofcircle(Rest, 0, 0, F1, F2,
				    NewFValue, F4).


d_field_areaofcircle_unit(<<1:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, F4)
    when N < 57 ->
    d_field_areaofcircle_unit(Rest, N + 7, X bsl N + Acc,
			      F1, F2, F3, F4);
d_field_areaofcircle_unit(<<0:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, _) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_areaofcircle(Rest2, 0, 0, F1, F2, F3,
				    NewFValue).


skip_varint_areaofcircle(<<1:1, _:7, Rest/binary>>, Z1,
			 Z2, F1, F2, F3, F4) ->
    skip_varint_areaofcircle(Rest, Z1, Z2, F1, F2, F3, F4);
skip_varint_areaofcircle(<<0:1, _:7, Rest/binary>>, Z1,
			 Z2, F1, F2, F3, F4) ->
    dfp_read_field_def_areaofcircle(Rest, Z1, Z2, F1, F2,
				    F3, F4).


skip_length_delimited_areaofcircle(<<1:1, X:7,
				     Rest/binary>>,
				   N, Acc, F1, F2, F3, F4)
    when N < 57 ->
    skip_length_delimited_areaofcircle(Rest, N + 7,
				       X bsl N + Acc, F1, F2, F3, F4);
skip_length_delimited_areaofcircle(<<0:1, X:7,
				     Rest/binary>>,
				   N, Acc, F1, F2, F3, F4) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_areaofcircle(Rest2, 0, 0, F1, F2, F3,
				    F4).


skip_32_areaofcircle(<<_:32, Rest/binary>>, Z1, Z2, F1,
		     F2, F3, F4) ->
    dfp_read_field_def_areaofcircle(Rest, Z1, Z2, F1, F2,
				    F3, F4).


skip_64_areaofcircle(<<_:64, Rest/binary>>, Z1, Z2, F1,
		     F2, F3, F4) ->
    dfp_read_field_def_areaofcircle(Rest, Z1, Z2, F1, F2,
				    F3, F4).


d_msg_areaofsquare(Bin) ->
    dfp_read_field_def_areaofsquare(Bin, 0, 0, undefined,
				    undefined, undefined, undefined).

dfp_read_field_def_areaofsquare(<<10, Rest/binary>>, Z1,
				Z2, F1, F2, F3, F4) ->
    d_field_areaofsquare_name(Rest, Z1, Z2, F1, F2, F3, F4);
dfp_read_field_def_areaofsquare(<<16, Rest/binary>>, Z1,
				Z2, F1, F2, F3, F4) ->
    d_field_areaofsquare_side(Rest, Z1, Z2, F1, F2, F3, F4);
dfp_read_field_def_areaofsquare(<<24, Rest/binary>>, Z1,
				Z2, F1, F2, F3, F4) ->
    d_field_areaofsquare_area(Rest, Z1, Z2, F1, F2, F3, F4);
dfp_read_field_def_areaofsquare(<<34, Rest/binary>>, Z1,
				Z2, F1, F2, F3, F4) ->
    d_field_areaofsquare_unit(Rest, Z1, Z2, F1, F2, F3, F4);
dfp_read_field_def_areaofsquare(<<>>, 0, 0, F1, F2, F3,
				F4) ->
    #areaofsquare{name = F1, side = F2, area = F3,
		  unit = F4};
dfp_read_field_def_areaofsquare(Other, Z1, Z2, F1, F2,
				F3, F4) ->
    dg_read_field_def_areaofsquare(Other, Z1, Z2, F1, F2,
				   F3, F4).

dg_read_field_def_areaofsquare(<<1:1, X:7,
				 Rest/binary>>,
			       N, Acc, F1, F2, F3, F4)
    when N < 32 - 7 ->
    dg_read_field_def_areaofsquare(Rest, N + 7,
				   X bsl N + Acc, F1, F2, F3, F4);
dg_read_field_def_areaofsquare(<<0:1, X:7,
				 Rest/binary>>,
			       N, Acc, F1, F2, F3, F4) ->
    Key = X bsl N + Acc,
    case Key of
      10 ->
	  d_field_areaofsquare_name(Rest, 0, 0, F1, F2, F3, F4);
      16 ->
	  d_field_areaofsquare_side(Rest, 0, 0, F1, F2, F3, F4);
      24 ->
	  d_field_areaofsquare_area(Rest, 0, 0, F1, F2, F3, F4);
      34 ->
	  d_field_areaofsquare_unit(Rest, 0, 0, F1, F2, F3, F4);
      _ ->
	  case Key band 7 of
	    0 ->
		skip_varint_areaofsquare(Rest, 0, 0, F1, F2, F3, F4);
	    1 -> skip_64_areaofsquare(Rest, 0, 0, F1, F2, F3, F4);
	    2 ->
		skip_length_delimited_areaofsquare(Rest, 0, 0, F1, F2,
						   F3, F4);
	    5 -> skip_32_areaofsquare(Rest, 0, 0, F1, F2, F3, F4)
	  end
    end;
dg_read_field_def_areaofsquare(<<>>, 0, 0, F1, F2, F3,
			       F4) ->
    #areaofsquare{name = F1, side = F2, area = F3,
		  unit = F4}.

d_field_areaofsquare_name(<<1:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, F4)
    when N < 57 ->
    d_field_areaofsquare_name(Rest, N + 7, X bsl N + Acc,
			      F1, F2, F3, F4);
d_field_areaofsquare_name(<<0:1, X:7, Rest/binary>>, N,
			  Acc, _, F2, F3, F4) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_areaofsquare(Rest2, 0, 0, NewFValue,
				    F2, F3, F4).


d_field_areaofsquare_side(<<1:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, F4)
    when N < 57 ->
    d_field_areaofsquare_side(Rest, N + 7, X bsl N + Acc,
			      F1, F2, F3, F4);
d_field_areaofsquare_side(<<0:1, X:7, Rest/binary>>, N,
			  Acc, F1, _, F3, F4) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_areaofsquare(Rest, 0, 0, F1,
				    NewFValue, F3, F4).


d_field_areaofsquare_area(<<1:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, F4)
    when N < 57 ->
    d_field_areaofsquare_area(Rest, N + 7, X bsl N + Acc,
			      F1, F2, F3, F4);
d_field_areaofsquare_area(<<0:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, _, F4) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_areaofsquare(Rest, 0, 0, F1, F2,
				    NewFValue, F4).


d_field_areaofsquare_unit(<<1:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, F4)
    when N < 57 ->
    d_field_areaofsquare_unit(Rest, N + 7, X bsl N + Acc,
			      F1, F2, F3, F4);
d_field_areaofsquare_unit(<<0:1, X:7, Rest/binary>>, N,
			  Acc, F1, F2, F3, _) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_areaofsquare(Rest2, 0, 0, F1, F2, F3,
				    NewFValue).


skip_varint_areaofsquare(<<1:1, _:7, Rest/binary>>, Z1,
			 Z2, F1, F2, F3, F4) ->
    skip_varint_areaofsquare(Rest, Z1, Z2, F1, F2, F3, F4);
skip_varint_areaofsquare(<<0:1, _:7, Rest/binary>>, Z1,
			 Z2, F1, F2, F3, F4) ->
    dfp_read_field_def_areaofsquare(Rest, Z1, Z2, F1, F2,
				    F3, F4).


skip_length_delimited_areaofsquare(<<1:1, X:7,
				     Rest/binary>>,
				   N, Acc, F1, F2, F3, F4)
    when N < 57 ->
    skip_length_delimited_areaofsquare(Rest, N + 7,
				       X bsl N + Acc, F1, F2, F3, F4);
skip_length_delimited_areaofsquare(<<0:1, X:7,
				     Rest/binary>>,
				   N, Acc, F1, F2, F3, F4) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_areaofsquare(Rest2, 0, 0, F1, F2, F3,
				    F4).


skip_32_areaofsquare(<<_:32, Rest/binary>>, Z1, Z2, F1,
		     F2, F3, F4) ->
    dfp_read_field_def_areaofsquare(Rest, Z1, Z2, F1, F2,
				    F3, F4).


skip_64_areaofsquare(<<_:64, Rest/binary>>, Z1, Z2, F1,
		     F2, F3, F4) ->
    dfp_read_field_def_areaofsquare(Rest, Z1, Z2, F1, F2,
				    F3, F4).


d_msg_areaofrectangle(Bin) ->
    dfp_read_field_def_areaofrectangle(Bin, 0, 0, undefined,
				       undefined, undefined, undefined,
				       undefined).

dfp_read_field_def_areaofrectangle(<<10, Rest/binary>>,
				   Z1, Z2, F1, F2, F3, F4, F5) ->
    d_field_areaofrectangle_name(Rest, Z1, Z2, F1, F2, F3,
				 F4, F5);
dfp_read_field_def_areaofrectangle(<<16, Rest/binary>>,
				   Z1, Z2, F1, F2, F3, F4, F5) ->
    d_field_areaofrectangle_height(Rest, Z1, Z2, F1, F2, F3,
				   F4, F5);
dfp_read_field_def_areaofrectangle(<<24, Rest/binary>>,
				   Z1, Z2, F1, F2, F3, F4, F5) ->
    d_field_areaofrectangle_width(Rest, Z1, Z2, F1, F2, F3,
				  F4, F5);
dfp_read_field_def_areaofrectangle(<<32, Rest/binary>>,
				   Z1, Z2, F1, F2, F3, F4, F5) ->
    d_field_areaofrectangle_area(Rest, Z1, Z2, F1, F2, F3,
				 F4, F5);
dfp_read_field_def_areaofrectangle(<<42, Rest/binary>>,
				   Z1, Z2, F1, F2, F3, F4, F5) ->
    d_field_areaofrectangle_unit(Rest, Z1, Z2, F1, F2, F3,
				 F4, F5);
dfp_read_field_def_areaofrectangle(<<>>, 0, 0, F1, F2,
				   F3, F4, F5) ->
    #areaofrectangle{name = F1, height = F2, width = F3,
		     area = F4, unit = F5};
dfp_read_field_def_areaofrectangle(Other, Z1, Z2, F1,
				   F2, F3, F4, F5) ->
    dg_read_field_def_areaofrectangle(Other, Z1, Z2, F1, F2,
				      F3, F4, F5).

dg_read_field_def_areaofrectangle(<<1:1, X:7,
				    Rest/binary>>,
				  N, Acc, F1, F2, F3, F4, F5)
    when N < 32 - 7 ->
    dg_read_field_def_areaofrectangle(Rest, N + 7,
				      X bsl N + Acc, F1, F2, F3, F4, F5);
dg_read_field_def_areaofrectangle(<<0:1, X:7,
				    Rest/binary>>,
				  N, Acc, F1, F2, F3, F4, F5) ->
    Key = X bsl N + Acc,
    case Key of
      10 ->
	  d_field_areaofrectangle_name(Rest, 0, 0, F1, F2, F3, F4,
				       F5);
      16 ->
	  d_field_areaofrectangle_height(Rest, 0, 0, F1, F2, F3,
					 F4, F5);
      24 ->
	  d_field_areaofrectangle_width(Rest, 0, 0, F1, F2, F3,
					F4, F5);
      32 ->
	  d_field_areaofrectangle_area(Rest, 0, 0, F1, F2, F3, F4,
				       F5);
      42 ->
	  d_field_areaofrectangle_unit(Rest, 0, 0, F1, F2, F3, F4,
				       F5);
      _ ->
	  case Key band 7 of
	    0 ->
		skip_varint_areaofrectangle(Rest, 0, 0, F1, F2, F3, F4,
					    F5);
	    1 ->
		skip_64_areaofrectangle(Rest, 0, 0, F1, F2, F3, F4, F5);
	    2 ->
		skip_length_delimited_areaofrectangle(Rest, 0, 0, F1,
						      F2, F3, F4, F5);
	    5 ->
		skip_32_areaofrectangle(Rest, 0, 0, F1, F2, F3, F4, F5)
	  end
    end;
dg_read_field_def_areaofrectangle(<<>>, 0, 0, F1, F2,
				  F3, F4, F5) ->
    #areaofrectangle{name = F1, height = F2, width = F3,
		     area = F4, unit = F5}.

d_field_areaofrectangle_name(<<1:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_areaofrectangle_name(Rest, N + 7, X bsl N + Acc,
				 F1, F2, F3, F4, F5);
d_field_areaofrectangle_name(<<0:1, X:7, Rest/binary>>,
			     N, Acc, _, F2, F3, F4, F5) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_areaofrectangle(Rest2, 0, 0,
				       NewFValue, F2, F3, F4, F5).


d_field_areaofrectangle_height(<<1:1, X:7,
				 Rest/binary>>,
			       N, Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_areaofrectangle_height(Rest, N + 7,
				   X bsl N + Acc, F1, F2, F3, F4, F5);
d_field_areaofrectangle_height(<<0:1, X:7,
				 Rest/binary>>,
			       N, Acc, F1, _, F3, F4, F5) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_areaofrectangle(Rest, 0, 0, F1,
				       NewFValue, F3, F4, F5).


d_field_areaofrectangle_width(<<1:1, X:7, Rest/binary>>,
			      N, Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_areaofrectangle_width(Rest, N + 7,
				  X bsl N + Acc, F1, F2, F3, F4, F5);
d_field_areaofrectangle_width(<<0:1, X:7, Rest/binary>>,
			      N, Acc, F1, F2, _, F4, F5) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_areaofrectangle(Rest, 0, 0, F1, F2,
				       NewFValue, F4, F5).


d_field_areaofrectangle_area(<<1:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_areaofrectangle_area(Rest, N + 7, X bsl N + Acc,
				 F1, F2, F3, F4, F5);
d_field_areaofrectangle_area(<<0:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, _, F5) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_areaofrectangle(Rest, 0, 0, F1, F2,
				       F3, NewFValue, F5).


d_field_areaofrectangle_unit(<<1:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    d_field_areaofrectangle_unit(Rest, N + 7, X bsl N + Acc,
				 F1, F2, F3, F4, F5);
d_field_areaofrectangle_unit(<<0:1, X:7, Rest/binary>>,
			     N, Acc, F1, F2, F3, F4, _) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_areaofrectangle(Rest2, 0, 0, F1, F2,
				       F3, F4, NewFValue).


skip_varint_areaofrectangle(<<1:1, _:7, Rest/binary>>,
			    Z1, Z2, F1, F2, F3, F4, F5) ->
    skip_varint_areaofrectangle(Rest, Z1, Z2, F1, F2, F3,
				F4, F5);
skip_varint_areaofrectangle(<<0:1, _:7, Rest/binary>>,
			    Z1, Z2, F1, F2, F3, F4, F5) ->
    dfp_read_field_def_areaofrectangle(Rest, Z1, Z2, F1, F2,
				       F3, F4, F5).


skip_length_delimited_areaofrectangle(<<1:1, X:7,
					Rest/binary>>,
				      N, Acc, F1, F2, F3, F4, F5)
    when N < 57 ->
    skip_length_delimited_areaofrectangle(Rest, N + 7,
					  X bsl N + Acc, F1, F2, F3, F4, F5);
skip_length_delimited_areaofrectangle(<<0:1, X:7,
					Rest/binary>>,
				      N, Acc, F1, F2, F3, F4, F5) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_areaofrectangle(Rest2, 0, 0, F1, F2,
				       F3, F4, F5).


skip_32_areaofrectangle(<<_:32, Rest/binary>>, Z1, Z2,
			F1, F2, F3, F4, F5) ->
    dfp_read_field_def_areaofrectangle(Rest, Z1, Z2, F1, F2,
				       F3, F4, F5).


skip_64_areaofrectangle(<<_:64, Rest/binary>>, Z1, Z2,
			F1, F2, F3, F4, F5) ->
    dfp_read_field_def_areaofrectangle(Rest, Z1, Z2, F1, F2,
				       F3, F4, F5).


d_msg_factorial(Bin) ->
    dfp_read_field_def_factorial(Bin, 0, 0, undefined,
				 undefined, undefined).

dfp_read_field_def_factorial(<<10, Rest/binary>>, Z1,
			     Z2, F1, F2, F3) ->
    d_field_factorial_name(Rest, Z1, Z2, F1, F2, F3);
dfp_read_field_def_factorial(<<16, Rest/binary>>, Z1,
			     Z2, F1, F2, F3) ->
    d_field_factorial_number(Rest, Z1, Z2, F1, F2, F3);
dfp_read_field_def_factorial(<<24, Rest/binary>>, Z1,
			     Z2, F1, F2, F3) ->
    d_field_factorial_result(Rest, Z1, Z2, F1, F2, F3);
dfp_read_field_def_factorial(<<>>, 0, 0, F1, F2, F3) ->
    #factorial{name = F1, number = F2, result = F3};
dfp_read_field_def_factorial(Other, Z1, Z2, F1, F2,
			     F3) ->
    dg_read_field_def_factorial(Other, Z1, Z2, F1, F2, F3).

dg_read_field_def_factorial(<<1:1, X:7, Rest/binary>>,
			    N, Acc, F1, F2, F3)
    when N < 32 - 7 ->
    dg_read_field_def_factorial(Rest, N + 7, X bsl N + Acc,
				F1, F2, F3);
dg_read_field_def_factorial(<<0:1, X:7, Rest/binary>>,
			    N, Acc, F1, F2, F3) ->
    Key = X bsl N + Acc,
    case Key of
      10 -> d_field_factorial_name(Rest, 0, 0, F1, F2, F3);
      16 -> d_field_factorial_number(Rest, 0, 0, F1, F2, F3);
      24 -> d_field_factorial_result(Rest, 0, 0, F1, F2, F3);
      _ ->
	  case Key band 7 of
	    0 -> skip_varint_factorial(Rest, 0, 0, F1, F2, F3);
	    1 -> skip_64_factorial(Rest, 0, 0, F1, F2, F3);
	    2 ->
		skip_length_delimited_factorial(Rest, 0, 0, F1, F2, F3);
	    5 -> skip_32_factorial(Rest, 0, 0, F1, F2, F3)
	  end
    end;
dg_read_field_def_factorial(<<>>, 0, 0, F1, F2, F3) ->
    #factorial{name = F1, number = F2, result = F3}.

d_field_factorial_name(<<1:1, X:7, Rest/binary>>, N,
		       Acc, F1, F2, F3)
    when N < 57 ->
    d_field_factorial_name(Rest, N + 7, X bsl N + Acc, F1,
			   F2, F3);
d_field_factorial_name(<<0:1, X:7, Rest/binary>>, N,
		       Acc, _, F2, F3) ->
    Len = X bsl N + Acc,
    <<Utf8:Len/binary, Rest2/binary>> = Rest,
    NewFValue = unicode:characters_to_list(Utf8, unicode),
    dfp_read_field_def_factorial(Rest2, 0, 0, NewFValue, F2,
				 F3).


d_field_factorial_number(<<1:1, X:7, Rest/binary>>, N,
			 Acc, F1, F2, F3)
    when N < 57 ->
    d_field_factorial_number(Rest, N + 7, X bsl N + Acc, F1,
			     F2, F3);
d_field_factorial_number(<<0:1, X:7, Rest/binary>>, N,
			 Acc, F1, _, F3) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_factorial(Rest, 0, 0, F1, NewFValue,
				 F3).


d_field_factorial_result(<<1:1, X:7, Rest/binary>>, N,
			 Acc, F1, F2, F3)
    when N < 57 ->
    d_field_factorial_result(Rest, N + 7, X bsl N + Acc, F1,
			     F2, F3);
d_field_factorial_result(<<0:1, X:7, Rest/binary>>, N,
			 Acc, F1, F2, _) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    dfp_read_field_def_factorial(Rest, 0, 0, F1, F2,
				 NewFValue).


skip_varint_factorial(<<1:1, _:7, Rest/binary>>, Z1, Z2,
		      F1, F2, F3) ->
    skip_varint_factorial(Rest, Z1, Z2, F1, F2, F3);
skip_varint_factorial(<<0:1, _:7, Rest/binary>>, Z1, Z2,
		      F1, F2, F3) ->
    dfp_read_field_def_factorial(Rest, Z1, Z2, F1, F2, F3).


skip_length_delimited_factorial(<<1:1, X:7,
				  Rest/binary>>,
				N, Acc, F1, F2, F3)
    when N < 57 ->
    skip_length_delimited_factorial(Rest, N + 7,
				    X bsl N + Acc, F1, F2, F3);
skip_length_delimited_factorial(<<0:1, X:7,
				  Rest/binary>>,
				N, Acc, F1, F2, F3) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_factorial(Rest2, 0, 0, F1, F2, F3).


skip_32_factorial(<<_:32, Rest/binary>>, Z1, Z2, F1, F2,
		  F3) ->
    dfp_read_field_def_factorial(Rest, Z1, Z2, F1, F2, F3).


skip_64_factorial(<<_:64, Rest/binary>>, Z1, Z2, F1, F2,
		  F3) ->
    dfp_read_field_def_factorial(Rest, Z1, Z2, F1, F2, F3).




merge_msgs(Prev, New)
    when element(1, Prev) =:= element(1, New) ->
    case Prev of
      #areaofcircle{} -> merge_msg_areaofcircle(Prev, New);
      #areaofsquare{} -> merge_msg_areaofsquare(Prev, New);
      #areaofrectangle{} ->
	  merge_msg_areaofrectangle(Prev, New);
      #factorial{} -> merge_msg_factorial(Prev, New)
    end.

merge_msg_areaofcircle(#areaofcircle{name = PFname,
				     radius = PFradius, area = PFarea,
				     unit = PFunit},
		       #areaofcircle{name = NFname, radius = NFradius,
				     area = NFarea, unit = NFunit}) ->
    #areaofcircle{name =
		      if NFname =:= undefined -> PFname;
			 true -> NFname
		      end,
		  radius =
		      if NFradius =:= undefined -> PFradius;
			 true -> NFradius
		      end,
		  area =
		      if NFarea =:= undefined -> PFarea;
			 true -> NFarea
		      end,
		  unit =
		      if NFunit =:= undefined -> PFunit;
			 true -> NFunit
		      end}.

merge_msg_areaofsquare(#areaofsquare{name = PFname,
				     side = PFside, area = PFarea,
				     unit = PFunit},
		       #areaofsquare{name = NFname, side = NFside,
				     area = NFarea, unit = NFunit}) ->
    #areaofsquare{name =
		      if NFname =:= undefined -> PFname;
			 true -> NFname
		      end,
		  side =
		      if NFside =:= undefined -> PFside;
			 true -> NFside
		      end,
		  area =
		      if NFarea =:= undefined -> PFarea;
			 true -> NFarea
		      end,
		  unit =
		      if NFunit =:= undefined -> PFunit;
			 true -> NFunit
		      end}.

merge_msg_areaofrectangle(#areaofrectangle{name =
					       PFname,
					   height = PFheight, width = PFwidth,
					   area = PFarea, unit = PFunit},
			  #areaofrectangle{name = NFname, height = NFheight,
					   width = NFwidth, area = NFarea,
					   unit = NFunit}) ->
    #areaofrectangle{name =
			 if NFname =:= undefined -> PFname;
			    true -> NFname
			 end,
		     height =
			 if NFheight =:= undefined -> PFheight;
			    true -> NFheight
			 end,
		     width =
			 if NFwidth =:= undefined -> PFwidth;
			    true -> NFwidth
			 end,
		     area =
			 if NFarea =:= undefined -> PFarea;
			    true -> NFarea
			 end,
		     unit =
			 if NFunit =:= undefined -> PFunit;
			    true -> NFunit
			 end}.

merge_msg_factorial(#factorial{name = PFname,
			       number = PFnumber, result = PFresult},
		    #factorial{name = NFname, number = NFnumber,
			       result = NFresult}) ->
    #factorial{name =
		   if NFname =:= undefined -> PFname;
		      true -> NFname
		   end,
	       number =
		   if NFnumber =:= undefined -> PFnumber;
		      true -> NFnumber
		   end,
	       result =
		   if NFresult =:= undefined -> PFresult;
		      true -> NFresult
		   end}.



verify_msg(Msg) ->
    case Msg of
      #areaofcircle{} ->
	  v_msg_areaofcircle(Msg, [areaofcircle]);
      #areaofsquare{} ->
	  v_msg_areaofsquare(Msg, [areaofsquare]);
      #areaofrectangle{} ->
	  v_msg_areaofrectangle(Msg, [areaofrectangle]);
      #factorial{} -> v_msg_factorial(Msg, [factorial]);
      _ -> mk_type_error(not_a_known_message, Msg, [])
    end.


v_msg_areaofcircle(#areaofcircle{name = F1, radius = F2,
				 area = F3, unit = F4},
		   Path) ->
    v_type_string(F1, [name | Path]),
    v_type_int32(F2, [radius | Path]),
    if F3 == undefined -> ok;
       true -> v_type_int32(F3, [area | Path])
    end,
    if F4 == undefined -> ok;
       true -> v_type_string(F4, [unit | Path])
    end,
    ok.

v_msg_areaofsquare(#areaofsquare{name = F1, side = F2,
				 area = F3, unit = F4},
		   Path) ->
    v_type_string(F1, [name | Path]),
    v_type_int32(F2, [side | Path]),
    if F3 == undefined -> ok;
       true -> v_type_int32(F3, [area | Path])
    end,
    if F4 == undefined -> ok;
       true -> v_type_string(F4, [unit | Path])
    end,
    ok.

v_msg_areaofrectangle(#areaofrectangle{name = F1,
				       height = F2, width = F3, area = F4,
				       unit = F5},
		      Path) ->
    v_type_string(F1, [name | Path]),
    v_type_int32(F2, [height | Path]),
    v_type_int32(F3, [width | Path]),
    if F4 == undefined -> ok;
       true -> v_type_int32(F4, [area | Path])
    end,
    if F5 == undefined -> ok;
       true -> v_type_string(F5, [unit | Path])
    end,
    ok.

v_msg_factorial(#factorial{name = F1, number = F2,
			   result = F3},
		Path) ->
    v_type_string(F1, [name | Path]),
    v_type_int32(F2, [number | Path]),
    if F3 == undefined -> ok;
       true -> v_type_int32(F3, [result | Path])
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
    [{{msg, areaofcircle},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = required, opts = []},
       #field{name = radius, fnum = 2, rnum = 3, type = int32,
	      occurrence = required, opts = []},
       #field{name = area, fnum = 3, rnum = 4, type = int32,
	      occurrence = optional, opts = []},
       #field{name = unit, fnum = 4, rnum = 5, type = string,
	      occurrence = optional, opts = []}]},
     {{msg, areaofsquare},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = required, opts = []},
       #field{name = side, fnum = 2, rnum = 3, type = int32,
	      occurrence = required, opts = []},
       #field{name = area, fnum = 3, rnum = 4, type = int32,
	      occurrence = optional, opts = []},
       #field{name = unit, fnum = 4, rnum = 5, type = string,
	      occurrence = optional, opts = []}]},
     {{msg, areaofrectangle},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = required, opts = []},
       #field{name = height, fnum = 2, rnum = 3, type = int32,
	      occurrence = required, opts = []},
       #field{name = width, fnum = 3, rnum = 4, type = int32,
	      occurrence = required, opts = []},
       #field{name = area, fnum = 4, rnum = 5, type = int32,
	      occurrence = optional, opts = []},
       #field{name = unit, fnum = 5, rnum = 6, type = string,
	      occurrence = optional, opts = []}]},
     {{msg, factorial},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = required, opts = []},
       #field{name = number, fnum = 2, rnum = 3, type = int32,
	      occurrence = required, opts = []},
       #field{name = result, fnum = 3, rnum = 4, type = int32,
	      occurrence = optional, opts = []}]}].


get_msg_names() ->
    [areaofcircle, areaofsquare, areaofrectangle,
     factorial].


get_enum_names() -> [].


fetch_msg_def(MsgName) ->
    case find_msg_def(MsgName) of
      Fs when is_list(Fs) -> Fs;
      error -> erlang:error({no_such_msg, MsgName})
    end.


fetch_enum_def(EnumName) ->
    erlang:error({no_such_enum, EnumName}).


find_msg_def(areaofcircle) ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = required, opts = []},
     #field{name = radius, fnum = 2, rnum = 3, type = int32,
	    occurrence = required, opts = []},
     #field{name = area, fnum = 3, rnum = 4, type = int32,
	    occurrence = optional, opts = []},
     #field{name = unit, fnum = 4, rnum = 5, type = string,
	    occurrence = optional, opts = []}];
find_msg_def(areaofsquare) ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = required, opts = []},
     #field{name = side, fnum = 2, rnum = 3, type = int32,
	    occurrence = required, opts = []},
     #field{name = area, fnum = 3, rnum = 4, type = int32,
	    occurrence = optional, opts = []},
     #field{name = unit, fnum = 4, rnum = 5, type = string,
	    occurrence = optional, opts = []}];
find_msg_def(areaofrectangle) ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = required, opts = []},
     #field{name = height, fnum = 2, rnum = 3, type = int32,
	    occurrence = required, opts = []},
     #field{name = width, fnum = 3, rnum = 4, type = int32,
	    occurrence = required, opts = []},
     #field{name = area, fnum = 4, rnum = 5, type = int32,
	    occurrence = optional, opts = []},
     #field{name = unit, fnum = 5, rnum = 6, type = string,
	    occurrence = optional, opts = []}];
find_msg_def(factorial) ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = required, opts = []},
     #field{name = number, fnum = 2, rnum = 3, type = int32,
	    occurrence = required, opts = []},
     #field{name = result, fnum = 3, rnum = 4, type = int32,
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


get_package_name() -> 'erproto.mathcalc'.



gpb_version_as_string() ->
    "3.18.8".

gpb_version_as_list() ->
    [3,18,8].
