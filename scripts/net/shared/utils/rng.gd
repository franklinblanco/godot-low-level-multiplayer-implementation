class_name RNG

static func generate_random_id() -> int:
	var generated = RandomNumberGenerator.new().randi_range(0, 255)
	return generated
