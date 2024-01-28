extends CSGBox3D

# Define variables
@export var objectToSpawn: PackedScene # Assign the scene to spawn in the editor
@export var spawnInterval: float = 2.0 # Time interval between spawns
var spawnPosition: Vector3 # Position where objects will spawn
var spawnTimer: float = 0.0 # Timer to track spawning intervals

var isPlayerNear = false
var player: CharacterBody3D

func _ready():
	# Set the initial spawn position (adjust as needed)
	spawnPosition = Vector3(0, 0, 0)

func _process(delta: float):
	# Update the spawn timer
	if isPlayerNear==true:
		spawnTimer += delta
		# Check if it's time to spawn
		if spawnTimer >= spawnInterval:
			spawnObject()
			spawnTimer = 0.0

func spawnObject():
	# Check if the object to spawn is defined
	if objectToSpawn != null:
		# Instantiate the object at the spawn position
		var newObject = objectToSpawn.instantiate()
		if newObject != null:
			# Set the position of the spawned object
			var radius = 5
			var rand_x = randf_range(-radius, radius)
			var rand_y = randf_range(0, radius)
			var rand_z = randf_range(-radius, radius)

			newObject.transform.origin = spawnPosition+Vector3(rand_x,rand_y,rand_z)
			
			# Add the spawned object to the scene
			add_child(newObject)
			newObject.follow_player()
	else:
		print("Error: No object to spawn defined!")
		


func _on_area_3d_body_entered(body):
	if body.name=="character":
		isPlayerNear = true
		player=body
		get_tree().call_group("enemy", "follow_player")
		print("PLAYER DETECTED INITIATE WAVE")
	


func _on_area_3d_body_exited(body):
	if body.name=="character":
		isPlayerNear = false
		player = null
		
		print("PLAYER LEFT STOPPING SIMULATION")

