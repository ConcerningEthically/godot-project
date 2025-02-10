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
	mob.init(mob_spawn_location.position, player_position)
	
	#spawn the mob
	add_child(mob)
	
	# Connect mob with score label
	mob.squashed.connect($UI/ScoreLabel._on_mob_squashed.bind())

# When the player is hit by a mob
func _on_player_hit():
	$MobTimer.stop()
	$UI/Retry.show()

func _ready():
	$UI/Retry.hide()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UI/Retry.visible:
		# Restart the game
		get_tree().reload_current_scene()
