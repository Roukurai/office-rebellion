extends CharacterBody3D
@export var speed = 5
@export var damage = 1
@export var health = 1

# Define variables
@export var objectToSpawn: PackedScene # Assign the scene to spawn in the editor
@export var spawnInterval: float = 2.0 # Time interval between spawns
@export var spawnRange: float = 10.0 # Maximum distance for spawning objects

var spawnPosition: Vector3 # Position where objects will spawn
var spawnTimer: float = 0.0 # Timer to track spawning intervals
var player: Node # Reference to the player node
var isPlayerLocated = false

func _ready():

	# Set the initial spawn position (adjust as needed)
	spawnPosition = global_transform.origin
	# Find the player node
	player = get_parent_node_3d().player
# Update with your actual scene and player node path
	if player == null:
		print("Player node not found!")

func _physics_process(delta):
	var direction = (player.global_position - self.global_position).normalized()
	# Move the enemy towards the player
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	if collision !=null:
		var collision_object = collision.get_collider()
		if collision_object.name == "character":
			collision_object.receive_damage(damage)
	


func _process(delta: float):
	# Update the spawn timer
	spawnTimer += delta

	# Check if it's time to spawn and the player is nearby
	if spawnTimer >= spawnInterval and isPlayerLocated==true:
		spawnTimer = 0.0

func follow_player():
	isPlayerLocated=true



func attack():
	# Check if the object to spawn is defined
	if objectToSpawn != null:
		# Instantiate the object at the spawn position
		var newObject = objectToSpawn.instance()
		if newObject != null:
			# Set the position of the spawned object
			newObject.transform.origin = spawnPosition
			# Add the spawned object to the scene
			add_child(newObject)
	else:
		print("Error: No object to spawn defined!")


