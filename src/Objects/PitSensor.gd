extends Area2D



func _on_PitSensor_body_entered(body):
	if body is Player:
		print(State.play_from_start_of_stage)
		if State.play_from_start_of_stage:
			State.move_to_level(State.current_level)
		else:
			State.play_from_last_checkpoint()
