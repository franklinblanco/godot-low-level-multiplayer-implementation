class_name CharacterController extends Node

const SPEED: float = 5.0
const MOUSE_SENSITIVITY: float = 0.0005

@export var enabled: bool = false

var player: Player
var input_rotation: Vector3

func _ready() -> void:
	player = get_parent()

func _physics_process(_delta: float) -> void:
	if not enabled: return
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var new_velocity: Vector2 = Vector2.ZERO
	var direction: Vector3 = (player.transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	if direction:
		new_velocity = Vector2(direction.x, direction.z) * SPEED
	player.velocity = Vector3(new_velocity.x, 0.0, new_velocity.y)
	player.move_and_slide()
	if player.velocity != Vector3.ZERO:
		ClientSignals.on_entity_transform_update_packet.emit(false, EntityTransformUpdate.create(player.entity_id, player.global_position, player.global_basis))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pass
		#input_rotation.x += -event.screen_relative.x * mouse_sensitivity
		#mouse_input.y += -event.screen_relative.y * mouse_sensitivity
	if event is InputEventMouseButton:
		if event.pressed:
			pass
			#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
