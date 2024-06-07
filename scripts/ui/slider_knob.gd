extends Sprite2D

var pressing := false
@onready var button = $"../Button"
@onready var parent = $".."

func _ready() -> void:
	button.button_down.connect(_on_button_down)
	button.button_up.connect(_on_button_up)
	parent.max_length *= parent.scale.x

func _process(_delta) -> void:
	parent.y_val = (global_position.y - parent.global_position.y) / parent.max_length
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= parent.max_length:
			global_position.y = get_global_mouse_position()[1]
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.y = parent.global_position.y + sin(angle)*parent.max_length
	else:
		pass
		#global_position.y = lerp(global_position.y, parent.global_position.y, delta*100)
		

func _on_button_down() -> void:
	pressing = true


func _on_button_up() -> void:
	pressing = false
