extends Sprite2D

var color_tween = create_tween()

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees = randi()
