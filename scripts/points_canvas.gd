extends CanvasLayer

@export var label_points: String = "Points"
@export var label_record: String = "Record"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_points(points: int):
	$LabelPoints.text = label_points + ': '+ str(points)

func update_record(points: int):
	$LabelRecord.text = label_record + ': '+ str(points)
