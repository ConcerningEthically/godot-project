extends Node

@export var mob_scene:PackedScene

func _on_timer_timeout():
	# Create a mob scene instance
	var mob = mob_scene.instantiate()
	
	# Choose a random position on the spawn path 
	var mob_spawn_location = get_node("Spawnpath/Spawnlocation")
	# Give the mob a random offset(progress across the screen)
	mob_spawn_location.progress_ratio = randf()
	
	# Get player position 
	var player_position = $Player.position 
	# Spawn mob at random spawn location, player position
	mob.initialize(mob_spawn_location.position, player_position)
	
	#spawn the mob
	add_child(mob)

# When the player is hit by a mob
func _on_player_hit():
	$MobTimer.stop()

