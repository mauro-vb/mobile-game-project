extends Control

@onready var play = $PanelContainer/HBoxContainer/Button
@onready var slider = $PanelContainer/HBoxContainer/VBoxContainer/Button
@onready var buttons = $PanelContainer/HBoxContainer/VBoxContainer/Button2
@onready var orientation = $PanelContainer/HBoxContainer/OrientationButton

@onready var container = $PanelContainer

func _ready():
	buttons.pressed.connect(set_buttons)
	slider.pressed.connect(set_slider)
	play.pressed.connect(start_game)
	
	orientation.pressed.connect(change_orientation)

func set_buttons():
	GameParameters.CONTROLS_TYPE = "buttons"
	
func set_slider():
	GameParameters.CONTROLS_TYPE = "slider"

func start_game():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func change_orientation() -> void:
	if GameParameters.orientation == 0:
		GameParameters.orientation = 1
		container.rotation_degrees = 90
		container.size = Vector2(container.size[1], container.size[0])
		container.position.x = GameParameters.WINDOW_WIDTH
	elif GameParameters.orientation == 1:
		GameParameters.orientation = 0
		container.rotation_degrees = 0
		container.size = Vector2(container.size[1], container.size[0])
		container.position.x = 0
