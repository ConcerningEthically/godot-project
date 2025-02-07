extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 100
# The jump variable
@export var jump_impulse = 20
# Vertical impulse on player when bouncing over mob
@export var bounce_impulse = 16


var target_velocity = Vector3.ZERO

func _physics_process(delta):
	#create a local variable to store input directom
	var direction = Vector3.ZERO

# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.z -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis.looking_at(direction)
		
	#ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	#gravity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	#jumping
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	
	#moving the character
	velocity = target_velocity
	move_and_slide()
	
	# Iterate all collisions within the frame
	for index in range(get_slide_collision_count()):
		# Get one of the collisions with the player
		var collision = get_slide_collision(index)
		
		#if collision is with the ground
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				#if so squash the mob
				#mob.squash()
				#and bounce
				target_velocity.y = bounce_impulse
				# Prevent duplicate signals
				break
		
		
	
	
