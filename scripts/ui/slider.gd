extends Node2D
class_name CustomSLider

@onready var knob = $Knob

signal joystick_moved

var y_val: float : 
	set(value):
		if abs(y_val - value) > .01 : # If movement is significant
			joystick_moved.emit()
		y_val = value

var slider_is_still : bool # necessary to smooth input
var inactivity_timer := 0.0
var inactivity_threshold := 1.0

@export var max_length = 150
@export var threshold = 0.1

func _ready():
	joystick_moved.connect(moved)
	
func _process(delta):
	inactivity_timer += delta
	# Adjust transparency based on pressing state
	if knob.pressing:
		self.modulate.a = 0.4
	else:
		self.modulate.a = 1
		
	if inactivity_timer >= inactivity_threshold:
		slider_is_still = true


func normalize_player_y(player_y: float) -> float:
	return (player_y - (GameParameters.WINDOW_HEIGHT / 2)) / (GameParameters.WINDOW_HEIGHT / 2)


func smooth_control(player_y: float, direction: int) -> bool:
	var normalized_player_y = normalize_player_y(player_y)
	var max_up = y_val <= -.95
	var max_down = y_val >= .95
	if slider_is_still: # Don't move player if slider is still
		return false
	if direction > 0:
		# For smooth_control_up
		return max_up or (
			y_val - threshold < normalized_player_y and not max_down)
	else:
		# For smooth_control_down
		return max_down or (
			y_val + threshold > normalized_player_y and not max_up)

func smooth_control_up(player_y: float) -> bool:
	return smooth_control(player_y, 1)

func smooth_control_down(player_y: float) -> bool:
	return smooth_control(player_y, -1)

func moved():
	slider_is_still = false
	inactivity_timer = 0.0
