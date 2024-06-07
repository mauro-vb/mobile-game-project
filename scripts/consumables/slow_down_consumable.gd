extends Consumable

func consume(body):
	if body is Player:
		body.flash("purple",.2,5)
		for platform in get_tree().get_nodes_in_group("platforms"):
			platform.speed = platform.base_speed / 3
		get_parent().pause(2)
		queue_free()
		
		
		#get_tree().call_group("platforms", "destroy")
