extends CharacterBody2D

@export var speed = 400
@onready var spawn_shoot_timer: Timer = $SpawnShootTimer
var bullet_scene = preload("res://scenes/bullet.tscn")

var max_bullet:int = 20
var current_bullet:int = 0

func _ready() -> void:
	GameManager.on_powerup.connect(spawn_bullet)

func _physics_process(delta: float) -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		
	if Input.is_action_pressed("right"):
		velocity.x += speed
	
	move_and_collide(velocity * delta)

func spawn_bullet():
	var left_shoot_instance = bullet_scene.instantiate()
	get_parent().add_child(left_shoot_instance)
	left_shoot_instance.global_position.x = global_position.x - 30
	left_shoot_instance.global_position.y = global_position.y - 20
	
	var right_shoot_instance = bullet_scene.instantiate()
	get_parent().add_child(right_shoot_instance)
	right_shoot_instance.global_position.x = global_position.x + 30
	right_shoot_instance.global_position.y = global_position.y - 20
	
	current_bullet += 2
	if current_bullet <= max_bullet:
		spawn_shoot_timer.start()
	else:
		spawn_shoot_timer.stop()
		current_bullet = 0


func _on_spawn_shoot_time_out() -> void:
	spawn_bullet()
