extends SpikedPlatform

func _process(_delta):
	if position.x < -1000:
		queue_free()
