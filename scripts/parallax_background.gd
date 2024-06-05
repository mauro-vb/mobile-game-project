extends ParallaxBackground

@export var speed := 100

func _process(delta):
	if GameParameters.orientation == 0:
		scroll_offset.x -= speed * delta
	else:
		scroll_offset.x += speed * delta
