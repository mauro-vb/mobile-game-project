extends Control

@onready var up_button = $VBoxContainer/UpButton
@onready var down_button = $VBoxContainer/DownButton

var up_pressing := false
var down_pressing := false

func _ready():
	up_button.button_down.connect(_on_up_button_down)
	up_button.button_up.connect(_on_up_button_up)
	
	down_button.button_down.connect(_on_down_button_down)
	down_button.button_up.connect(_on_down_button_up)

func _process(delta):
	print(up_pressing)
	
func _on_up_button_down() -> void:
	up_pressing = true

func _on_up_button_up()-> void:
	up_pressing = false
	
func _on_down_button_down()-> void:
	down_pressing = true


func _on_down_button_up() -> void:
	down_pressing = false
