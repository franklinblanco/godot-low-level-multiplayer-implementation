class_name PlayerDespawned extends Packet

var id: int # 1 byte
const BYTE_ARRAY_SIZE: int = 2 # Size of the array to represent this packet

static func create(id: int) -> PlayerDespawned:
	var info: PlayerDespawned = PlayerDespawned.new()
	info.packet_type = PACKET_TYPE.ID_ASSIGNMENT
	info.flag = ENetPacketPeer.FLAG_RELIABLE # Reliable = TCP | Unsequenced = UDP
	info.id = id
	return info

static func create_from_data(data: PackedByteArray) -> PlayerDespawned:
	var info: PlayerDespawned = PlayerDespawned.new()
	info.decode(data)
	return info

func encode() -> PackedByteArray:
	var data: PackedByteArray = super.encode()
	data.resize(BYTE_ARRAY_SIZE)
	data.encode_u8(1, id)
	return data

func decode(data: PackedByteArray) -> void:
	super.decode(data)
	id = data.decode_u8(1)
