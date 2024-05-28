extends HBoxContainer

enum MODES {simple, empty, partial}

var heart_full = preload("res://assets/icons/heart-full.png")
var heart_empty = preload("res://assets/icons/heart-broken.png")
var heart_half = preload("res://assets/icons/heart-half.png")
@onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	player.health.health_changed.connect(update_health)

func update_health():
	var value = player.health.health
	for i in get_child_count():
		if value > i * 2 + 1:
			get_child(i).texture = heart_full
		elif value > i * 2:
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty
