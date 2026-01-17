class_name PlayerMovementController extends Player

const SPEED: float = 5.0

func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var new_velocity: Vector2 = Vector2.ZERO
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	if direction:
		new_velocity = Vector2(direction.x, direction.z) * SPEED
	velocity = Vector3(new_velocity.x, 0.0, new_velocity.y)
	
	move_and_slide()
	if velocity != Vector3.ZERO:
		PlayerPosition.create(id, global_position).send(ClientSetup.server_peer)
