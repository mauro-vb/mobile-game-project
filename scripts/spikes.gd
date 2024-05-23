extends Area2D
class_name Spikes

@export var damage = 1




func _on_body_entered(body):
	body.hurt()
