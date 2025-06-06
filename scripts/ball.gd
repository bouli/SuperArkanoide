extends CharacterBody2D

@onready var item_power_up_timer: Timer = $ItemPowerUpTimer
@export var y_speed = -250
@export var angle = [-250,250]
@export var drop_probabilty = 0.2
@export var item_scene = preload("res://scenes/item_power_up.tscn")
@export var item_power_up_ready:bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and !GameManager.started:
		start_game()
	var collision = move_and_collide(velocity*delta)
	if collision != null:
		velocity = velocity.bounce(collision.get_normal())
		var collided_object = collision.get_collider()
		if "Block" in collided_object.name:
			collided_object.queue_free()
			spawn_item(collision.get_position())
			GameManager._add_points(5)

		

func start_game():
	GameManager.started = true
	velocity = Vector2(angle.pick_random(), y_speed) #generate movement for the ball

func spawn_item(position_item : Vector2):
	var my_rand = randf()
	print(my_rand)
	if my_rand < drop_probabilty && item_power_up_ready:
		item_power_up_ready = false
		item_power_up_timer.start()
		print('item_power_up not ready!')
		var item = item_scene.instantiate()
		item.position = position_item
		get_parent().add_child(item)


func _on_item_power_up_timer_timeout() -> void:
	item_power_up_ready = true
	print('item_power_up ready!')

func reset_position():
	GameManager.started = false
	velocity = Vector2(0,0)
	var player = get_parent().get_node('Player')
	position = player.position - Vector2(0,31)
