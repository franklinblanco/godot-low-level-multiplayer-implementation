class_name PacketTimeTraveler
# Use this class to store and manage and query packets that should use a 'time-traveler' system.
# If the packets need to be stored and sorted, then retrieved with a delay, use this class.

# Max amount of packets stored in the 'packets' array. Every time a packet comes in and there's 
# the amount below, delete the oldest packet and push the newest packet.
# Still adjust the amount to match a good amount of time.
const MAX_PACKETS_STORE: int = 1000
var packets: Array[Packet] = []

func get_most_recent_packet_since(since: float) -> Packet:
	var current_time: float = Time.get_unix_time_from_system()
	for i in packets.size():
		var packet = packets[-i-1]
		if packet.timestamp <= current_time - since:
			return packet
	return null

func push_packet(packet: Packet) -> void:
	if packets.size() >= MAX_PACKETS_STORE:
		packets.pop_front()
	packets.push_back(packet)
