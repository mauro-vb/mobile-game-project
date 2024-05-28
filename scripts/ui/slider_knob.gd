extends Sprite2D

var pressing := false

@onready var parent = $".."

@export var max_length = 150
@export var deadzone = 25

func _ready():
	max_length *= parent.scale.x

func _process(delta):
	
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= max_length:
			global_position.y = get_global_mouse_position()[1]
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.y = parent.global_position.y + sin(angle)*max_length
	else:
		global_position.y = lerp(global_position.y, parent.global_position.y, delta*100)
		

func calculate_y():
	if abs(global_position.y - parent.global_position.y) > deadzone:
		parent.y_val = (global_position.y - parent.global_position) / max_length


func _on_button_down():
	pressing = true


func _on_button_up():
	pressing = false
