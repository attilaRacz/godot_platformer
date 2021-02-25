extends Area2D

var player
var player_in_hazard = false

var hazard_on = false

func activate_hazard():
	hazard_on = true
	if player != null and player_in_hazard:
		player.dead()

func _on_ElectricHazard_area_entered(body):
	print("fos")
	if body.name == 'Player':
		player = body
		player_in_hazard = true
		if hazard_on:
			player.dead()


func _on_ElectricHazard_body_entered(body):
	if body.name == 'Player':
		player = body
		player_in_hazard = true
		if hazard_on:
			player.dead()


func _on_ElectricHazard_body_exited(body):
	player_in_hazard = false
