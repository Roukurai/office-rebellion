extends Node3D

var speed = 10.0  # Adjust speed as needed

func _ready():
	set_process(true)
	$Timer.start()
	print("Timer Started")

func _process(delta):
	# Move the node forward in its local direction
	translate(Vector3(0, 0, -speed * delta))  # Adjust the axis as needed


func _on_timer_timeout():
	queue_free()
