class_name ClientEntityTransformUpdateHandler extends Node

@onready var client: Client = $"../Client"
@onready var world: World = $"../WorldParent"

var packets: Array[EntityTransformUpdate] = []
var time_passed_s: float

# 50ms Transform update interval
const INTERVAL_S: float = 0.05
# Max amount of packets stored in the 'packets' array. Every time a packet comes in and there's 
# the amount below, delete the oldest packet and push the newest packet.
# Still adjust the amount to match a good amount of time.
const MAX_PACKETS_STORE: int = 1000

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
	else:
		packets.push_back(packet)
		# TODO: Remove oldest packet when the packets array is full.
