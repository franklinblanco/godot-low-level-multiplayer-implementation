class_name IDAssignment extends Packet

var id: int # 1 byte
const BYTE_ARRAY_SIZE: int = 10 # Size of the array to represent this packet

static func create(id: int) -> IDAssignment:
	var info: IDAssignment = IDAssignment.new()
	info.packet_type = PACKET_TYPE.ID_ASSIGNMENT
	info.flag = ENetPacketPeer.FLAG_RELIABLE # Reliable = TCP | Unsequenced = UDP
	info.id = id
	info.timestamp = Time.get_unix_time_from_system()
	return info

static func create_from_data(data: PackedByteArray) -> IDAssignment:
	var info: IDAssignment = IDAssignment.new()
	info.decode(data)
	return info

func encode() -> PackedByteArray:
	var data: PackedByteArray = super.encode()
	data.resize(BYTE_ARRAY_SIZE)
	data.encode_u8(9, id)
	return data

func decode(data: PackedByteArray) -> void:
	super.decode(data)
	id = data.decode_u8(9)
