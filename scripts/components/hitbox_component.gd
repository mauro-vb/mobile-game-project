extends Area2D
class_name HitBoxComponent

@export var health_component : HealthComponent

var invulnerable := false

func damage(damage_amount:int):
	if health_component:
		health_component.damage(damage_amount)



