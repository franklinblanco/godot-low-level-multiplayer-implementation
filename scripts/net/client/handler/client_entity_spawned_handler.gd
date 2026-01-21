class_name ClientEntitySpawned extends Node

@onready var world: World = $"../WorldParent"

func _ready() -> void:
	ClientSignals.on_entity_spawned_packet.connect(handle_spawn_entity)

func handle_spawn_entity(packet: EntitySpawned) -> void:
	world.spawn_entity(packet.entity)
	# TODO: Check if it's the same as you, then spawn it with controls
