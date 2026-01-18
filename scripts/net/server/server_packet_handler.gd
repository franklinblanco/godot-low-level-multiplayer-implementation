class_name ServerPacketHandler extends Node

func _ready() -> void:
	ServerSignals.on_client_connected.connect(handle_client_connected)
	ServerSignals.on_client_packet.connect(handle_client_packet)

func handle_client_connected(id: int) -> void:
	# TODO: Send ID assignment packet to client
	pass

func handle_client_disconnected(id: int) -> void:
	# TODO: Despawn player and send it to everyone
	pass

func handle_client_packet(id: int, packet: PackedByteArray) -> void:
	# TODO: Emit signal corresponding to every single packet
	var packet_type: int = packet.decode_u8(0)
	match packet_type:
		Packet.PACKET_TYPE.ENTITY_TRANSFORM_UPDATE:
			# Communicate the position change, then change it on the server world
			#handle_player_position.emit(peer_id, PlayerPosition.create_from_data(data))
			#var player_position_packet: EntityTransformUpdate = EntityTransformUpdate.create_from_data(data)
			#world.find_player_with_id(peer_id).global_position = player_position_packet.position
			#player_position_packet.broadcast(server_setup.connection)
			pass
		_:
			push_error("Packet type with index: ", packet_type, " unhandled!")
