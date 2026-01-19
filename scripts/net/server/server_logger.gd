class_name ServerLogger extends Object

static func debug(...args: Array) -> void:
	var text: String = ""
	for arg in args:
		text += str(arg)
	print_rich("[color=red][b]", text, "[/b][/color]")
