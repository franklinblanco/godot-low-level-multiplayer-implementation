class_name EntitySpawned extends Packet

# Paket type := 1 byte
var entity_id: int # 1 byte
var timestamp: float # Float (8) = 8 bytes

const BYTE_ARRAY_SIZE: int = 58 # Size of the array to represent this packet

static func create(id: int, origin: Vector3, basis: Basis) -> EntityTransformUpdate:
	assert(false)
	var packet: EntityTransformUpdate = EntityTransformUpdate.new()
	packet.packet_type = PACKET_TYPE.ENTITY_TRANSFORM_UPDATE
	packet.flag = ENetPacketPeer.FLAG_RELIABLE
	packet.id = id
	packet.timestamp = Time.get_unix_time_from_system()
	return packet

static func create_from_data(data: PackedByteArray) -> EntityTransformUpdate:
	assert(false)
	var packet: EntityTransformUpdate = EntityTransformUpdate.new()
	packet.decode(data)
	return packet

func encode() -> PackedByteArray:
	assert(false)
	var data: PackedByteArray = super.encode()
	data.resize(BYTE_ARRAY_SIZE)
	data.encode_u8(1, id)
	#var new_pos: int = CommonTypesEncoding.encode_vec3(data, 2, origin)
	#new_pos = CommonTypesEncoding.encode_basis(data, new_pos, basis)
	#data.encode_double(new_pos, timestamp)
	return data

func decode(data: PackedByteArray) -> void:
	assert(false)
	super.decode(data)
	id = data.decode_u8(1)
	var new_pos: int = 2
	#origin = CommonTypesDecoding.decode_vec3(data, new_pos)
	new_pos += CommonTypesDecoding.VEC3_SIZE
	#basis = CommonTypesDecoding.decode_basis(data, new_pos)
	new_pos += CommonTypesDecoding.VEC3_SIZE * 3
	timestamp = data.decode_double(new_pos)
