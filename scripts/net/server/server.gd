class_name Server extends Node

var client_peers: Dictionary[int, ENetPacketPeer]

# General Variables
var connection: ENetConnection

func _ready() -> void:
	start_server()

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
				client_connected(peer)
			ENetConnection.EVENT_DISCONNECT:
				client_disconnected(peer)
			ENetConnection.EVENT_RECEIVE:
				ServerSignals.on_client_packet.emit(peer.get_meta("id"), peer.get_packet())
		packet_event = connection.service()
		event_type = packet_event[0]

func client_connected(peer: ENetPacketPeer) -> void:
	var peer_id: int = generate_random_id()
	peer.set_meta("id", peer_id)
	client_peers[peer_id] = peer
	
	ServerLogger.debug("Peer connected with assigned id: ", peer_id)
	ServerSignals.on_client_connected.emit(peer_id)
	
func client_disconnected(peer: ENetPacketPeer) -> void:
	var peer_id: int = peer.get_meta("id")
	client_peers.erase(peer_id)
	
	ServerLogger.debug("Successfully disconnected: ", peer_id, " from server")
	ServerSignals.on_client_disconnected.emit(peer_id)

func start_server(ip_address: String = "127.0.0.1", port: int = 42069) -> void:
	connection = ENetConnection.new()
	var error: Error = connection.create_host_bound(ip_address, port)
	if error:
		push_error("Server starting failed: ", error_string(error))
		connection = null
		return
	ServerSignals.on_server_started.emit()
	ServerLogger.debug("Server started")

func generate_random_id() -> int:
	var generated = RNG.generate_random_id()
	while generated in client_peers.keys():
		generated = RNG.generate_random_id()
	return generated
