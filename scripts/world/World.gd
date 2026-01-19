class_name World extends Node3D

@export var world_parent: Node3D
var entities: Array[Entity] = []

func _ready() -> void:
	pass
	#world_parent = get_child(0)

func find_entity_with_entity_id(entity_id: int) -> Entity:
	for child in world_parent.get_children():
		if child is Entity: 
			if child.entity_id == entity_id: return child
	return null
	
func find_player_with_client_id(client_id: int) -> Player:
	for child in world_parent.get_children():
		if child is Player: 
			if child.client_id == client_id: return child
	return null

func spawn_entity(entity: Entity) -> void:
	# get spawn point
	var spawner: EntitySpawner
	for child in world_parent.get_children():
		if child is EntitySpawner:
			if not child.is_occupied():
				spawner = child
	if spawner == null:
		print_debug("Could not find an unoccupied entity spawner for entity: ", entity.entity_name, " with id: ", entity.entity_id)
		return
	var spawned_entity: Entity = entity.scene.instantiate()
	spawned_entity.entity_id = entity.entity_id
	spawned_entity.entity_name = entity.name
	spawned_entity.entity_type = entity.entity_type
	world_parent.add_child(spawned_entity)
	entities.append(entity)
