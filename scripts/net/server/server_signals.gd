extends Node
# Startup, shutdown, networking signals
signal on_server_started
signal on_server_shutdown
signal on_client_connected(client_id: int)
signal on_client_disconnected(client_id: int)
signal on_client_packet(client_id: int, data: PackedByteArray)

# Packet signals
signal on_entity_transform_update_packet(client_id: int, packet: EntityTransformUpdate)
signal on_entity_spawned_packet(packet: EntitySpawned)

# Server to world signals
signal on_spawn_player(client_id: int)
signal on_despawn_player(client_id: int)
