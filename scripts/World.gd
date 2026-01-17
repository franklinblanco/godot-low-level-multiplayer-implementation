class_name World extends Node

func _ready() -> void:
	ClientNetworkGlobals.handle_player_position.connect(client_update_player_position)

func find_player_with_id(player_id: int) -> Player:
	for child in get_children():
		if child is Player:
			if child.id == player_id:
				return child
	return null

func client_update_player_position(player_position: PlayerPosition) -> void:
	if player_position.id != ClientNetworkGlobals.id:
		print("Updating player ", player_position.id, " position in ", ClientNetworkGlobals.id)
		var player = find_player_with_id(player_position.id)
		#print("Client updated world position")
		player.global_position = player_position.position
