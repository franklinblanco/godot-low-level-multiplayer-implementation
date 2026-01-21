class_name CharacterController extends Node

const SPEED: float = 5.0
const MOUSE_SENSITIVITY: float = 0.0005

@export var enabled: bool = false

var character_body: CharacterBody3D
var input_rotation: Vector3

func _ready() -> void:
	character_body = get_parent()

func _physics_process(_delta: float) -> void:
	if not enabled: return
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var new_velocity: Vector2 = Vector2.ZERO
	var direction: Vector3 = (character_body.transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	if direction:
		new_velocity = Vector2(direction.x, direction.z) * SPEED
	character_body.velocity = Vector3(new_velocity.x, 0.0, new_velocity.y)
	character_body.move_and_slide()
	if character_body.velocity != Vector3.ZERO:
		#TODO: send to server
		pass
		#PlayerPosition.create(id, character_body.global_position).send(ClientSetup.server_peer)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pass
		#input_rotation.x += -event.screen_relative.x * mouse_sensitivity
		#mouse_input.y += -event.screen_relative.y * mouse_sensitivity
	if event is InputEventMouseButton:
		if event.pressed:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
