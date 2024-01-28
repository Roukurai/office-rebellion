extends Node3D

# Define floor dimensions
@export var floor_size = 160

# export for 
@export var room_s_obj = preload("res://8x8.tscn")
@export var room_m_obj = preload("res://16x16.tscn")
@export var room_l_obj = preload("res://32x32.tscn")



# Export variables for container floor nodes
@export var container_floor_s_node: Node3D
@export var container_floor_m_node: Node3D
@export var container_floor_l_node: Node3D

# Define room sizes
const ROOM_L = 32
const ROOM_M = 16
const ROOM_S = 8

var id_to_child={}

# Function to generate floor layout
func generate_floor_layout():
	clear_layout()
	#
	#place_floor(room_l_obj,Vector3(64,0,64),container_floor_l_node)
	#place_floor(room_l_obj,Vector3(-64,0,64),container_floor_l_node)
	#place_floor(room_l_obj,Vector3(64,0,-64),container_floor_l_node)
	#place_floor(room_l_obj,Vector3(-64,0,-64),container_floor_l_node)
	#
	#setup_floor_m(room_m_obj,Vector3(40,0,72),container_floor_m_node,Vector3(16,0,0))
	#setup_floor_m(room_m_obj,Vector3(40,0,-72),container_floor_m_node,Vector3(16,0,0))
	#setup_floor_m(room_m_obj,Vector3(72,0,40),container_floor_m_node,Vector3(0,0,16))
	#setup_floor_m(room_m_obj,Vector3(-72,0,40),container_floor_m_node,Vector3(0,0,16))
	#
	#setup_floor_m(room_m_obj,Vector3(40,0,56),container_floor_m_node,Vector3(16,0,0))
	#setup_floor_m(room_m_obj,Vector3(40,0,-56),container_floor_m_node,Vector3(16,0,0))
	#setup_floor_m(room_m_obj,Vector3(56,0,40),container_floor_m_node,Vector3(0,0,16))
	#setup_floor_m(room_m_obj,Vector3(-56,0,40),container_floor_m_node,Vector3(0,0,16))
	
	#setup_floor_s(room_s_obj,Vector3(44,0,44),container_floor_m_node,Vector3(0,0,8))
	setup_floor_s(room_s_obj,Vector3(76,0,76),container_floor_m_node,Vector3(0,0,8))
	for i in range(32):
		var randomCubicle = select_random_cubicle_id()

	
	print("Done")

func place_floor(floorType,floorPosition,floorParent):
	var floorInstance = floorType.instantiate()
	floorInstance.position = floorPosition
	floorParent.add_child(floorInstance)


func setup_floor_m(floorType,floorPosition,floorParent,modifier):
	var position = floorPosition
	var floorInstance = floorType.instantiate()
	floorInstance.position = position
	floorParent.add_child(floorInstance)


func setup_floor_s(floorType,floorPosition,floorParent,modifier):
	var looprange = 20
	var position = floorPosition
	var startPosition = floorPosition
	
	for x in range(looprange):
		for z in range(looprange):
			var floorInstance = floorType.instantiate()
			
			floorInstance.position = position
			floorParent.add_child(floorInstance)
			floorInstance.set_id(x,z)
			id_to_child[floorInstance.get_id()] = floorInstance
			position -= modifier
		startPosition-=Vector3(8,0,0)
		position=startPosition


func clear_layout():
	# Get the number of children of the current node
	var container_floor_s_count = container_floor_s_node.get_child_count()
	var container_floor_m_count = container_floor_m_node.get_child_count()
	var container_floor_l_count = container_floor_l_node.get_child_count()
	# Loop through each child node
	
	if container_floor_s_count>0:
		for i in range(container_floor_s_count):
			# Get the child node at index i
			var child_node = container_floor_s_node.get_child(i)
			child_node.queue_free()
	
	if container_floor_m_count>0:
		for i in range(container_floor_m_count):
			# Get the child node at index i
			var child_node = container_floor_m_node.get_child(i)
			child_node.queue_free()
	
	if container_floor_l_count>0:
		for i in range(container_floor_l_count):
			# Get the child node at index i
			var child_node = container_floor_l_node.get_child(i)
			child_node.queue_free()


