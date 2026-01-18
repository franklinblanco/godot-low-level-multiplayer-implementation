extends Node

var _impl : Node
var is_client: bool

func _ready():
	var args := OS.get_cmdline_args()
	if "--host" in args:
		is_client = false
		_impl = preload("res://scripts/net/server/server.gd").new()
	else:
		is_client = true
		_impl = preload("res://scripts/net/client/client.gd").new()
