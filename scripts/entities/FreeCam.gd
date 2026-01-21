class_name FreeCam extends Entity

var client_id: int
static var freecam_scene = preload("res://scenes/entities/FreeCam.tscn")

static func create(entity_id: int, entity_name: String, client_id: int) -> FreeCam:
	var free_cam: FreeCam = FreeCam.new()
	free_cam.entity_type = Entity.ENTITY_TYPE.FREE_CAM
	free_cam.scene = freecam_scene
	free_cam.entity_id = entity_id
	free_cam.entity_name = entity_name
	free_cam.client_id = client_id
	return free_cam

func encode() -> PackedByteArray:
	var data: PackedByteArray = super.encode()
	data.resize(data.size() + 1)
	data.encode_u8(data.size() - 1, client_id)
	return data

static func decode(data: PackedByteArray, entity: Entity) -> void:
	if entity is not FreeCam: 
		push_error("FreeCam decoding function did not get an entity type of FreeCam.")
		return
	super.decode(data, entity)
	entity.client_id = data.decode_u8(data.size() - 1)
	entity.scene = freecam_scene