# Function to retrieve an object based on its ID from the id_to_child dictionary
func get_object_by_id(target_id: Vector3) -> Object:
	# Check if the target_id exists in the id_to_child dictionary
	if id_to_child.has(target_id):
	# Retrieve the object associated with the target_id
		var selected_object = id_to_child[target_id]
		return selected_object
	else:
	# Handle the case where the target_id is not found
		return null


# Function to queue-free an object based on its ID from the id_to_child dictionary
func queue_free_object_by_id(target_id: Vector3):
	# Check if the target_id exists in the id_to_child dictionary
	if id_to_child.has(target_id):
	# Retrieve the object associated with the target_id
		var selected_object = id_to_child[target_id]
		# Queue-free the selected object
		selected_object.queue_free()
		# Remove the entry from the dictionary
		id_to_child.erase(target_id)
		print("Removed", target_id," succesfully")
	else:
	# Handle the case where the target_id is not found
		print("Object with ID", target_id, "not found")

# Function to select a random cubicle ID from the id_to_child dictionary
func select_random_cubicle_id() -> Vector3:
	# Check if the id_to_child dictionary is not empty
	if id_to_child.size() > 0:
		# Get a random index within the range of the dictionary size
		var random_index = randi() % id_to_child.size()
		# Get the keys (cubicle IDs) from the dictionary
		var cubicle_ids = id_to_child.keys()
		# Retrieve the cubicle ID at the random index
		var random_cubicle_id = cubicle_ids[random_index] 
		print("Selected ", random_cubicle_id, " for validation")
		var isValid16 = is_valid_for_16x16(random_cubicle_id)
		if isValid16:
			print(isValid16)
			return random_cubicle_id
		else:
			print("id_to_child is not valid")
			return Vector3(-1,0,-1) 
	else:
	# Handle the case where the dictionary is empty
		print("id_to_child dictionary is empty")
		return Vector3(-1,0,-1)  # Return a default vector or handle the case according to your logic


# Function to check if a cubicle and its surrounding cubicles are valid for 16x16 conversion
func is_valid_for_16x16(cubicle_id: Vector3) -> bool:
	# Check if the cubicle itself is available
	if not id_to_child.has(cubicle_id):
		return false
	var isValidGridCheck = []
	var isValidGridPositions = []
	var selected_object = id_to_child[cubicle_id]
	isValidGridPositions.append(selected_object.position)
	
	# Check if all surrounding cubicles are available
	for x_offset in range(2):
		for z_offset in range(2):
			var surrounding_id = cubicle_id + Vector3(x_offset, 0, z_offset)
			if not id_to_child.has(surrounding_id):
				return false
			isValidGridCheck.append(surrounding_id)
			selected_object = id_to_child[surrounding_id]
			isValidGridPositions.append(selected_object.position)
	for id in isValidGridCheck:
		queue_free_object_by_id(id)
		var empty_area = find_empty_area_center(isValidGridPositions)
		setup_floor_m(room_m_obj,empty_area,container_floor_m_node,Vector3(16,0,0))
		
	return true

func find_empty_area_center(positions: Array) -> Vector3:
	var total_positions = Vector3.ZERO
	# Calculate the total positions
	for position in positions:
		total_positions += position
	# Calculate the average position if there are positions
	if positions.size() > 0:
		var average_position = total_positions / positions.size()
		var rounded_position = Vector3(
			floor(average_position.x),
			floor(average_position.y),
			floor(average_position.z)
		)
		return rounded_position
	else:
		return Vector3(-1,0,-1)


func calculate_32x32_corner_coords():
	var corner_coords = []
	# Define the starting position of the corner
	var start_x = 0
	var start_z = 0
	# Loop through each row and column in the 4x4 grid
	for x in range(4):
		for z in range(4):
	# Calculate the coordinates of the cubicle in the grid
			var cubicle_x = start_x + x
			var cubicle_z = start_z + z
			# Add the coordinates to the list
			corner_coords.append(Vector3(cubicle_x, 0, cubicle_z))
			# Return the list of coordinates for the corner
	return corner_coords


func _unhandled_key_input(event):
	if Input.is_action_just_released("kt_reload"):
		get_tree().reload_current_scene()


func _ready():
	print(container_floor_l_node)
	generate_floor_layout()
	

func _process(delta):
	if Input.is_action_just_released("kt_reload"):
		get_tree().reload_current_scene()
