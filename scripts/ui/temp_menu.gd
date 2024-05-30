extends Control

@onready var play = $PanelContainer/HBoxContainer/Button
@onready var slider = $PanelContainer/HBoxContainer/VBoxContainer/Button
@onready var buttons = $PanelContainer/HBoxContainer/VBoxContainer/Button2
# Called when the node enters the scene tree for the first time.
func _ready():
	buttons.pressed.connect(set_buttons)
	slider.pressed.connect(set_slider)
	
	play.pressed.connect(start_game)

func set_buttons():
	GameParameters.CONTROLS_TYPE = "buttons"
	
func set_slider():
	GameParameters.CONTROLS_TYPE = "slider"

func start_game():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
