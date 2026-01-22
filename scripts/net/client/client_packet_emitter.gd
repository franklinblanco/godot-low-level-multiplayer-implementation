class_name ClientPacketEmitter extends Node

func _ready() -> void:
	ClientSignals.on_server_packet_received.connect(process_incoming_packet)

func process_incoming_packet(data: PackedByteArray) -> void:
	var packet_type: int = data.decode_u8(0)
	match packet_type:
		Packet.PACKET_TYPE.ID_ASSIGNMENT:
			var packet = IDAssignment.create_from_data(data)
			ClientSignals.on_id_assignment_packet.emit(packet)
		Packet.PACKET_TYPE.ENTITY_SPAWNED:
			var packet = EntitySpawned.create_from_data(data)
			ClientSignals.on_entity_spawned_packet.emit(packet)
		Packet.PACKET_TYPE.ENTITY_TRANSFORM_UPDATE:
			var packet = EntityTransformUpdate.create_from_data(data)
			ClientSignals.on_entity_transform_update_packet.emit(true, packet)
		_:
			push_error("Packet type with index: ", packet_type, " unhandled!")
