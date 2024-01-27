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

# Function to generate floor layout
func generate_floor_layout():
	clear_layout()
	
	place_floor(room_l_obj,Vector3(64,0,64),container_floor_l_node)
	place_floor(room_l_obj,Vector3(-64,0,64),container_floor_l_node)
	place_floor(room_l_obj,Vector3(64,0,-64),container_floor_l_node)
	place_floor(room_l_obj,Vector3(-64,0,-64),container_floor_l_node)
	
	setup_floor_m(room_m_obj,Vector3(40,0,72),container_floor_m_node,Vector3(16,0,0))
	setup_floor_m(room_m_obj,Vector3(40,0,-72),container_floor_m_node,Vector3(16,0,0))
	setup_floor_m(room_m_obj,Vector3(72,0,40),container_floor_m_node,Vector3(0,0,16))
	setup_floor_m(room_m_obj,Vector3(-72,0,40),container_floor_m_node,Vector3(0,0,16))
	
	setup_floor_m(room_m_obj,Vector3(40,0,56),container_floor_m_node,Vector3(16,0,0))
	setup_floor_m(room_m_obj,Vector3(40,0,-56),container_floor_m_node,Vector3(16,0,0))
	setup_floor_m(room_m_obj,Vector3(56,0,40),container_floor_m_node,Vector3(0,0,16))
	setup_floor_m(room_m_obj,Vector3(-56,0,40),container_floor_m_node,Vector3(0,0,16))
	
	setup_floor_s(room_s_obj,Vector3(44,0,44),container_floor_m_node,Vector3(0,0,8))



func place_floor(floorType,floorPosition,floorParent):
	var floorInstance = floorType.instantiate()
	floorInstance.position = floorPosition
	floorParent.add_child(floorInstance)


func setup_floor_m(floorType,floorPosition,floorParent,modifier):
	var position = floorPosition
	for i in range(6):
		print(position)
		var floorInstance = floorType.instantiate()
		floorInstance.position = position
		floorParent.add_child(floorInstance)
		position -= modifier

func setup_floor_s(floorType,floorPosition,floorParent,modifier):
	var position = floorPosition
	for i in range(12):
		print(position)
		var floorInstance = floorType.instantiate()
		floorInstance.position = position
		floorParent.add_child(floorInstance)
		position -= modifier
	

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


func _ready():
	print(container_floor_l_node)
	generate_floor_layout()
	
