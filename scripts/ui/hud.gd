extends Control

@onready var container = $PanelContainer
var WIDTH = GameParameters.WINDOW_WIDTH
var HEIGHT = GameParameters.WINDOW_HEIGHT

func _ready():
	if GameParameters.orientation == 1:
		container.rotation_degrees = 90
		container.size = Vector2(HEIGHT, WIDTH)
		container.position.x = GameParameters.WINDOW_WIDTH
	elif GameParameters.orientation == 0:
		container.rotation_degrees = 0
		container.size = Vector2(WIDTH, HEIGHT)
		container.position.x = 0

