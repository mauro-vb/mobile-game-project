extends Node2D
class_name CustomSLider


@onready var knob = $Knob

var y_val: float

@export var max_length = 150
@export var deadzone = 0.1

func _process(delta):
	# Adjust transparency based on pressing state
	if knob.pressing:
		self.modulate.a = 0.4 
	else:
		self.modulate.a = 1

func normalize_player_y(player_y: float) -> float:
	return (player_y - (GameParameters.WINDOW_HEIGHT / 2)) / (GameParameters.WINDOW_HEIGHT / 2)

func apply_deadzone(value: float, deadzone: float) -> float:
	if abs(value) < deadzone:
		return 0
	return value

func smooth_control(player_y: float, direction: int) -> bool:
	var normalized_player_y = normalize_player_y(player_y)
	var max_up = y_val <= -.95
	var max_down = y_val >= .95
	if direction > 0:
		# For smooth_control_up
		return max_up or (y_val - deadzone < normalized_player_y and not max_down)
	else:
		# For smooth_control_down
		return max_down or (
			y_val + deadzone > normalized_player_y and not max_up)

func smooth_control_up(player_y: float) -> bool:
	return smooth_control(player_y, 1)

func smooth_control_down(player_y: float) -> bool:
	return smooth_control(player_y, -1)
