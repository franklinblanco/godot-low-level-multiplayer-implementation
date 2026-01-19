@abstract class_name Entity extends Node3D

var entity_id: int
var entity_name: String
var entity_type: ENTITY_TYPE
var scene: PackedScene

enum ENTITY_TYPE {
	PLAYER = 0,
	MOB = 1,
}

# Health
