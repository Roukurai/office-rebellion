extends CSGBox3D

# Variables to store the ID of the cubicle
var id_x : int
var id_z : int

# Method to set the ID of the cubicle
func set_id(x_val, z_val):
	id_x = x_val
	id_z = z_val

func get_id():
	return Vector3(id_x,0,id_z)
