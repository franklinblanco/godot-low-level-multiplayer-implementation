class_name Player extends Entity

var client_id: int

func create(entity_id: int, entity_name: String, client_id: int) -> Player:
	var player: Player = Player.new()
	player.entity_id = entity_id
	player.entity_name = entity_name
	player.client_id = client_id
	return player
