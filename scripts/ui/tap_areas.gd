extends Control

@onready var up_button = $VBoxContainer/UpButton
@onready var down_button = $VBoxContainer/DownButton
@onready var up_arrow = $VBoxContainer/UpButton/UpArrow if GameParameters.orientation == 0 else $VBoxContainer/UpButton/UpArrow2
@onready var down_arrow = $VBoxContainer/DownButton/DownArrow if GameParameters.orientation == 0 else $VBoxContainer/DownButton/DownArrow2
var up_pressing := false
var down_pressing := false


func _ready():
	if GameParameters.orientation == 1:
		up_button.size_flags_stretch_ratio = down_button.size_flags_stretch_ratio
		$VBoxContainer.position.x = 0
	
	up_button.button_down.connect(_on_up_button_down)
	up_button.button_up.connect(_on_up_button_up)
	
	down_button.button_down.connect(_on_down_button_down)
	down_button.button_up.connect(_on_down_button_up)
	up_arrow.self_modulate = Color(1,1,1,.35)
	down_arrow.self_modulate = Color(1,1,1,.35)
	
func _process(_delta):
	if up_pressing:
		up_arrow.self_modulate = Color(1,1,1,.6)
	else:
		up_arrow.self_modulate = Color(1,1,1,.35)
	if down_pressing:
		down_arrow.self_modulate = Color(1,1,1,.6)
	else:
		down_arrow.self_modulate = Color(1,1,1,.35)
	
func _on_up_button_down() -> void:
	up_pressing = true

func _on_up_button_up()-> void:
	up_pressing = false
	
func _on_down_button_down()-> void:
	down_pressing = true


func _on_down_button_up() -> void:
	down_pressing = false
