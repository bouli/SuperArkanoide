extends Node2D

@onready var timer_reset: Timer = $TimerReset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		timer_reset.start()
	else:
		body.queue_free()
		
	pass # Replace with function body.


func _on_timer_reset_timeout() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
