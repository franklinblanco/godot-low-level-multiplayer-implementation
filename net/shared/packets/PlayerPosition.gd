class_name PlayerPosition extends PacketInfo

var id: int
var position: Vector3

# 1 byte for packet_type, 1 for player_id, 4 per float to represent vector3
# https://www.youtube.com/watch?v=8GfJw0E5MFE
const BYTE_ARRAY_SIZE: int = 14 # Size of the array to represent this packet


static func create(id: int, position: Vector3) -> PlayerPosition:
	var info: PlayerPosition = PlayerPosition.new()
	info.packet_type = PACKET_TYPE.PLAYER_POSITION
	info.flag = ENetPacketPeer.FLAG_UNSEQUENCED
	info.id = id
	info.position = position
	return info

static func create_from_data(data: PackedByteArray) -> PlayerPosition:
	var info: PlayerPosition = PlayerPosition.new()
	info.decode(data)
	return info

func encode() -> PackedByteArray:
	var data: PackedByteArray = super.encode()
	data.resize(BYTE_ARRAY_SIZE)
	data.encode_u8(1, id)
	data.encode_float(2, position.x)
	data.encode_float(6, position.y)
	data.encode_float(10, position.z)
	return data

func decode(data: PackedByteArray) -> void:
	super.decode(data)
	id = data.decode_u8(1)
	position = Vector3(data.decode_float(2), data.decode_float(6), data.decode_float(10))
	
