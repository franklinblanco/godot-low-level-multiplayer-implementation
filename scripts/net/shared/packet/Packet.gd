@abstract class_name Packet

enum PACKET_TYPE {
	ID_ASSIGNMENT = 0,
	# Entity related
	ENTITY_SPAWNED = 10,
	ENTITY_TRANSFORM_UPDATE = 11,
}

var packet_type: PACKET_TYPE
var flag: int = ENetPacketPeer.FLAG_UNSEQUENCED
var timestamp: float # 8 bytes

func encode() -> PackedByteArray:
	var data: PackedByteArray
	data.resize(9)
	data.encode_u8(0, packet_type)
	data.encode_double(1, timestamp)
	return data

func decode(data: PackedByteArray) -> void:
	packet_type = data.decode_u8(0) as Packet.PACKET_TYPE
	timestamp = data.decode_double(1)

func send(target: ENetPacketPeer) -> void:
	target.send(0, encode(), flag)

func broadcast(server: ENetConnection) -> void:
	server.broadcast(0, encode(), flag)
