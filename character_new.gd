extends CharacterBody3D

@export var SPEED = 5.0
@export var damage = 1

@export var attack_object: PackedScene
@export var container_attack: Node3D

var spawnPosition: Vector3 # Position where objects will spawn

var koins = 3

const JUMP_VELOCITY = 4.5
const FRICTION = 25
const HORIZONTAL_ACCELERATION = 30
const MAX_SPEED=50
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var koin_label: Label

@onready var camera = $Camera3D
@onready var animated_sprite = $AnimatedSprite3D

var isMoving = false
var input_dir = Vector3.ZERO
var isAttacking = false
var isBeingHit = false

func _ready():
	
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	koin_label= get_node("/root/World/ui_layer/ui_control/HBoxContainer/koinAmount")
	container_attack= get_node("/root/World/container_attack")
	koin_label.text=str(koins)
	

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode=Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var movetoward = Vector3.ZERO
	input_dir.x = Input.get_vector("move_left", "move_right", "move_forward", "move_backward").x
	input_dir.y = Input.get_vector("move_left", "move_right", "move_forward", "move_backward").y
	input_dir=input_dir.normalized()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction *= SPEED
	velocity.x = move_toward(velocity.x,direction.x, HORIZONTAL_ACCELERATION * delta)
	velocity.z = move_toward(velocity.z,direction.z, HORIZONTAL_ACCELERATION * delta)

	var angle=5
	#rotation_degrees=Vector3(input_dir.normalized().y*angle,rotation_degrees.y,-input_dir.normalized().x*angle)
	var t = delta * 6
	if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
		rotation_degrees=rotation_degrees.lerp(Vector3(input_dir.normalized().y*angle,rotation_degrees.y,-input_dir.normalized().x*angle),t)
	if input_dir.x == 0 and input_dir.y == 0:
		isMoving=false
	else:
		isMoving=true
	
	move_and_slide()
	force_update_transform()

func _process(delta):
	if Input.is_action_just_pressed("kt_attack"):
		isAttacking=true
		animated_sprite.stop()
		animated_sprite.play("attack")
		attack()
		isAttacking=false
		
	if isMoving == true and isAttacking==false: 
		if input_dir.y<0:
			animated_sprite.play("run_forward")
		elif input_dir.x<0:
			animated_sprite.flip_h=true
			animated_sprite.play("run")
		elif input_dir.x>0:
			animated_sprite.flip_h=false
			animated_sprite.play("run")
		elif input_dir.y>0:
			animated_sprite.play("run_backward")

	if isMoving== false and isAttacking== false:
		animated_sprite.play("idle")
		
	
func receive_damage(damage):
	if isBeingHit==false:
		isBeingHit = true
		koins-=1
		print(koins)
		if koins <=0:
			print("You are broke son")
			get_tree().reload_current_scene()
		isBeingHit=false

func attack():
	var newObject = attack_object.instantiate()
	newObject.global_position = self.global_position
	container_attack.add_child(newObject)
