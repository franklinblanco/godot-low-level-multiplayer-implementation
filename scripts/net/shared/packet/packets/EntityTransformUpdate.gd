class_name EntityTransformUpdate extends Packet

# Paket type := 1 byte
var id: int # 1 byte
var origin: Vector3 # 3 x PhysicsFloat (4) = 12 bytes
var basis: Basis # 3 x Vector3 (12) = 36 bytes
var timestamp: float # Float (8) = 8 bytes

const BYTE_ARRAY_SIZE: int = 58 # Size of the array to represent this packet

static func create(id: int, origin: Vector3, basis: Basis) -> EntityTransformUpdate:
	var packet: EntityTransformUpdate = EntityTransformUpdate.new()
	packet.packet_type = PACKET_TYPE.ENTITY_TRANSFORM_UPDATE
	packet.flag = ENetPacketPeer.FLAG_UNSEQUENCED
	packet.id = id
	packet.origin = origin
	packet.basis = basis
	packet.timestamp = Time.get_unix_time_from_system()
	return packet

static func create_from_data(data: PackedByteArray) -> EntityTransformUpdate:
	var packet: EntityTransformUpdate = EntityTransformUpdate.new()
	packet.decode(data)
	return packet

func encode() -> PackedByteArray:
	var data: PackedByteArray = super.encode()
	data.resize(BYTE_ARRAY_SIZE)
	data.encode_u8(1, id)
	var new_pos: int = CommonTypesEncoding.encode_vec3(data, 2, origin)
	CommonTypesEncoding.encode_basis(data, new_pos, basis)
	return data

func decode(data: PackedByteArray) -> void:
	super.decode(data)
	id = data.decode_u8(1)
	origin = CommonTypesDecoding.decode_vec3(data, 2)
	basis = CommonTypesDecoding.decode_basis(data, 2 + CommonTypesDecoding.VEC3_SIZE)
