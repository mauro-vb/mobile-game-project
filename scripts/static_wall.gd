extends Obstacle


# Called when the node enters the scene tree for the first time.
func _ready():
	var random_size = func(): return randi_range(50, 150)
	$HitBoxComponent/CollisionShape2D.shape.size = Vector2(random_size.call(),random_size.call())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func _physics_process(delta):
	super(delta)
