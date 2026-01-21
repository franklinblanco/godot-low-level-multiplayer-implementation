@abstract class_name Entity extends Node3D

var entity_id: int
var entity_name: String
var entity_type: ENTITY_TYPE
var scene: PackedScene

enum ENTITY_TYPE {
	PLAYER = 0,
	MOB = 1,
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
