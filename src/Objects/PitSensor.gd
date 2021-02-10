extends Area2D



func _on_PitSensor_body_entered(body):
	if body is Player:
		Game.kill_player()
