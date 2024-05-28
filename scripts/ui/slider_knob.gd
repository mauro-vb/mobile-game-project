extends Sprite2D

var pressing := false

@onready var parent = $".."

func _ready():
	parent.max_length *= parent.scale.x

func _process(delta):
	parent.y_val = (global_position.y - parent.global_position.y) / parent.max_length
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= parent.max_length:
			global_position.y = get_global_mouse_position()[1]
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.y = parent.global_position.y + sin(angle)*parent.max_length
	else:
		global_position.y = lerp(global_position.y, parent.global_position.y, delta*100)
		

func _on_button_down():
	pressing = true


func _on_button_up():
	pressing = false
