extends Area2D


var laser_on = false

func activate_beam():
	laser_on = true

func deactivate_beam():
	laser_on = false

func _on_Laser_body_entered(body):
	if body.name == 'Player':
		if laser_on:
			body.dead()
