extends Node

# Application entrypoint
func _ready() -> void:
	var args := OS.get_cmdline_args()
	if "--host" in args:
		_run_server()
	else:
		_run_client()

func _run_server() -> void:
	get_window().title = "Server"
	get_tree().call_deferred("change_scene_to_file", "res://scenes/Server.tscn")

func _run_client() -> void:
	get_window().title = "Client"
	get_tree().call_deferred("change_scene_to_file", "res://scenes/Client.tscn")
