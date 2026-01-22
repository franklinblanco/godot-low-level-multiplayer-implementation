class_name ClientEntityTransformUpdateHandler extends Node

@onready var client: Client = $"../Client"

func _ready() -> void:
	ClientSignals.on_entity_transform_update_packet.connect(handle_entity_transform_update)

func handle_entity_transform_update(packet: EntityTransformUpdate) -> void:
	packet.send(client.server_peer)
