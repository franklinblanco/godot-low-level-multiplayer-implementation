@abstract class_name Entity extends CharacterBody3D

var entity_id: int
var entity_name: String
var entity_type: ENTITY_TYPE
var scene: PackedScene

func _ready() -> void:
	Signals.on_entity_focus.connect(take_control_of_entity)

enum ENTITY_TYPE {
	PLAYER = 0,
	MOB = 1,
	FREE_CAM = 2,
}

func encode() -> PackedByteArray:
	var data: PackedByteArray
	data.resize(3)
	data.encode_u8(0, entity_type)
	data.encode_u8(1, entity_id)
	var name_data: PackedByteArray = entity_name.to_utf8_buffer()
	data.encode_u8(2, name_data.size())
	data.append_array(name_data)
	return data

static func decode(data: PackedByteArray, entity: Entity) -> void:
	entity.entity_type = data.decode_u8(0) as Entity.ENTITY_TYPE
	entity.entity_id = data.decode_u8(1)
	var name_size: int = data.decode_u8(2)
	entity.entity_name = data.slice(3, 3 + name_size).get_string_from_utf8()

func take_control_of_entity(entity_id: int) -> void:
	for child in get_children():
		var is_current: bool = self.entity_id == entity_id
		if child is CharacterController:
			child.enabled = is_current
		if child is Camera3D:
			child.current = is_current

func copy(other: Entity) -> void:
	other.entity_id = entity_id
	other.entity_name = entity_name
	other.entity_type = entity_type
	other.scene = scene
