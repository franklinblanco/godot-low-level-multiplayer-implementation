class_name World extends Node3D

var world_parent: Node3D

func _ready() -> void:
	pass
	#world_parent = get_child(0)

func find_entity_with_entity_id(entity_id: int) -> Entity:
	for child in get_children():
		if child is Entity: 
			if child.entity_id == entity_id: return child
	return null
	
func find_player_with_client_id(client_id: int) -> Player:
	for child in get_children():
		if child is Player: 
			if child.client_id == client_id: return child
	return null
