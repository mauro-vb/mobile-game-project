extends SpikedPlatform

@export var chase_speed: int = 2

@onready var player = get_tree().get_nodes_in_group("player")[0]

var delay = 15

func _ready():
	super()
	if with_consumable:
		var sep = 75
		var h = preload("res://scenes/consumables/consumable.tscn").instantiate()
		h.position = Vector2(0, sep if randf() >=.5 else -sep)
		h.base_speed = 0
		add_child(h)

func _physics_process(_delta):
	#var decelerate = func(): velocity.y = lerp(velocity.y, 0.0, .05)
	super(_delta)
	var player_y = player.position.y 
	
	
	if player_y + delay > position.y:
		position.y += chase_speed
	if player_y + delay < position.y:
		position.y -= chase_speed
