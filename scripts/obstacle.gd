extends Node2D
class_name Obstacle

@export var speed := 10
@export var hitbox_component : HitBoxComponent

func _physics_process(_delta):
	position.x -= speed 
	
func _process(_delta):
	if position.x < -200:
		queue_free()
