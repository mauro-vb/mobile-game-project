extends Obstacle
class_name StaticWall


func _process(delta):
	super(delta)

func _physics_process(delta):
	super(delta)

func _on_health_component_health_depleted():
	queue_free()
