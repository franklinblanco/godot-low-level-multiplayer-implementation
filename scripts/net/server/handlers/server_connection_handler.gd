class_name ServerConnectionHandler extends Node

@onready var server: Server = $"../Server"

func _ready() -> void:
	ServerSignals.on_client_connected.connect(handle_client_connected)
	ServerSignals.on_client_disconnected.connect(handle_client_disconnected)

func handle_client_connected(id: int) -> void:
	# Send idassignment only to the client that just connected, don't broadcast
	var client_tba: ENetPacketPeer = server.client_peers[id]
	IDAssignment.create(id).send(client_tba)
	ServerSignals.on_spawn_player.emit(id) # Spawn player in world

func handle_client_disconnected(id: int) -> void:
	PlayerDespawned.create(id).broadcast(server.connection)
	ServerSignals.on_despawn_player.emit(id)
