extends Area2D


func _on_Checkpoint_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name == 'Player':
		body.hit_checkpoint()
