class_name ClientConnectionHandler extends Node

# For now, this class has no purpose, as the client doesn't do anything when
# It first connects to the server.

@onready var client: Client = $"../Client"

func _ready() -> void:
	ClientSignals.on_connected_to_server.connect(handle_connected_to_server)
	ClientSignals.on_disconnected_to_server.connect(handle_disconnected_to_server)
	ClientSignals.on_id_assignment_packet.connect(handle_id_assignment)

func handle_connected_to_server() -> void:
	pass
func handle_disconnected_to_server() -> void:
	pass

func handle_id_assignment(packet: IDAssignment) -> void:
	client.id = packet.id
	get_window().title = "Client (" + str(packet.id) + ")"
	ClientLogger.debug("IDAssignment from server fulfilled. ID: ", packet.id)
