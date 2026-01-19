class_name ClientLogger extends Object

static func debug(...args: Array) -> void:
	var text: String = ""
	for arg in args:
		text += str(arg)
	print_rich("[color=green][b]", text, "[/b][/color]")
