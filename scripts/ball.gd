extends CharacterBody2D

var started = false

@export var y_speed = -250
@export var angle = [-250,250]
@export var drop_probabilty = 0.2
@export var item_scene = preload("res://scenes/item_power_up.tscn")


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
			spawn_item(collision.get_position())
		

func start_game():
	started = true
	velocity = Vector2(angle.pick_random(), y_speed)

func spawn_item(position_item : Vector2):
	var my_rand = randf()
	print(my_rand)
	if my_rand < drop_probabilty:
		var item = item_scene.instantiate()
		item.position = position_item
		get_parent().add_child(item)
