class_name PlayerSpawner extends Node3D

var player_instance = preload("res://scenes/Player.tscn")
var other_player_instance = preload("res://scenes/OtherPlayer.tscn")

func _ready() -> void:
	ClientNetworkGlobals.handle_local_id_assignment.connect(spawn_player)
	ClientNetworkGlobals.handle_remote_id_assignment.connect(spawn_other_player)
	#ClientNetworkGlobals.handle_player_position.connect(update_player_position)

func spawn_player(local_id: int) -> void:
	var player_spawned: Player = player_instance.instantiate()
	player_spawned.id = local_id
	get_parent().add_child(player_spawned)
	player_spawned.position = Vector3.ZERO
	print("Spawned local player with id: ", local_id, " from: ", ClientNetworkGlobals.id)

func spawn_other_player(remote_id: int) -> void:
	var player_spawned: Player = other_player_instance.instantiate()
	player_spawned.id = remote_id
	get_parent().add_child(player_spawned)
	player_spawned.position = Vector3.ZERO
	print("Spawned remote player with id: ", remote_id, " from: ", ClientNetworkGlobals.id)

func _on_server_setup_on_peer_connected(peer_id: int) -> void:
	spawn_other_player(peer_id)
