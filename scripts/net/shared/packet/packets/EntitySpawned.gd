class_name EntitySpawned extends Packet

# Paket type := 1 byte
var timestamp: float # Float (8) = 8 bytes
var entity: Entity # Appended at the end, non-constant size

const BYTE_ARRAY_SIZE: int = 9 # Size of the array to represent this packet (before entity)

static func create(entity: Entity) -> EntitySpawned:
	var packet: EntitySpawned = EntitySpawned.new()
	packet.packet_type = PACKET_TYPE.ENTITY_TRANSFORM_UPDATE
	packet.flag = ENetPacketPeer.FLAG_RELIABLE
	packet.entity = entity
	packet.timestamp = Time.get_unix_time_from_system()
	return packet

static func create_from_data(data: PackedByteArray) -> EntitySpawned:
	var packet: EntitySpawned = EntitySpawned.new()
	packet.decode(data)
	return packet

func encode() -> PackedByteArray:
	var data: PackedByteArray = super.encode()
	data.resize(BYTE_ARRAY_SIZE)
	data.encode_double(1, timestamp)
	data.append_array(entity.encode())
	return data

func decode(data: PackedByteArray) -> void:
	super.decode(data)
	timestamp = data.decode_double(1)
	var entity_type: Entity.ENTITY_TYPE = data.decode_u8(BYTE_ARRAY_SIZE) as Entity.ENTITY_TYPE
	match entity_type:
		Entity.ENTITY_TYPE.PLAYER:
			entity = Player.new()
			Player.decode(data.slice(BYTE_ARRAY_SIZE), entity)
