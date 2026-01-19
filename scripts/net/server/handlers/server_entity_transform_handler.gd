class_name ServerEntityTransformHandler extends Node

@onready var server: Server = $"../Server"
@onready var world: World = $"../WorldParent"

func _ready() -> void:
	ServerSignals.on_entity_transform_update_packet.connect(handle_entity_transform_update)

func handle_entity_transform_update(client_id: int, packet: EntityTransformUpdate) -> void:
	
	pass
