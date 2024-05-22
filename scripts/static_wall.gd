extends Obstacle
class_name StaticWall

#var size : Vector2

func _ready():
	var size = Vector2(500,randi_range(50, 200))
	$HitBoxComponent/CollisionShape2D.shape.size = size
	#$Sprite2D.

func _process(delta):
	super(delta)

func _physics_process(delta):
	super(delta)

func _on_health_component_health_depleted():
	queue_free()
