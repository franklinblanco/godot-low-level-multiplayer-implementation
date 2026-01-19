class_name ServerEntitySpawnedHandler extends Node


func _ready() -> void:
	ServerSignals.on_spawn_player.connect(handle_spawn_entity)

func handle_spawn_entity() -> void:
	pass
