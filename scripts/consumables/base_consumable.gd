extends Node2D
class_name Consumable

@export var area : Area2D
@export var base_speed := 7
@export var base_amplitude := 0

var speed
var time_passed := 0.0

func _ready():
	if GameParameters.orientation == 1:
		rotation_degrees = 90
	speed = base_speed
	area.body_entered.connect(consume)

func _physics_process(delta):
	time_passed += delta  # Increment time_passed by delta each frame
	position.x -= speed  # Move left at a constant speed
	position.y += base_amplitude * cos(time_passed)  # Oscillate up and down

func consume(body):
	if body is Player:
		body.health.heal(1)
		queue_free()
