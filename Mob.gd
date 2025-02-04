extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 10
# Maximum speed of the mob in meters per second.
@export var max_speed = 18


func _physics_process(_delta):
	move_and_slide()

func intitialize(start_position, player_position):
	# Position mob at start position
	look_at_from_position(start_position, player_position, Vector3.UP)
	# Rotates the mob in a random direction so it does not face the player directly
	rotate_y(randf_range(-PI / 4, PI / 4))

	# We calculate a random speed (integer)
	var random_speed = randi_range(min_speed, max_speed)
	# Calculate a forward velocity that represents the speed.
	velocity = Vector3.FORWARD * random_speed
	# Rotate the velocity vector based on the mob's Y rotation
	velocity = velocity.rotated(Vector3.UP, rotation.y) 
	


func _on_visible_on_screen_notifier_3d_screen_exited():
	pass # Replace with function body.
