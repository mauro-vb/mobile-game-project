extends Control

@onready var play = $PanelContainer/VBoxContainer/HBoxContainer/Button
@onready var slider = $PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button
@onready var buttons = $PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button2
@onready var orientation = $PanelContainer/VBoxContainer/HBoxContainer/OrientationButton

@onready var container = $PanelContainer
@onready var score_label = $PanelContainer/VBoxContainer/Label
func _ready():
	buttons.pressed.connect(set_buttons)
	slider.pressed.connect(set_slider)
	play.pressed.connect(start_game)
	
	score_label.text = "Previous Score: %s " % GameParameters.LastScore
	
	orientation.pressed.connect(change_orientation)
	if GameParameters.CONTROLS_TYPE == "buttons":
		buttons.self_modulate = Color("#89CFF0")
	if GameParameters.CONTROLS_TYPE == "slider":
		slider.self_modulate = Color("#89CFF0")
		
	if GameParameters.orientation == 0:
		pass
		container.rotation_degrees = 0
		container.size = Vector2(GameParameters.WINDOW_WIDTH, GameParameters.WINDOW_HEIGHT)
		container.position = Vector2(0,0)
		
	elif GameParameters.orientation == 1:
		container.rotation_degrees = -90
		container.size = Vector2(GameParameters.WINDOW_HEIGHT, GameParameters.WINDOW_WIDTH)
		container.position.y = GameParameters.WINDOW_HEIGHT

func set_buttons():
	GameParameters.CONTROLS_TYPE = "buttons"
	buttons.self_modulate = Color("#89CFF0")
	slider.self_modulate = Color("white")
	
func set_slider():
	GameParameters.CONTROLS_TYPE = "slider"
	slider.self_modulate = Color("#89CFF0")
	buttons.self_modulate = Color("white")
	
	
func start_game():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func change_orientation() -> void:
	if GameParameters.orientation == 0:
		GameParameters.orientation = 1
		container.rotation_degrees = -90
		container.size = Vector2(container.size[1], container.size[0])
		container.position.y = GameParameters.WINDOW_HEIGHT
	elif GameParameters.orientation == 1:
		GameParameters.orientation = 0
		container.rotation_degrees = 0
		container.size = Vector2(container.size[1], container.size[0])
		container.position = Vector2(0,0)
