extends SpikedPlatform

var top_or_bot : String 

func _ready():
	super()
	if with_consumable:
		var sep = 190
		var h = preload("res://scenes/consumables/consumable.tscn").instantiate()
		h.position = Vector2(-170, sep if top_or_bot=="bot" else -sep)
		h.base_speed = 0
		add_child(h)
		

func _process(_delta):
	if position.x < -800:
		missed.emit()
		queue_free()
		
