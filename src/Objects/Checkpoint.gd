extends Area2D

onready var animation_player = $AnimationPlayer

func _on_Checkpoint_body_shape_entered(body_id, body, body_shape, area_shape):
	animation_player.play("save_checkpoint")
	if body.name == 'Player':
		body.hit_checkpoint()
