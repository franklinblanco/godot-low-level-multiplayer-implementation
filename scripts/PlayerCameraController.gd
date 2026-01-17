class_name PlayerCameraController extends Node3D

var player_controller: PlayerMovementController
var input_rotation: Vector3
var mouse_input: Vector2
var mouse_sensitivity: float = 0.0005

func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_controller = get_parent()

func _input(event: InputEvent) -> void:
	#if player_controller.owner_id != ClientNetworkGlobals.id: return
	if event is InputEventMouseMotion:
		mouse_input.x += -event.screen_relative.x * mouse_sensitivity
		mouse_input.y += -event.screen_relative.y * mouse_sensitivity
	if event is InputEventMouseButton:
		if event.pressed:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	#if player_controller.owner_id != ClientNetworkGlobals.id: return
	input_rotation.x = clampf(input_rotation.x + mouse_input.y, deg_to_rad(-90), deg_to_rad(85))
	input_rotation.y += mouse_input.x
	
	# Rotate camera controller (up/down)
	transform.basis = Basis.from_euler(Vector3(input_rotation.x, 0.0, 0.0))
	
	# Rotate player (left/right)
	player_controller.global_transform.basis = Basis.from_euler(Vector3(0.0, input_rotation.y, 0.0))
	
	mouse_input = Vector2.ZERO
