extends SpikedPlatform


func _ready():
	super()
	if with_consumable:
		var sep = 250
		var h = preload("res://scenes/consumables/consumable.tscn").instantiate()
		h.position = Vector2(-20, sep if randf() >=.5 else -sep)
		h.base_speed = 0
		add_child(h)
