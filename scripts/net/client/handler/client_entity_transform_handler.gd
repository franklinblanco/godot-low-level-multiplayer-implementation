class_name ClientEntityTransformUpdateHandler extends Node

@onready var client: Client = $"../Client"
@onready var world: World = $"../WorldParent"

var packets_per_entity: Dictionary[int, PacketTimeTraveler]
var time_passed_s: float

# 50ms Transform update interval
const INTERVAL_S: float = 0.05
# 100ms time that the client lives in the past relative to the server
const TIME_IN_THE_PAST: float = 0.1

func _ready() -> void:
	ClientSignals.on_entity_transform_update_packet.connect(handle_entity_transform_update)

func _process(delta: float) -> void:
	time_passed_s += delta
	if time_passed_s > INTERVAL_S:
		# TODO: Update position here
		time_passed_s = 0

func handle_entity_transform_update(from_server: bool, packet: EntityTransformUpdate) -> void:
	if not from_server:
		packet.send(client.server_peer)
