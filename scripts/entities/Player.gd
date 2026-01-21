class_name Player extends Entity

var client_id: int
static var player_scene = preload("res://scenes/entities/Player.tscn")

static func create(entity_id: int, entity_name: String, client_id: int) -> Player:
	var player: Player = Player.new()
	player.entity_type = Entity.ENTITY_TYPE.PLAYER
	player.scene = player_scene
	player.entity_id = entity_id
	player.entity_name = entity_name
	player.client_id = client_id
	return player

func encode() -> PackedByteArray:
	var data: PackedByteArray = super.encode()
	data.resize(data.size() + 1)
	data.encode_u8(data.size() - 1, client_id)
	return data

static func decode(data: PackedByteArray, entity: Entity) -> void:
	if entity is not Player: 
		push_error("Player decoding function did not get an entity type of player.")
		return
	super.decode(data, entity)
	entity.client_id = data.decode_u8(data.size() - 1)
