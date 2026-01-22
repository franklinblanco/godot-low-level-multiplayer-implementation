class_name ServerEntityTransformHandler extends Node

@onready var server: Server = $"../Server"
@onready var world: World = $"../WorldParent"

func _ready() -> void:
	ServerSignals.on_entity_transform_update_packet.connect(handle_entity_transform_update)

func handle_entity_transform_update(client_id: int, packet: EntityTransformUpdate) -> void:
	var sender: Player = world.find_player_with_client_id(client_id)
	if sender.entity_id == packet.entity_id:
		# Update in server world and send to clients
		sender.global_position = packet.origin
		sender.global_basis = packet.basis
		packet.broadcast(server.connection)
	
