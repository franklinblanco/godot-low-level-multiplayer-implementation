extends Node

const FLOAT_SIZE: int = 8
const PHYSICS_FLOAT_SIZE: int = 4 # Vec and other physics related engine types only use 32 bit floats
const VEC3_SIZE: int = PHYSICS_FLOAT_SIZE * 3

# This function advances position by PHYSICS_FLOAT_SIZE * 3
func decode_vec3(buffer: PackedByteArray, position: int) -> Vector3:
	var x = buffer.decode_float(position)
	var y = buffer.decode_float(position + PHYSICS_FLOAT_SIZE)
	var z = buffer.decode_float(position + (PHYSICS_FLOAT_SIZE * 2))
	return Vector3(x, y, z)
	
# This function advances position by VEC3_SIZE * 3
func decode_basis(buffer: PackedByteArray, position: int) -> Basis:
	var x = decode_vec3(buffer, position)
	var y = decode_vec3(buffer, position + VEC3_SIZE)
	var z = decode_vec3(buffer, position + (VEC3_SIZE * 2))
	return Basis(x, y, z)
