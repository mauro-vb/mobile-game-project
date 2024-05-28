extends Node2D

var y_val:float

@onready var knob = $Knob

func _process(delta):
	if knob.pressing:
		self.modulate[3] = 0.4 
	else:
		self.modulate[3] = 1
