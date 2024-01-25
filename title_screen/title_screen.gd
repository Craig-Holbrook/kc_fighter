extends Control

const PORT = 808
const ADDRESS = "localhost"
var peer: ENetMultiplayerPeer


func _ready():
	var upnp = UPNP.new()
	upnp.discover()
	upnp.add_port_mapping(PORT)
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	if "--server" in OS.get_cmdline_args():
		host_game()


#hosts external IP needs to be passed to create_client
func _on_host_game_button_pressed():
	host_game()
	send_player_information(multiplayer.get_unique_id())


func _on_join_game_button_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ADDRESS, PORT)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.multiplayer_peer = peer


func _on_start_game_button_pressed():
	start_game.rpc()


func host_game():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT)
	if error != OK:
		print("cannot host: " + error)
		return
	#try out compressions later
	peer.host.compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.multiplayer_peer = peer
	print("waiting for players")


func peer_connected(id: int):
	print("Player connected " + str(id))


func peer_disconnected(id: int):
	print("Player disconnected " + str(id))


func connected_to_server():
	print("connected to server")
	send_player_information.rpc_id(1, multiplayer.get_unique_id())


func connection_failed():
	print("connection failed")


@rpc("any_peer")
func send_player_information(id):
	if !GameManager.players.has(id):
		GameManager.players[id] = {"id": id, "score": 0}
	if multiplayer.is_server():
		for i in GameManager.players:
			send_player_information.rpc(i)


@rpc("any_peer", "call_local")
func start_game():
	var stage = load("res://stage/stage.tscn").instantiate()
	get_tree().root.add_child(stage)
	($AudioStreamPlayer2D as AudioStreamPlayer2D).stop()
	hide()
