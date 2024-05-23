extends Obstacle
class_name Consumable

var size : Vector2

func _process(delta):
	super(delta)
	# TODO : Add fluctuating movement

func _physics_process(delta):
	super(delta)

func _on_health_component_health_depleted():
	queue_free()
