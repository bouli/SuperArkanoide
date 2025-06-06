extends Node

var points_resources: PointsResource
var file_name = 'user://points_canvas.tres'

signal on_powerup
var lives: int = 3

var started:bool = false


var record:int = 0
var points:int = 0

func _add_points(value:int):
	points += value
	print("last points: " + str(points))
	get_parent().get_node('Level1').get_node('PointsCanvas').update_points(points)
	_update_record()

func _reset_points():
	points = 0

func _update_record():
	if points > record:
		record = points
		points_resources.record = record
		_save_data()
	get_parent().get_node('Level1').get_node('PointsCanvas').update_record(record)
	print('last record:' + str(record))

func _reset_lives():
	lives = 3 

func _load_data() -> void:
	
	if ResourceLoader.exists(file_name):
		points_resources = ResourceLoader.load(file_name)
		if points_resources is PointsResource: # Check that the data is valid
			print('Data has been loaded!')
			record = points_resources.record
			_update_record()
	else:
		points_resources = PointsResource.new()
		var result = ResourceSaver.save(points_resources, file_name)
		assert(result == OK)
		print('Data has been created!')
		_load_data()

func _save_data() -> void:
	var result = ResourceSaver.save(points_resources, file_name)
	assert(result == OK)
	print('Data has been saved!')
