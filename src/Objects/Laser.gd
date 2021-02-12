extends Area2D

var player
var player_under_beam = false

var laser_on = false

func activate_beam():
	laser_on = true
	if player != null and player_under_beam:
		player.dead()

func deactivate_beam():
	laser_on = false

func _on_Laser_body_entered(body):
	if body.name == 'Player':
		player = body
		player_under_beam = true
		if laser_on:
			player.dead()


func _on_Laser_body_exited(body):
	player_under_beam = false
