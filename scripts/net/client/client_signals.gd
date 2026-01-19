extends Node
# Startup, shutdown, networking signals
signal on_client_started
signal on_client_shutdown
signal on_connected_to_server
signal on_disconnected_to_server
signal on_server_packet_received(data: PackedByteArray)

# Packet signals
signal on_id_assignment_packet(packet: IDAssignment)
signal on_entity_transform_update_packet(client_id: int, packet: EntityTransformUpdate)
signal on_entity_spawned_packet(client_id: int, packet: EntitySpawned)

# Server to world signals
signal on_spawn_player(client_id: int)
signal on_despawn_player(client_id: int)
