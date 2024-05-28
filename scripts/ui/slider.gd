extends Node2D



@onready var knob = $Knob

var y_val:float

@export var max_length = 150
@export var deadzone = .3

func _process(delta):
	if knob.pressing:
		self.modulate[3] = 0.4 
	else:
		self.modulate[3] = 1
