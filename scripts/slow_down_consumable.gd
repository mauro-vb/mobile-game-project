extends Consumable

func consumed(body):
	if body is Player:
		body.flash("green",1.0)
