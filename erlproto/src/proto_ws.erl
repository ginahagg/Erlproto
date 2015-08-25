-module(proto_ws).
-author("Gina Hagg <ghagg@yahoo.com").
-compile(export_all).


%%trying gun as websocket client. Has timeout issues in upgrade also reported by Robert Virding. Worth trying later when it is fixed.
start() ->
	{ok, ConnPid} = gun:open("127.0.0.1", 8080),
	gun:ws_upgrade(ConnPid, "/websocket"),
	receive
		{gun_ws_upgrade, ConnPid, ok} ->
			data_stream(ConnPid);
		{gun_ws_upgrade, ConnPid, error, IsFin, Status, Headers} ->
	 		exit({ws_upgrade_failed, Status, Headers})
	 after 2000 ->
	 	exit(timeout)
	 end.

	data_stream(ConnPid) ->
		gun:ws_send(ConnPid, {binary, <<"Hello websocket">>}),
		receive
			{gun_ws, ConnPid, Frame} ->
			handle_frame(ConnPid, Frame)
		end,
		gun:ws_send(ConnPid, close).

	handle_frame(ConnPid, Frame) ->
		io:format("Frame ~p~n", [Frame]).