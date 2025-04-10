extends CharacterBody2D

@export var y_speed = -250
@export var angle = [-250,250]
var started = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and !started:
		start_game()
	var collision = move_and_collide(velocity*delta)
	if collision != null:
		velocity = velocity.bounce(collision.get_normal())
		var collided_object = collision.get_collider()
		if "Block" in collided_object.name:
			collided_object.queue_free()

func start_game():
	started = true
	velocity = Vector2(angle.pick_random(), y_speed)
