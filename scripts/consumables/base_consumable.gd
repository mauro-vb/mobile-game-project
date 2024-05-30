extends Node2D
class_name Consumable

@export var area : Area2D
@export var base_speed := 5
@export var base_amplitude := 0

var speed
var time_passed := 0.0

signal consumed

func _ready():
	speed = base_speed
	area.body_entered.connect(consume)

func _physics_process(delta):
	time_passed += delta  # Increment time_passed by delta each frame
	position.x -= speed  # Move left at a constant speed
	position.y += base_amplitude * cos(time_passed)  # Oscillate up and down

func consume(body):
	if body is Player:
		consumed.emit()
