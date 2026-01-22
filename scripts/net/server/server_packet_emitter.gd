class_name ServerPacketEmitter extends Node

func _ready() -> void:
	ServerSignals.on_client_packet.connect(process_incoming_packet)

func process_incoming_packet(client_id: int, data: PackedByteArray) -> void:
	var packet_type: int = data.decode_u8(0)
	match packet_type:
		Packet.PACKET_TYPE.ENTITY_TRANSFORM_UPDATE:
			var packet = EntityTransformUpdate.create_from_data(data)
			ServerSignals.on_entity_transform_update_packet.emit(client_id, packet)
			#if packet.entity_id == client_id: push_error("Packet has a client_id: ", packet.client_id, " that doesn't match the packet's sender client_id: ", client_id)
		_:
			push_error("Packet type with index: ", packet_type, " unhandled!")
