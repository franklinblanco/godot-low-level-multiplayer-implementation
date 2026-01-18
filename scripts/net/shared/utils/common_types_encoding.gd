extends Node

const FLOAT_SIZE: int = 8
const PHYSICS_FLOAT_SIZE: int = 4 # Vec and other physics related engine types only use 32 bit floats
const VEC3_SIZE: int = PHYSICS_FLOAT_SIZE * 3

func encode_vec3(buffer: PackedByteArray, position: int, data: Vector3) -> int:
	buffer.encode_float(position, data.x)
	buffer.encode_float(position + PHYSICS_FLOAT_SIZE, data.y)
	buffer.encode_float(position + (PHYSICS_FLOAT_SIZE * 2), data.z)
	return position + (PHYSICS_FLOAT_SIZE * 3)

func encode_basis(buffer: PackedByteArray, position: int, data: Basis) -> int:
	encode_vec3(buffer, position, data.x)
	encode_vec3(buffer, position + VEC3_SIZE, data.y)
	encode_vec3(buffer, position + (VEC3_SIZE * 2), data.z)
	return position + (VEC3_SIZE * 3)
