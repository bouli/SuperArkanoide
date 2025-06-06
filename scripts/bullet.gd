extends Area2D

@export var speed = 100

func _physics_process(delta: float) -> void:
	global_position.y -= speed * delta
	


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	body.queue_free()
	GameManager._add_points(1)
