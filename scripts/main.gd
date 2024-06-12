extends Node2D

@onready var player = $Player
var slider_y_pos := 150
var slider_scale := 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	player.health.health_depleted.connect(game_over)
	if GameParameters.orientation == 1:
		rotation_degrees = 180
		position = Vector2(GameParameters.WINDOW_WIDTH, GameParameters.WINDOW_HEIGHT)
		player.rotation_degrees=90
	if GameParameters.CONTROLS_TYPE == "slider":
		var slider = preload("res://scenes/ui/slider.tscn").instantiate()
		slider.scale = Vector2(slider_scale,slider_scale)
		slider.global_position = Vector2(GameParameters.WINDOW_WIDTH - slider_y_pos, GameParameters.WINDOW_HEIGHT / 2)
		if GameParameters.orientation == 1:
			slider.global_position = Vector2(slider_y_pos, GameParameters.WINDOW_HEIGHT / 2)
		add_child(slider)
		player.slider = slider
	if GameParameters.CONTROLS_TYPE == "buttons":
		var buttons = preload("res://scenes/ui/tap_areas.tscn").instantiate()
		add_child(buttons)
		player.buttons = buttons

func game_over():
	await get_tree().create_timer(.5).timeout
	get_tree().change_scene_to_file("res://scenes/ui/temp_menu.tscn")
