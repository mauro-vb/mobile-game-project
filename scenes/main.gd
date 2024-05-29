extends Node2D

@onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameParameters.CONTROLS_TYPE == "slider":
		var slider = preload("res://scenes/ui/slider.tscn").instantiate()
		slider.scale = Vector2(2,2)
		slider.global_position = Vector2(GameParameters.WINDOW_WIDTH - 120, GameParameters.WINDOW_HEIGHT / 2)
		add_child(slider)
		player.slider = slider
	if GameParameters.CONTROLS_TYPE == "buttons":
		var buttons = preload("res://scenes/ui/tap_areas.tscn").instantiate()
		add_child(buttons)
		player.buttons = buttons
