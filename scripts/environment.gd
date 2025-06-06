extends Node2D

@onready var timer_reset: Timer = $TimerReset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager._load_data()
	pass # Replace with function body.

#ball death
func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		print(GameManager.lives)
		if GameManager.lives > 0:
			GameManager.lives -= 1
			body.reset_position() 
		else:
			timer_reset.start()
	else:
		body.queue_free()
		
	pass # Replace with function body.

#reset level
func _on_timer_reset_timeout() -> void:
	get_tree().reload_current_scene()
	GameManager.started = false
	GameManager._reset_lives()
	GameManager._reset_points()
	
	pass # Replace with function body.
