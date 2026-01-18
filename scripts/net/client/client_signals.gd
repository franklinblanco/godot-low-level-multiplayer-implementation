extends Node
# Startup, shutdown, networking signals
signal on_client_started
signal on_client_shutdown
signal on_connected_to_server
signal on_disconnected_to_server
signal on_server_packet_received(data: PackedByteArray)
