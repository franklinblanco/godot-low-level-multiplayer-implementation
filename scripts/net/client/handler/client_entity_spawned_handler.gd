class_name ClientEntitySpawned extends Node

@onready var world: World = $"../WorldParent"
@onready var client: Client = $"../Client"

func _ready() -> void:
	ClientSignals.on_entity_spawned_packet.connect(handle_spawn_entity)

func handle_spawn_entity(packet: EntitySpawned) -> void:
	world.spawn_entity(packet.entity)
	var entity: Entity = packet.entity
	if entity is Player:
		Signals.on_entity_focus.emit(entity.entity_id)
