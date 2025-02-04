extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	#create a local variable to store input directom
		var direction = Vector3.ZERO
		if Input.is_action_just_pressed("move_right")
