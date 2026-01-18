class_name Client extends Node

var server_peer: ENetPacketPeer
var connection: ENetConnection

func _process(_delta: float) -> void:
	if connection == null: return
	handle_events()

func handle_events() -> void:
	var packet_event: Array = connection.service()
	var event_type: ENetConnection.EventType = packet_event[0]
	while event_type != ENetConnection.EVENT_NONE:
		var peer: ENetPacketPeer = packet_event[1]
		match event_type:
			ENetConnection.EVENT_ERROR:
				push_warning("Packet resulted in an unknown error!")
				return
			ENetConnection.EVENT_CONNECT:
				connected_to_server()
			ENetConnection.EVENT_DISCONNECT:
				disconnected_from_server()
				return
			ENetConnection.EVENT_RECEIVE:
				ClientSignals.on_server_packet_received.emit(peer.get_packet())
		packet_event = connection.service()
		event_type = packet_event[0]

func disconnect_client() -> void:
	server_peer.peer_disconnect()

func connected_to_server() -> void:
	print_debug("Successfully connected to server!")
	ClientSignals.on_connected_to_server.emit()

func disconnected_from_server() -> void:
	print_debug("Successfully disconnected from server!")
	ClientSignals.on_disconnected_to_server.emit()
	connection = null

func start_client(ip_address: String = "127.0.0.1", port: int = 42069) -> void:
	connection = ENetConnection.new()
	var error: Error = connection.create_host(1)
	if error:
		push_error("Client starting failed: ", error_string(error))
		connection = null
		return
	print_debug("Client started")
	server_peer = connection.connect_to_host(ip_address, port)
	
