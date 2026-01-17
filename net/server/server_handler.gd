class_name ServerHandler extends Node

#signal handle_player_position(peer_id: int, player_position: PlayerPosition)

@onready var server_setup: ServerSetup = $"../ServerSetup"
@onready var world: World = $"../World"
@onready var player_spawner: PlayerSpawner = $"../World/PlayerSpawner"

var peer_ids: Array[int]

func _ready() -> void:
	server_setup.on_peer_connected.connect(on_peer_connected)
	server_setup.on_peer_disconnected.connect(on_peer_disconnected)
	server_setup.on_server_packet.connect(on_server_packet)

func on_peer_connected(peer_id: int):
	peer_ids.append(peer_id)
	IDAssignment.create(peer_id, peer_ids).broadcast(server_setup.connection)
	player_spawner.spawn_other_player(peer_id)

func on_peer_disconnected(peer_id: int):
	peer_ids.erase(peer_id)
	# TODO: Create IDUnassignment to broadcast to all still connected peers

func on_server_packet(peer_id: int, data: PackedByteArray):
	var packet_type: int = data.decode_u8(0)
	match packet_type:
		PacketInfo.PACKET_TYPE.PLAYER_POSITION:
			# Communicate the position change, then change it on the server world
			#handle_player_position.emit(peer_id, PlayerPosition.create_from_data(data))
			var player_position_packet: PlayerPosition = PlayerPosition.create_from_data(data)
			world.find_player_with_id(peer_id).global_position = player_position_packet.position
			player_position_packet.broadcast(server_setup.connection)
		_:
			push_error("Packet type with index: ", packet_type, " unhandled!")
